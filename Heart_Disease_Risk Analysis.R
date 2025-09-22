library(car)
library(corrplot)
library(caret)
library(carData)
library(ggplot2)
library(lattice)





CHD <- read.csv(file = 'CHD.csv')
head(CHD)



model_logiatic_1 <- glm(chd ~ sbp + tobacco + ldl
                        + adiposity + famhist + typea
                        + obesity + alcohol + age,
                        data = CHD, family = "binomial")
summary(model_logiatic_1)




model_logiatic_2 <- glm(chd ~ tobacco + ldl
                        + famhist + typea
                        + age,
                        data = CHD, family = "binomial")
summary(model_logiatic_2)



Imp <- varImp(model_logiatic_2, scale = FALSE)
Imp



model_logiatic_3 <- glm(chd ~ famhist + age,
                        data = CHD, family = "binomial")
summary(model_logiatic_3)




probs <- predict(model_logiatic_2, data=CHD,type="response")
CHD$probs <- probs




logits <- log(probs/(1-probs))
CHD$logits <- logits



data.frame(colnames(CHD))



pairs(CHD[, c(12, 2, 3, 9)], 
      lower.panel = NULL, 
      upper.panel = panel.smooth, 
      pch = 19, 
      cex = 0.2)





plot(model_logiatic_2, which = 4, id.n = 3)





vif(model_logiatic_2)




ggplot(CHD, aes(x=tobacco+ldl+typea+age, y=chd)) + geom_point() +
  stat_smooth(method="glm", color="green", se=FALSE,
              method.args = list(family=binomial))



# Convert predicted probabilities to binary predictions
# We'll use a threshold of 0.5
CHD$predicted_chd <- ifelse(CHD$probs > 0.5, 1, 0)

# Create the confusion matrix
# The `factor` conversion is necessary for the confusionMatrix() function
CHD$chd <- factor(CHD$chd, levels = c(0, 1))
CHD$predicted_chd <- factor(CHD$predicted_chd, levels = c(0, 1))

confusionMatrix(data = CHD$predicted_chd, reference = CHD$chd)





# Get the coefficients from model_logiatic_2
model_2_coeffs <- coef(model_logiatic_2)

# Exponentiate the coefficients to get the odds ratios
odds_ratios <- exp(model_2_coeffs)

# Print the odds ratios
print(odds_ratios)




# Install and load the pROC package if you haven't already
# install.packages("pROC")
library(pROC)

# Calculate the ROC curve for model_logiatic_2
roc_curve <- roc(response = CHD$chd, predictor = CHD$probs)

# Plot the ROC curve
plot(roc_curve, main = "ROC Curve for CHD Logistic Regression",
     col = "blue", lwd = 2, print.auc = TRUE)

# The 'print.auc = TRUE' command will display the AUC value on the plot.






# Perform a backward stepwise selection based on AIC
# Start with the full model (model_logiatic_1) and remove variables one by one
# to find the best-fitting subset.
step_model <- step(model_logiatic_1, direction = "backward")

# Print the summary of the final model selected by the stepwise process
summary(step_model)





# Build a model with an interaction between 'tobacco' and 'age'
# The ':' operator creates the interaction term
model_logiatic_interaction <- glm(chd ~ tobacco + ldl + famhist + typea + age + tobacco:age,
                                  data = CHD, family = "binomial")

summary(model_logiatic_interaction)

# You can also use the '*' operator, which includes both main effects and the interaction
# e.g., glm(chd ~ tobacco * age, data = CHD, family = "binomial")




# Install and load the ggplot2 package if you haven't already
# install.packages("ggplot2")
library(ggplot2)

# Create a data frame for prediction
# We'll vary 'age' while holding other continuous variables at their mean
# and categorical variables at their most common value.
newdata <- with(CHD, data.frame(age = seq(min(age), max(age), length.out = 100),
                                ldl = mean(ldl),
                                tobacco = mean(tobacco),
                                typea = mean(typea),
                                famhist = factor("Present", levels = c("Absent", "Present"))))

# Predict the probabilities using the new data frame
newdata$predicted_prob <- predict(model_logiatic_2, newdata = newdata, type = "response")

# Plot the predicted probabilities
ggplot(newdata, aes(x = age, y = predicted_prob)) +
  geom_line(color = "blue", size = 1.2) +
  labs(title = "Predicted Probability of CHD vs. Age",
       subtitle = "Other variables held at their average value",
       x = "Age",
       y = "Predicted Probability of CHD") +
  theme_minimal()





# For your logistic regression model (model_logiatic_2)
# The plot is a little different, but still effective
plot(model_logiatic_2, which = 4, id.n = 3)




# Bootstrapping your logistic regression model (model_logiatic_2)
# This example uses the boot package

# A function to run the glm and return the coefficients
library(boot)
boot_glm <- function(data, indices) {
  d <- data[indices, ]
  fit <- glm(chd ~ tobacco + ldl + famhist + typea + age,
             data = d, family = "binomial")
  return(coef(fit))
}

# Run the bootstrap with 1000 resamples
results <- boot(data = CHD, statistic = boot_glm, R = 1000)

# Print the bootstrap results, which include standard errors
print(results)