🩺 Predicting Coronary Heart Disease with Logistic Regression
-------------------------------------------------------------

This project applies **logistic regression** to predict the likelihood of developing coronary heart disease (CHD) based on a set of lifestyle and medical factors. Using a dataset of patients, the project builds, evaluates, and refines a predictive model, demonstrating the end-to-end process of a classification problem in R.

The analysis is performed using R, leveraging key packages such as **ggplot2**, **caret**, and **pROC**. The workflow starts with model construction, followed by rigorous evaluation using a **confusion matrix**, **odds ratios**, and an **ROC curve**. It also explores advanced techniques like **stepwise variable selection**, **interaction terms**, and **bootstrapping** to create a more robust and interpretable model. The goal is to identify the most significant risk factors for CHD and build a model that accurately classifies patients.

* * * * *

### ✨ Key Features & Technical Details

-   **Model Building**: The project begins with a full model (`model_logiatic_1`) that includes nine predictor variables. It then refines this into a more parsimonious model (`model_logiatic_2`) with a subset of key features (`tobacco`, `ldl`, `famhist`, `typea`, `age`).

-   **Variable Importance**: The `varImp()` function from the `caret` package is used to rank the importance of variables in the model, providing insight into which factors contribute most to the prediction.

-   **Model Diagnostics**: The notebook includes diagnostic plots to check for linearity of the log-odds and identify influential data points. It also calculates the **Variance Inflation Factor (VIF)** to check for multicollinearity.

-   **Performance Evaluation**:

    -   **Confusion Matrix**: A confusion matrix is generated to assess the model's performance in terms of **accuracy**, **sensitivity**, and **specificity**.

    -   **Odds Ratios**: The coefficients of the logistic regression model are exponentiated to calculate **odds ratios**, providing a clear, interpretable measure of how each variable affects the odds of having CHD.

    -   **ROC Curve and AUC**: A **Receiver Operating Characteristic (ROC)** curve is plotted, and the **Area Under the Curve (AUC)** is calculated to evaluate the model's ability to discriminate between patients with and without CHD. An AUC value greater than 0.5 indicates a model that performs better than random chance.

-   **Advanced Modeling Techniques**:

    -   **Stepwise Selection**: The `step()` function is used to automatically select the optimal combination of variables based on the AIC (Akaike Information Criterion), helping to prevent overfitting.

    -   **Interaction Terms**: The project demonstrates how to add an interaction term (e.g., `tobacco:age`) to a model to test if the effect of one variable depends on the level of another.

    -   **Bootstrapping**: The `boot` package is used to perform bootstrapping on the model's coefficients. This provides a more robust estimate of the standard errors, especially with smaller or non-normally distributed datasets.

* * * * *

### 🚀 Getting Started

To run this project, you will need an R environment with the following libraries:

-   `car`

-   `corrplot`

-   `caret`

-   `ggplot2`

-   `lattice`

-   `pROC`

-   `boot`

You can install these packages using the `install.packages()` command in R. The project also requires the `CHD.csv` dataset, which should be in the same directory as the script.

* * * * *

### 📊 Project Workflow

The **`week 8 part 2.R`** script follows a clear, step-by-step workflow:

1.  **Setup and Data Loading**: The necessary libraries are loaded, and the `CHD.csv` dataset is read into a data frame.

2.  **Model Building**: The script begins by fitting a full logistic regression model, then a simplified one based on selected variables.

3.  **Model Inspection**: The `summary()` function is used to inspect model coefficients and p-values. `varImp()` is applied to rank the importance of the predictors.

4.  **Diagnostic Checks**: Diagnostic plots are generated to check model assumptions, and VIF is calculated to detect multicollinearity.

5.  **Model Evaluation**: The script calculates predicted probabilities and uses a 0.5 threshold to create a **confusion matrix**. Odds ratios are computed by exponentiating the model coefficients. An **ROC curve** is generated to visually and quantitatively assess the model's discriminative power.

6.  **Model Refinement**: Stepwise selection and interaction terms are explored to improve the model.

7.  **Robustness Check**: Bootstrapping is performed on the final model to provide more stable estimates of the coefficients and their standard errors.

* * * * *

### 📈 Final Thoughts

This project provides a comprehensive and practical example of how to build and evaluate a logistic regression model for a real-world classification problem. It goes beyond basic model fitting to include essential steps like model diagnostics, a thorough performance assessment, and advanced techniques for model refinement. The use of odds ratios and the ROC curve provides valuable, interpretable insights, making the model's results clear to both technical and non-technical audiences.

* * * * *

### 🙏 Acknowledgments

I would like to thank the creators of the R packages `car`, `caret`, `pROC`, `ggplot2`, and `boot` for providing the robust tools that made this analysis possible. Their work is a cornerstone of statistical analysis in R and greatly simplifies the process of building, evaluating, and validating complex models.
