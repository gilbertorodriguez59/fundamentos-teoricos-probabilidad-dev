from pathlib import Path

CAPITULOS = {
    "01-incertidumbre-modelos.qmd": ("01-incertidumbre-probabilidad-colab.ipynb", "01-incertidumbre-probabilidad.Rmd"),
    "02-espacios-eventos.qmd": ("02-espacios-eventos-colab.ipynb", "02-espacios-eventos.Rmd"),
    "03-conteo-probabilidad.qmd": ("03-conteo-probabilidad-colab.ipynb", "03-conteo-probabilidad.Rmd"),
    "04-axiomas-probabilidad.qmd": ("04-axiomas-probabilidad-colab.ipynb", "04-axiomas-probabilidad.Rmd"),
    "05-condicional-independencia.qmd": ("05-condicional-independencia-colab.ipynb", "05-condicional-independencia.Rmd"),
    "06-probabilidad-total-bayes.qmd": ("06-probabilidad-total-bayes-colab.ipynb", "06-probabilidad-total-bayes.Rmd"),
    "07-variable-aleatoria-cdf.qmd": ("07-variable-aleatoria-cdf-colab.ipynb", "07-variable-aleatoria-cdf.Rmd"),
    "08-variables-discretas-pmf.qmd": ("08-variables-discretas-pmf-colab.ipynb", "08-variables-discretas-pmf.Rmd"),
    "09-variables-continuas-densidad.qmd": ("09-variables-continuas-densidad-colab.ipynb", "09-variables-continuas-densidad.Rmd"),
    "10-esperanza-varianza-chebyshev.qmd": ("10-esperanza-varianza-chebyshev-colab.ipynb", "10-esperanza-varianza-chebyshev.Rmd"),
    "11-distribuciones-discretas-especiales.qmd": ("11-distribuciones-discretas-especiales-colab.ipynb", "11-distribuciones-discretas-especiales.Rmd"),
}

BASE = "https://github.com/gilbertorodriguez59/introduccion-probabilidad-r-geogebra-dev"
COLAB = "https://colab.research.google.com/github/gilbertorodriguez59/introduccion-probabilidad-r-geogebra-dev/blob/main/notebooks/"

for archivo, (nb, rmd) in CAPITULOS.items():
    path = Path(archivo)
    if not path.exists():
        print(f"No existe: {archivo}")
        continue
    texto = path.read_text(encoding="utf-8")
    if "## Materiales complementarios del capítulo" in texto:
        print(f"Ya contiene tabla: {archivo}")
        continue

    tabla = f'''## Materiales complementarios del capítulo

| Material | Formato | Acceso | Propósito |
|---|---|---|---|
| Cuaderno de Google Colab | Notebook interactivo (R) | [Abrir en Colab]({COLAB}{nb}) | Explorar computacionalmente los conceptos del capítulo en el volumen aplicado. |
| Cuaderno de R | R Markdown | [Abrir cuaderno R]({BASE}/blob/main/cuadernos-r/{rmd}) | Reproducir ejemplos y verificaciones numéricas en R/RStudio. |
| Presentación | PDF / PPT | Próximamente | Se incorporará cuando se proporcionen los enlaces. |
| Video | Video | Próximamente | Explicación audiovisual complementaria. |
| Infografía | Imagen / PDF | Próximamente | Síntesis visual de conceptos y resultados principales. |

Los cuadernos computacionales se alojan en **Introducción a la Probabilidad con R y GeoGebra** y sirven como apoyo práctico de este desarrollo teórico. Las presentaciones, videos e infografías se incorporarán en esta misma tabla cuando estén disponibles.

'''

    marca = "## Referencias del capítulo"
    if marca in texto:
        texto = texto.replace(marca, tabla + marca, 1)
    else:
        texto = texto.rstrip() + "\n\n" + tabla
    path.write_text(texto, encoding="utf-8")
    print(f"Tabla insertada: {archivo}")
