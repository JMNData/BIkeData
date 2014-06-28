#Add Libraries
library("e1071")
library("Metrics")

#Set Globals
setwd("C:\\Users\\Administrator\\Documents\\GitHub\\BIkeData")

#Read Files
Train = read.csv("data\\train.csv", header = TRUE)
Test = read.csv("data\\test.csv", header = TRUE)
attach(Train)

#REarrange Structure to match SVM input
Test = cbind(Test, Hour = as.POSIXlt(Test[,1])$hour)
Train1 = cbind(Train, Hour = as.POSIXlt(Train[,1])$hour)
Train1 = Train1[2:13]
Train1 = subset(Train1, select = -casual)
Train1 = subset(Train1, select = -registered)

#Train Data
model.svm = svm(count~., data=Train1)
print(model.svm)
summary(model.svm)

model.glm = glm(count~., data=Train1)
print(model.glm)
summary(model.glm)

#Predict using SVM model, Wirte back to Train to see results
Predicted.Train.svm = cbind(Train, predict = as.integer(predict(model.svm, Train1[,-1], interval="predict")))
rmsle(Predicted.Train.svm$count, Predicted.Train.svm$predict)
Predicted.Test.svm = cbind(Test, predict = as.integer(predict(model.svm, Test[,-1], interval="predict")))

#Predict using GLM model, Wirte back to Train to see results
Predicted.Traing.glm = cbind(Train, predict = as.integer(predict(model.glm, Train1[,-1], interval="predict")))
rmsle(Predicted.Train.glm$count, Predicted.Train.glm$predict)
Predicted.Test.glm = cbind(Test, predict = as.integer(predict(model.glm, Test[,-1], interval="predict")))






