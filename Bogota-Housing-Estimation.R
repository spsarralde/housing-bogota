
area_model <- readRDS("directory/area_model.rds")
price_model <- readRDS("directory/price_model.rds")

#--------------------------------------------------------------------------------------

Type <- "Apto."
Stratum <- 4
Rooms <- 2
Garage <- 1
Year <- 2018
Location <- "LOS CEDROS"

#----------------------------------

test.area <-data.frame(X=1, rooms= Rooms, garage=Garage, type=Type,stratum=Stratum,location=Location)

predict_area <- exp(predict(area_model, newdata = test.area, interval = "confidence", level = 0.95)) 

predict_area <- subset(predict_area, select = -fit)

test.area <- cbind.data.frame(rbind.data.frame(test.area, test.area),t(predict_area))

colnames(test.area)[7] <- "area"

test.area$year <- Year

predict_price <- exp(predict(price_model, newdata = test.area, interval = "confidence", level = 0.95)) 

predict_area <- t(predict_area)

price_m2 <- as.data.frame(c(predict_price[3]/predict_area[2],predict_price[6]/predict_area[1]))

result <- cbind.data.frame(predict_area,price_m2)

colnames(result) <- c("area","price.m2")

result <- transform(result, price = area*price.m2)

result



