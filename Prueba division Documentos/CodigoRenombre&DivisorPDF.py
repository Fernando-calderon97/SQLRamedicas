import os
import re
import pytesseract
from pdf2image import convert_from_path
from PyPDF2 import PdfReader, PdfWriter
import matplotlib.pyplot as plt

pytesseract.pytesseract.tesseract_cmd = r"C:\OCR\tesseract.exe"

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

ORIGEN = os.path.join(BASE_DIR, "DocumentosOrigen")
DESTINO = os.path.join(BASE_DIR, "DocumentosDestino")

RECORTE = (2500, 485, 3300, 600) 

os.makedirs(DESTINO, exist_ok=True)

for archivo in os.listdir(ORIGEN):
    if not archivo.lower().endswith(".pdf"):
        continue

    ruta_pdf = os.path.join(ORIGEN, archivo)

    try:
        imagen = convert_from_path(
            ruta_pdf,
            dpi=300,
            first_page=2,
            last_page=2
        )[0]

        zona = imagen.crop(RECORTE)

        # Estos plt son para verifacr el recorte del REF
        plt.imshow(zona)
        plt.axis("off")
        plt.title(f"Recorte OCR - {archivo}")
        plt.show()

        texto = pytesseract.image_to_string(
            zona,
            config="--psm 7 -c tessedit_char_whitelist=RE0123456789"
        )

        texto = texto.replace(" ", "").strip()
        # print("OCR crudo:", repr(texto))

        match = re.search(r'(PF)\d{9,13}', texto)

        if not match:
            raise ValueError("Código RE no detectado")

        nombre_base = match.group()

        reader = PdfReader(ruta_pdf)

        for i, page in enumerate(reader.pages, start=1):
            writer = PdfWriter()
            writer.add_page(page)

            salida = os.path.join(DESTINO, f"{nombre_base}-{i}.pdf")
            with open(salida, "wb") as f:
                writer.write(f)

        # print(f"Procesado correctamente: {archivo}")

    except Exception as e:
        print(f"Error en {archivo}: {e}")
        nuevo_nombre = f"ArreglarManualmente_{archivo}"
        ruta_nueva = os.path.join(ORIGEN, nuevo_nombre)

        if not os.path.exists(ruta_nueva):
            os.rename(ruta_pdf, ruta_nueva)
            print(f"Marcado para revisión manual: {nuevo_nombre}")
        else:
            print("Ya existe el archivo marcado")