local capitulos={
 ["incertidumbre y modelos probabilísticos"]={c="01-incertidumbre-probabilidad-colab.ipynb",r="01-incertidumbre-probabilidad.Rmd"},
 ["espacios muestrales y álgebra de eventos"]={c="02-espacios-eventos-colab.ipynb",r="02-espacios-eventos.Rmd"},
 ["técnicas de conteo y enumeración"]={c="03-conteo-probabilidad-colab.ipynb",r="03-conteo-probabilidad.Rmd"},
 ["axiomas y propiedades de la probabilidad"]={c="04-axiomas-probabilidad-colab.ipynb",r="04-axiomas-probabilidad.Rmd"},
 ["probabilidad condicional e independencia"]={c="05-condicional-independencia-colab.ipynb",r="05-condicional-independencia.Rmd"},
 ["particiones, probabilidad total y teorema de bayes"]={c="06-probabilidad-total-bayes-colab.ipynb",r="06-probabilidad-total-bayes.Rmd"},
 ["variable aleatoria y función de distribución acumulada"]={c="07-variable-aleatoria-cdf-colab.ipynb",r="07-variable-aleatoria-cdf.Rmd"},
 ["variables aleatorias discretas y función de masa de probabilidad"]={c="08-variables-discretas-pmf-colab.ipynb",r="08-variables-discretas-pmf.Rmd"},
 ["variables aleatorias continuas y función de densidad"]={c="09-variables-continuas-densidad-colab.ipynb",r="09-variables-continuas-densidad.Rmd"}
}

local function title(doc)
 for _,b in ipairs(doc.blocks) do
  if b.t=="Header" and b.level==1 then return pandoc.utils.stringify(b.content):lower() end
 end
 return nil
end

local function bloques(cfg)
 local colab="https://colab.research.google.com/github/gilbertorodriguez59/introduccion-probabilidad-r-geogebra-dev/blob/main/notebooks/"..cfg.c
 local rurl="https://github.com/gilbertorodriguez59/introduccion-probabilidad-r-geogebra-dev/blob/main/cuadernos-r/"..cfg.r
 local md=string.format([[## Materiales complementarios del capítulo

| Material | Formato | Acceso | Propósito |
|---|---|---|---|
| Cuaderno de Google Colab | Notebook interactivo (R) | [Abrir en Colab](%s) | Explorar computacionalmente los conceptos del capítulo en el volumen aplicado. |
| Cuaderno de R | R Markdown | [Abrir cuaderno R](%s) | Reproducir ejemplos y verificaciones numéricas en R/RStudio. |
| Presentación | PDF / PPT | Próximamente | Se incorporará cuando se proporcionen los enlaces. |
| Video | Video | Próximamente | Explicación audiovisual complementaria. |
| Infografía | Imagen / PDF | Próximamente | Síntesis visual de conceptos y resultados principales. |

Los cuadernos computacionales se alojan en el volumen **Introducción a la Probabilidad con R y GeoGebra** y sirven como apoyo práctico de este desarrollo teórico.
]],colab,rurl)
 return pandoc.read(md,"markdown").blocks
end

function Pandoc(doc)
 local cfg=capitulos[title(doc)]
 if not cfg then return doc end
 local extra=bloques(cfg); local out={}; local ins=false
 for _,b in ipairs(doc.blocks) do
  if not ins and b.t=="Header" and pandoc.utils.stringify(b.content):lower():match("referencias del capítulo") then
   for _,x in ipairs(extra)do table.insert(out,x)end
   ins=true
  end
  table.insert(out,b)
 end
 if not ins then for _,x in ipairs(extra)do table.insert(out,x)end end
 doc.blocks=out
 return doc
end
