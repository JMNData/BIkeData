#Add Libraries
library("e1071")
library("Metrics")
library("gbm")

#Set Globals
setwd("C:\\Users\\Administrator\\Documents\\GitHub\\BIkeData")

#Read Files
Train = read.csv("data\\train.csv", header = TRUE)
Test = read.csv("data\\test.csv", header = TRUE)
attach(Train)

#REarrange Structure to match SVM input
Test = cbind(Test, Hour = as.POSIXlt(Test[,1])$hour)
Train1 = cbind(Train, Hour = as.POSIXlt(Train[,1])$hour)
Train1 = cbind(Train1, WeekDay = weekdays(as.Date(Train$datetime)))
Train1 = Train1[2:14]
Train1 = subset(Train1, select = -casual)
Train1 = subset(Train1, select = -registered)

#Train Data
model = gbm(count~., data=Train1)
print(model)
summary(model)

#model.glm = glm(count~., data=Train1)
#print(model.glm)
#summary(model.glm)

#Predict using SVM model, Wirte back to Train to see results
Predicted.Train = cbind(Train, predict = as.integer(predict(model, Train1[,-1], interval="predict")))
Predicted.Test = cbind(Test, predict = as.integer(predict(model, Test[,-1], interval="predict")))
Predicted.Test$predict = ifelse(Predicted.Test$predict < 0, 0, Predicted.Test$predict)
out = c("datetime", "predict")
write.csv(Predicted.Test[out], "data\\resultsGB.csv", row.names = FALSE)







