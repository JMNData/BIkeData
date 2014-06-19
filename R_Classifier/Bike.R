library("e1071")

setwd("C:\\Users\\Administrator\\Documents\\GitHub\\BIkeData")
Train = read.csv("data\\train.csv", header = TRUE)
Test = read.csv("data\\test.csv", header = TRUE)


Model = svm(Train[2:11],Train[12],type="nu-regression")
predict(Model,Train[12])

