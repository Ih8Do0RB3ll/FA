#install.packages('rJava', type='mac.binary')
#install.packages('xlsx', type='mac.binary')
library("xlsx")

#Цена продукта, который мы продаём
PRODUCT_PRICE <- 500
#цена поставки
SUPPLY_PRICE <- 65
UNTIL_PRICE <- 30

#Устанавливаем директорию
setwd("/Users/georgiydemo/Projects/FA/Course II/R/Diksi/analytics")

#Названия магазинов
shop_names <- c()
#Выручка
shop_revenues <- c()
#Прибыль
shop_profits <- c()
#Реализация
shop_sales <- c()
#Списание
shop_writeoffs <- c()
#Равномерность продаж
shop_sr <- c()
#Продажи макс
shop_sales_max <- c()
#День продажи макс
shop_sales_maxdays <- c()
#Продажи мин
shop_sales_min <- c()
#День продажи мин
shop_sales_mindays <- c()
#Списание макс
shop_writeoff_max <- c()
#День списания макс 
shop_writeoff_maxdays <- c()


#Цикл по каждому магазину
for (i in 1:10){
  
  in1 <- read.table(file = paste0('store',as.character(i),'_in.txt'), head = TRUE)
  out1 <- read.table(file = paste0('store',as.character(i),'_out.txt'), head = TRUE)
  
  # Название магазина
  shop_names <- append(shop_names, paste0('store',as.character(i)))
  
  # Списание
  buf_writeoff <- sum(in1[, 2]) - sum(out1[, 2])
  shop_writeoffs <- append(shop_writeoffs, buf_writeoff)
  
  # Выручка
  buf_shoprevenue <- PRODUCT_PRICE * sum(out1[, 2])
  shop_revenues <- append(shop_revenues, buf_shoprevenue)
  
  # Затраты
  buf_cost <- (sum(in1[, 2]) * SUPPLY_PRICE) + (buf_writeoff * UNTIL_PRICE)
  
  # Прибыль
  shop_profits <- append(shop_profits, buf_shoprevenue - buf_cost)
  
  # Реализация
  shop_sales <- append(shop_sales, sum(out1[, 2]))
  
  # Равномерность продаж
  shop_sr <- append(shop_sr, sd(out1[, 2]))
  
  # Продажи макс
  shop_sales_max <-append(shop_sales_max, max(out1[, 2]))

  # День продажи макс
  shop_sales_maxdays <- append(shop_sales_maxdays, out1[which.max(out1[, 2]), 1])
  
  # Продажи мин
  shop_sales_min <-append(shop_sales_min, min(out1[, 2]))
  
  # День продажи мин
  shop_sales_mindays <- append(shop_sales_mindays, out1[which.min(out1[, 2]), 1])
  
  # Списание макс
  shop_writeoff_max <- append(shop_writeoff_max,c(in1[, 2] - out1[, 2]))

  # День списания макс
  shop_writeoff_maxdays <- append(shop_writeoff_maxdays, in1[which.max(c(in1[, 2] - out1[, 2])), 1])
  
  print("ВЫПОЛНИЛИСЬ N РАЗ")
  print(i)
}


#Формируем датафрейм
table <- data.frame(shop_names,shop_revenues,shop_profits,shop_sales ,shop_writeoffs,shop_sr,shop_sales_max,shop_sales_maxdays,shop_sales_min,shop_sales_mindays,shop_writeoff_max,shop_writeoff_maxdays)

#Проставляем заголовки
col_headings <- c("Магазин" ,"Выручка (руб)" ,"Прибыль","Реализация" ,"Списание, конт.","Равномерность продаж" ,"Продажи макс","День продажи макс", "Продажи мин","День продажи мин" ,"Списание макс","День макс списания")
names(table) <- col_headings

# Запись в .csv
write.table(
  table,
  file = '/Users/georgiydemo/Projects/FA/Course II/R/Diksi/result/таблица.csv',
  col.names = TRUE,
  row.names = FALSE,
  sep = ';',
  dec = ',',
  fileEncoding = 'UTF-8'
)

# Запись в .xlsx (это чтоб на маке отображалось корректно)
write.xlsx(table,
           file = "/Users/georgiydemo/Projects/FA/Course II/R/Diksi/result/таблица.xlsx",
           sheetName = "DATA",
           append = FALSE)