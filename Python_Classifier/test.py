import numpy as np
from sklearn.svm import SVR

from sklearn.datasets import  load_boston
from sklearn.datasets import load_diabetes
from sklearn.linear_model import LinearRegression
# data = load_diabetes()
data = load_boston()
X = data.data
y = data.target

print(y[:1])
