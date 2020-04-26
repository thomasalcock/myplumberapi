library(dplyr)
library(janitor)

df <- readRDS("data/real_estate_data.RDS")
df <- janitor::clean_names(df)
df <- df[,!sapply(df, function(x) anyNA(x))]

dfdb <- df

write.table(
  x = dfdb, 
  sep = ",",
  file = "../mydb/real_estate_data.csv",
  quote = FALSE,
  row.names = FALSE,
  col.names = FALSE
)

keys <- sapply(dfdb, class)
values <- unname(keys)
keys <- names(dfdb)
values[which(grepl("integer", values))] <- "INT"
values[which(grepl("factor", values))] <- "TEXT"

schema  <- paste(keys, values, collapse = ", \n")

cat(schema, file = "../mydb/schema.txt")
