import os
import re
import cv2
import numpy as np
import pytesseract
from PIL import Image
from pdf2image import convert_from_path
from PyPDF2 import PdfReader, PdfWriter

pytesseract.pytesseract.tesseract_cmd = r"C:\Program Files\Tesseract-OCR\tesseract.exe"
# pytesseract.pytesseract.tesseract_cmd = r"C:\Users\oscar.parra\OCR\tesseract.exe"

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
ORIGEN = os.path.join(BASE_DIR, "DocumentosOrigen")
DESTINO = os.path.join(BASE_DIR, "DocumentosDestino")

recortes = [
    (2050, 290, 2440, 360),
    (2040, 400, 2420, 480),
    (2000, 490, 2410, 560),
    (2040, 320, 2410, 400),
    (2000, 240, 2410, 320),
    (2000, 260, 2350, 320),
    (1950, 340, 2300, 380),
]

os.makedirs(DESTINO, exist_ok=True)


def preprocesar_zona(zona: Image.Image) -> Image.Image:
    img = np.array(zona)
    gris = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
    escala = 2
    alto, ancho = gris.shape
    gris = cv2.resize(gris, (ancho * escala, alto * escala), interpolation=cv2.INTER_CUBIC)
    binaria = cv2.adaptiveThreshold(
        gris, 255,
        cv2.ADAPTIVE_THRESH_GAUSSIAN_C,
        cv2.THRESH_BINARY,
        31, 10
    )
    limpia = cv2.medianBlur(binaria, 3)
    return Image.fromarray(limpia)


def extraer_texto(zona: Image.Image) -> str | None:
    zona_procesada = preprocesar_zona(zona)
    configs = [
        "--psm 7 -c tessedit_char_whitelist=REPF0123456789",
        "--psm 6 -c tessedit_char_whitelist=REPF0123456789",
        "--psm 7",
    ]
    for cfg in configs:
        texto = pytesseract.image_to_string(zona_procesada, config=cfg)
        texto = (
            texto.upper()
            .replace(" ", "").replace("-", "")
            .replace("*", "").replace("\n", "")
            .replace("O", "0")
            .replace("I", "1")
            .replace("L", "1")
        )
        match = re.search(r'(RE|PF)\d{9,13}', texto)
        if match:
            return match.group()
    return None


def extraer_codigo_texto_embebido(ruta_pdf: str) -> str | None:
    """Intenta extraer el código directamente del texto del PDF sin OCR."""
    try:
        reader = PdfReader(ruta_pdf)
        if len(reader.pages) >= 2:
            texto = reader.pages[1].extract_text() or ""
            texto = texto.upper().replace(" ", "").replace("-", "")
            match = re.search(r'(RE|PF)\d{9,13}', texto)
            if match:
                return match.group()
    except Exception:
        pass
    return None


def extraer_codigo_ocr(ruta_pdf: str) -> str | None:
    """Extrae el código usando OCR sobre la página 2 del PDF."""
    imagenes = convert_from_path(ruta_pdf, dpi=300, first_page=2, last_page=2)
    if not imagenes:
        return None
    imagen = imagenes[0]
    for recorte in recortes:
        zona = imagen.crop(recorte)
        codigo = extraer_texto(zona)
        if codigo:
            return codigo
    return None


for archivo in os.listdir(ORIGEN):
    if not archivo.lower().endswith(".pdf"):
        continue

    ruta_pdf = os.path.join(ORIGEN, archivo)

    try:
        # Primero intenta sin OCR (más rápido y confiable)
        codigo = extraer_codigo_texto_embebido(ruta_pdf)

        if codigo:
            print(f"Código extraído sin OCR: {codigo}")
        else:
            # Si no funciona, usa OCR
            codigo = extraer_codigo_ocr(ruta_pdf)
            if codigo:
                print(f"Código extraído con OCR: {codigo}")

        if not codigo:
            raise ValueError("Código no detectado")

        reader = PdfReader(ruta_pdf)
        for i, page in enumerate(reader.pages, start=1):
            writer = PdfWriter()
            writer.add_page(page)
            salida = os.path.join(DESTINO, f"{codigo}-{i}.pdf")
            with open(salida, "wb") as f:
                writer.write(f)

        print(f"Procesado correctamente: {archivo}")

    except Exception as e:
        print(f"Error en {archivo}: {e}")
        nuevo_nombre = f"ArreglarManualmente_{archivo}"
        ruta_nueva = os.path.join(ORIGEN, nuevo_nombre)
        if not os.path.exists(ruta_nueva):
            os.rename(ruta_pdf, ruta_nueva)
            print(f"Marcado para revisión manual: {nuevo_nombre}")