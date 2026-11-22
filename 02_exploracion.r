# 02_exploracion.R 
# Adara Salas Manzo
# Ejercicio 6, sección 7

# 1. Comprobar que existen resultados_blast.tsv, metadata_secuencias.csv y secuencias.fasta
resultados_blast = "data_raw/datos_sesion_02_blast/resultados_blast.tsv"
file.exists(resultados_blast)
metadata_secuencias = "data_raw/datos_sesion_02_blast/metadata_secuencias.csv"
file.exists(metadata_secuencias)
secuencias_fasta = "data_raw/datos_sesion_02_blast/secuencias.fasta"
file.exists(secuencias_fasta)

# 2. Importar las dos tablas con readr y conservar codigo_muestra como texto.
resultados = readr::read_tsv(
  resultados_blast, 
  show_col_types = FALSE
)

metadata = readr::read_csv(
  metadata_secuencias, 
  col_types = readr::cols(codigo_muestra = readr::col_character()),
  show_col_types = FALSE
)

# 3. Mostrar dimensiones, nombres y tipos de columnas.
dim(resultados) # Dimensiones
str(resultados) # Nombres y tipos 
dim(metadata) # Dimensiones
str(metadata) # Nombres y tipos 

# 4. Identificar los query_id distintos y contar los resultados por consulta.
length(unique(resultados$query_id))
table(resultados$query_id)

length(unique(metadata$query_id))
table(metadata$query_id)

# 5. Mostrar las filas con pident >= 90 y explicar qué representa este filtro.
resultados[resultados$pident >= 90,]
# El filtro nos ayuda a solo mostrar aqullas columnas con valor piden mayor o iguales que 90. 

# 6. Leer el FASTA e indicar cuántos encabezados contiene.
fasta = readLines(secuencias_fasta)
encabezados <- fasta[startsWith(fasta, ">")]
length(encabezados) # Cantidad de encabezados

# 7. Mostrar si alguna de las tablas tiene valores faltantes.
anyNA(resultados) # Valores faltantes
anyNA(metadata) # Valores faltantes


# Observaciones
# 1. El archivo fasta se identifica por contener dos tipos de líneas: la primera
# siendo el nombre de la secuencia (con un identificador ">") y la segunda siendo la secuencia
# 2. En el archivo de metadata, la columna "codigo_muestra" se convirtió a tipo
# caracter
# 3. A diferencia de metadata, resultados_blast relaciona varios valores al mismo
# query_id