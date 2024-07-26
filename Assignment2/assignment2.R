# Load necessary libraries
library(ggplot2)
library(readr)

diabetes <- read_csv("E:/workspace/diabetes.csv")

# Part a: Set seed, calculate max, mean glucose
# Set seed for reproducibility
set.seed(287)

# Take a random sample of 25 observations
s_diabetes <- diabetes[sample(nrow(diabetes), 25), ]

# Calculate sample statistics
s_mean_glucose <- mean(s_diabetes$Glucose)
s_max_glucose <- max(s_diabetes$Glucose)

# Calculate population statistics
p_mean_glucose <- mean(diabetes$Glucose)
p_max_glucose <- max(diabetes$Glucose)

# Print statistics
print(paste("Sample Mean Glucose:", s_mean_glucose))
print(paste("Sample Max Glucose:", s_max_glucose))
print(paste("Population Mean Glucose:", p_mean_glucose))
print(paste("Population Max Glucose:", p_max_glucose))


# Create a diabetes frame for plot
comparison_df <- data.frame(
  Category = c("Sample", "Population"),
  Mean_Glucose = c(s_mean_glucose, p_mean_glucose),
  Max_Glucose = c(s_max_glucose, p_max_glucose)
)

# Plot mean glucose comparison
ggplot(comparison_df, aes(x = Category, y = Mean_Glucose, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("Mean Glucose Comparison")

# Plot max glucose comparison
ggplot(comparison_df, aes(x = Category, y = Max_Glucose, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("Max Glucose Comparison")


# Part b: 98th Percentile of BMI
# Calculate the 98th percentile for sample and population
s_98th_percentile_BMI <- quantile(s_diabetes$BMI, 0.98)
p_98th_percentile_BMI <- quantile(diabetes$BMI, 0.98)

# Print percentiles
print(paste("Sample 98th Percentile BMI:", s_98th_percentile_BMI))
print(paste("Population 98th Percentile BMI:", p_98th_percentile_BMI))

# Create a diabetes frame for plotting
percentile_comparison_df <- data.frame(
  Category = c("Sample", "Population"),
  Percentile_98_BMI = c(s_98th_percentile_BMI, p_98th_percentile_BMI)
)

# Plot 98th percentile BMI comparison
ggplot(percentile_comparison_df, aes(x = Category, y = Percentile_98_BMI, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("98th Percentile BMI Comparison")


# Part c: Bootstrap Sampling
# Number of bootstrap samples and sample size
num_samples <- 500
sample_size <- 150

# Initialize vectors to store bootstrap results
b_means <- numeric(num_samples)
b_sds <- numeric(num_samples)
b_percentiles <- numeric(num_samples)

# Perform bootstrap sampling
for (i in 1:num_samples) {
  b_sample <- diabetes[sample(nrow(diabetes), sample_size, replace = TRUE), ]
  b_means[i] <- mean(b_sample$BloodPressure)
  b_sds[i] <- sd(b_sample$BloodPressure)
  b_percentiles[i] <- quantile(b_sample$BloodPressure, 0.98)
}

# Calculate population statistics
p_mean_BP <- mean(diabetes$BloodPressure)
p_sd_BP <- sd(diabetes$BloodPressure)
p_percentile_BP <- quantile(diabetes$BloodPressure, 0.98)

# Calculate average bootstrap statistics
b_mean_BP <- mean(b_means)
b_sd_BP <- mean(b_sds)
b_percentile_BP <- mean(b_percentiles)

# Print statistics
print(paste("Population Mean BloodPressure:", p_mean_BP))
print(paste("Bootstrap Mean BloodPressure:", b_mean_BP))
print(paste("Population SD BloodPressure:", p_sd_BP))
print(paste("Bootstrap SD BloodPressure:", b_sd_BP))
print(paste("Population 98th Percentile BloodPressure:", p_percentile_BP))
print(paste("Bootstrap 98th Percentile BloodPressure:", b_percentile_BP))


# Create a diabetes frame for plotting
b_comparison_df <- data.frame(
  Category = c("Population", "Bootstrap"),
  Mean_BP = c(p_mean_BP, b_mean_BP),
  SD_BP = c(p_sd_BP, b_sd_BP),
  Percentile_98_BP = c(p_percentile_BP, b_percentile_BP)
)

# Plot mean blood pressure comparison
ggplot(b_comparison_df, aes(x = Category, y = Mean_BP, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("Mean Blood Pressure Comparison")

# Plot standard deviation blood pressure comparison
ggplot(b_comparison_df, aes(x = Category, y = SD_BP, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("SD Blood Pressure Comparison")

# Plot 98th percentile blood pressure comparison
ggplot(b_comparison_df, aes(x = Category, y = Percentile_98_BP, fill = Category)) +
  geom_bar(stat = "identity") +
  ggtitle("98th Percentile Blood Pressure Comparison")

