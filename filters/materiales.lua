local capitulos={
 ["01-incertidumbre-modelos.qmd"]="01-incertidumbre-probabilidad-colab.ipynb",
 ["02-espacios-eventos.qmd"]="02-espacios-eventos-colab.ipynb",
 ["03-conteo-probabilidad.qmd"]="03-conteo-probabilidad-colab.ipynb",
 ["04-axiomas-probabilidad.qmd"]="04-axiomas-probabilidad-colab.ipynb",
 ["05-condicional-independencia.qmd"]="05-condicional-independencia-colab.ipynb",
 ["06-probabilidad-total-bayes.qmd"]="06-probabilidad-total-bayes-colab.ipynb",
 ["07-variable-aleatoria-cdf.qmd"]="07-variable-aleatoria-cdf-colab.ipynb",
 ["08-variables-discretas-pmf.qmd"]="08-variables-discretas-pmf-colab.ipynb",
 ["09-variables-continuas-densidad.qmd"]="09-variables-continuas-densidad-colab.ipynb"
}
local rfiles={
 ["01-incertidumbre-modelos.qmd"]="01-incertidumbre-probabilidad.Rmd",
 ["02-espacios-eventos.qmd"]="02-espacios-eventos.Rmd",
 ["03-conteo-probabilidad.qmd"]="03-conteo-probabilidad.Rmd",
 ["04-axiomas-probabilidad.qmd"]="04-axiomas-probabilidad.Rmd",
 ["05-condicional-independencia.qmd"]="05-condicional-independencia.Rmd",
 ["06-probabilidad-total-bayes.qmd"]="06-probabilidad-total-bayes.Rmd",
 ["07-variable-aleatoria-cdf.qmd"]="07-variable-aleatoria-cdf.Rmd",
 ["08-variables-discretas-pmf.qmd"]="08-variables-discretas-pmf.Rmd",
 ["09-variables-continuas-densidad.qmd"]="09-variables-continuas-densidad.Rmd"
}
local function base(p)return p:match("([^/\\]+)$")or p end
local function bloques(name)
 local c=capitulos[name]; if not c then return {} end
 local colab="https://colab.research.google.com/github/gilbertorodriguez59/introduccion-probabilidad-r-geogebra-dev/blob/main/notebooks/"..c
 local rurl="https://github.com/gilbertorodriguez59/introduccion-probabilidad-r-geogebra-dev/blob/main/cuadernos-r/"..rfiles[name]
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
 if not PANDOC_STATE.input_files or #PANDOC_STATE.input_files==0 then return doc end
 local name=base(PANDOC_STATE.input_files[1]); if not capitulos[name] then return doc end
 local extra=bloques(name); local out={}; local ins=false
 for _,b in ipairs(doc.blocks) do
  if not ins and b.t=="Header" and pandoc.utils.stringify(b.content):lower():match("referencias del capítulo") then for _,x in ipairs(extra)do table.insert(out,x)end;ins=true end
  table.insert(out,b)
 end
 if not ins then for _,x in ipairs(extra)do table.insert(out,x)end end
 doc.blocks=out;return doc
end
