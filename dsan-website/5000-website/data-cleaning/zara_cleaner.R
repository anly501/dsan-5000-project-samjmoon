library(tidyverse)
library(dplyr)

shirts_w_df = read.csv("./data-gathering/zara/Women/Women/SHIRTS.csv")
head(shirts_w_df)

column_names = colnames(shirts_w_df)
print(column_names)

#remove columns "X", "Link", "Product Image"
shirts_w_df = shirts_w_df[, !names(shirts_w_df) %in% c("X", "Link", "Product_Image")]
head(shirts_w_df)

#clean Price column: remove currency character and whitespace, then convert to USD
shirts_w_df$Price = substr(shirts_w_df$Price, 2, nchar(shirts_w_df$Price))
head(shirts_w_df)

shirts_w_df$Price = trimws(shirts_w_df$Price, "left")
head(shirts_w_df)

shirts_w_df$Price = gsub(",", "", shirts_w_df$Price)
head(shirts_w_df)

shirts_w_df$Price = as.numeric(shirts_w_df$Price)

#conversion function
inr_to_usd = function(x) {
  return(x * 0.012)
}

shirts_w_df$Price = sapply(shirts_w_df$Price, inr_to_usd)
head(shirts_w_df)

#write cleaned df to csv file 
write.csv(shirts_w_df, file = "./data-cleaning/cleaned_shirts_w.csv", row.names = FALSE)
