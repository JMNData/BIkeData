#Add Libraries
library("e1071")
library("Metrics")
library("rpart")


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
model.rpart = rpart(count~., data=Train1)
print(model.rpart)
summary(model.rpart)
plot()

#model.glm = glm(count~., data=Train1)
#print(model.glm)
#summary(model.glm)

#Predict using tree model, Wirte back to Train to see results
Predicted.Train.tree = cbind(Train, predict = as.integer(predict(model.rpart, Train1[,-1], interval="predict")))
Predicted.Test.tree = cbind(Test, predict = as.integer(predict(model.rpart, Test[,-1], interval="predict")))
Predicted.Test.tree$predict = ifelse(Predicted.Test.tree$predict < 0, 0, Predicted.Test.tree$predict)
out = c("datetime", "predict")
write.csv(Predicted.Test.tree[out], "data\\resultsTree.csv", row.names = FALSE)







