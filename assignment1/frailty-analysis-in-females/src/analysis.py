import pandas as pd
from scipy import stats

# Create DataFrame
df = pd.read_csv("../data_clean/clean_data.csv")

# Create test_results.txt
results= open("../results/test_results.txt", "w")

# Separate data based on frailty
frail = df[df["Frailty"] == "Y"]["Grip strength"]
non_frail = df[df["Frailty"] == "N"]["Grip strength"]

# Descriptive statistics
frail_stats = frail.describe()
non_frail_stats = non_frail.describe()

# Print results
print("\nDescriptive Statistics for Frail (Y) Group:\n", frail_stats,file=results,end="\n")
print("\nDescriptive Statistics for Non-Frail (N) Group:\n", non_frail_stats,file=results,end="\n")

# Perform t-test
t_stat, p_value = stats.ttest_ind(non_frail, frail)

# Print results
print("T-Statistic:", t_stat,file=results,end="\n")
print("P-Value:", p_value,file=results,end="\n")
if p_value < 0.05:
    print("There is a significant difference in grip strength between the frail and non-frail groups.",file=results,end="\n")
else:
    print("There is no significant difference in grip strength between the frail and non-frail groups.",file=results,end="\n")

# Close results
results.close()
