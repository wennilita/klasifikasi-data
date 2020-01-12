dataset = read.csv('userprofile.csv')
dataset = dataset[3:19]

# Encoding the target feature as factor
dataset$birth_year = factor(dataset$birth_year, levels = c(0, 1))
# Splitting the dataset into the Training set and Test set
# install.packages('caTools')
library(caTools)
set.seed(123)
split = sample.split(dataset$birth_year, SplitRatio = 0.75)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])

# Fitting Naive Bayes to the Training set
library(e1071)
classifier = naiveBayes(x = training_set[-3],
                        y = training_set$birth_year) 

# Predicting the Test set results
y_pred = predict(classifier, newdata = test_set[-3])
y_pred

# Making the Confusion Matrix
cm = table(test_set[, 3], y_pred)
cm