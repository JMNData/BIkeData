#Add Libraries
library("e1071")

#Set Globals
setwd("C:\\Users\\Administrator\\Documents\\GitHub\\BIkeData")

#Read Files
Train = read.csv("data\\train.csv", header = TRUE)
Test = read.csv("data\\test.csv", header = TRUE)
attach(Train)

#REarrange Structure to match SVM input
Test = cbind(Test, Hour = as.POSIXlt(Test[,1])$hour)
Train1 = cbind(Train, Hour = as.POSIXlt(Train[,1])$hour)
Train2 = Train1[2:13]
Train3 = subset(Train2, select = -casual)
Train4 = subset(Train3, select = -registered)
model = svm(count~., data=Train4)

#Predict using SVM model, Wirte back to Train to see results
PredictedTrain = cbind(Train, predict = as.integer(predict(model, Train1[,-1], interval="predict")))
PredictedTest = cbind(Test, predict = as.integer(predict(model, Test[,-1], interval="predict")))

print(model)
summary(model)


