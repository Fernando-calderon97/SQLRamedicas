from pdf2image import convert_from_path
import matplotlib.pyplot as plt

ruta_pdf = r"G:\Mi unidad\CODIGOS\Prueba division Documentos\DocumentosOrigen\ArreglarManualmente_9.pdf"

imagenes = convert_from_path(
    ruta_pdf,
    dpi=300,
    first_page=2,
    last_page=2
)

img = imagenes[0]

plt.figure(figsize=(10, 14))
plt.imshow(img)
plt.axis("on")
plt.grid(color="red", linestyle="--", linewidth=0.5)
plt.show()