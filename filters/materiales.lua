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

local function clean(s)
 if not s then return nil end
 return pandoc.utils.stringify(s):lower():gsub("^%s+", ""):gsub("%s+$", "")
end

local function title(doc)
 local mt=clean(doc.meta and doc.meta.title)
 if mt and capitulos[mt] then return mt end
 for _,b in ipairs(doc.blocks) do
  if b.t=="Header" and b.level==1 then
   local ht=clean(b.content)
   if ht and capitulos[ht] then return ht end
  end
 end
 return mt
end

local function already(doc)
 for _,b in ipairs(doc.blocks) do
  if b.t=="Header" and clean(b.content)=="materiales complementarios del capítulo" then return true end
 end
 return false
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
 if already(doc) then return doc end
 local cfg=capitulos[title(doc)]
 if not cfg then return doc end
 local extra=bloques(cfg); local out={}; local ins=false
 for _,b in ipairs(doc.blocks) do
  if not ins and b.t=="Header" and clean(b.content)=="referencias del capítulo" then
   for _,x in ipairs(extra)do table.insert(out,x)end
   ins=true
  end
  table.insert(out,b)
 end
 if not ins then for _,x in ipairs(extra)do table.insert(out,x)end end
 doc.blocks=out
 return doc
end
