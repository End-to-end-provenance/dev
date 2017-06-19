### Load some data
data(iris)

### Do some data munging
iris[1,4] <- 500

### Run a linear regression
lm.fit <- lm(Sepal.Length~Sepal.Width,data=iris)
lm.summary <- summary(lm.fit)

### Save output
dir.create('results',showWarnings = FALSE)
capture.output(lm.summary, file="results/anova_table_1.txt") 
