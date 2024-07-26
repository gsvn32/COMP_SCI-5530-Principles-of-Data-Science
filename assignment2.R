### Part a: Random Sample and Comparison

# Load necessary libraries
library(ggplot2)
library(readr)

diabetes <- read_csv("E:/workspace/diabetes.csv")

# Set seed for reproducibility
set.seed(287)

# Take a random sample of 25 observations
sample_diabetes <- diabetes[sample(nrow(diabetes), 25), ]

# Calculate sample statistics
sample_mean_glucose <- mean(sample_diabetes$Glucose)
sample_max_glucose <- max(sample_diabetes$Glucose)

# Calculate population statistics
population_mean_glucose <- mean(diabetes$Glucose)
population_max_glucose <- max(diabetes$Glucose)

# Print statistics
print(paste("Sample Mean Glucose:", sample_mean_glucose))
print(paste("Sample Max Glucose:", sample_max_glucose))
print(paste("Population Mean Glucose:", population_mean_glucose))
print(paste("Population Max Glucose:", population_max_glucose))


# Create a diabetes frame for plotting
comparison_df <- data.frame(
  Category = c("Sample", "Population"),
  Mean_Glucose = c(sample_mean_glucose, population_mean_glucose),
  Max_Glucose = c(sample_max_glucose, population_max_glucose)
)

# Plot mean glucose comparison
ggplot(comparison_df, aes(x = Category, y = Mean_Glucose, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("Mean Glucose Comparison")

# Plot max glucose comparison
ggplot(comparison_df, aes(x = Category, y = Max_Glucose, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("Max Glucose Comparison")


### Part b: 98th Percentile of BMI


# Calculate the 98th percentile for sample and population
sample_98th_percentile_BMI <- quantile(sample_diabetes$BMI, 0.98)
population_98th_percentile_BMI <- quantile(diabetes$BMI, 0.98)

# Print percentiles
print(paste("Sample 98th Percentile BMI:", sample_98th_percentile_BMI))
print(paste("Population 98th Percentile BMI:", population_98th_percentile_BMI))

# Create a diabetes frame for plotting
percentile_comparison_df <- data.frame(
  Category = c("Sample", "Population"),
  Percentile_98_BMI = c(sample_98th_percentile_BMI, population_98th_percentile_BMI)
)

# Plot 98th percentile BMI comparison
ggplot(percentile_comparison_df, aes(x = Category, y = Percentile_98_BMI, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("98th Percentile BMI Comparison")


### Part c: Bootstrap Sampling


# Number of bootstrap samples and sample size
num_samples <- 500
sample_size <- 150

# Initialize vectors to store bootstrap results
bootstrap_means <- numeric(num_samples)
bootstrap_sds <- numeric(num_samples)
bootstrap_percentiles <- numeric(num_samples)

# Perform bootstrap sampling
for (i in 1:num_samples) {
  bootstrap_sample <- diabetes[sample(nrow(diabetes), sample_size, replace = TRUE), ]
  bootstrap_means[i] <- mean(bootstrap_sample$BloodPressure)
  bootstrap_sds[i] <- sd(bootstrap_sample$BloodPressure)
  bootstrap_percentiles[i] <- quantile(bootstrap_sample$BloodPressure, 0.98)
}

# Calculate population statistics
population_mean_BP <- mean(diabetes$BloodPressure)
population_sd_BP <- sd(diabetes$BloodPressure)
population_percentile_BP <- quantile(diabetes$BloodPressure, 0.98)

# Calculate average bootstrap statistics
bootstrap_mean_BP <- mean(bootstrap_means)
bootstrap_sd_BP <- mean(bootstrap_sds)
bootstrap_percentile_BP <- mean(bootstrap_percentiles)

# Print statistics
print(paste("Population Mean BloodPressure:", population_mean_BP))
print(paste("Bootstrap Mean BloodPressure:", bootstrap_mean_BP))
print(paste("Population SD BloodPressure:", population_sd_BP))
print(paste("Bootstrap SD BloodPressure:", bootstrap_sd_BP))
print(paste("Population 98th Percentile BloodPressure:", population_percentile_BP))
print(paste("Bootstrap 98th Percentile BloodPressure:", bootstrap_percentile_BP))


# Create a diabetes frame for plotting
bootstrap_comparison_df <- data.frame(
  Category = c("Population", "Bootstrap"),
  Mean_BP = c(population_mean_BP, bootstrap_mean_BP),
  SD_BP = c(population_sd_BP, bootstrap_sd_BP),
  Percentile_98_BP = c(population_percentile_BP, bootstrap_percentile_BP)
)

# Plot mean blood pressure comparison
ggplot(bootstrap_comparison_df, aes(x = Category, y = Mean_BP, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("Mean Blood Pressure Comparison")

# Plot standard deviation blood pressure comparison
ggplot(bootstrap_comparison_df, aes(x = Category, y = SD_BP, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("SD Blood Pressure Comparison")

# Plot 98th percentile blood pressure comparison
ggplot(bootstrap_comparison_df, aes(x = Category, y = Percentile_98_BP, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("98th Percentile Blood Pressure Comparison")

