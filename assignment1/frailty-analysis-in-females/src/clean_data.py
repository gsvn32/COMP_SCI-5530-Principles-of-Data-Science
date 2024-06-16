import pandas as pd

# Load the CSV data into a Pandas DataFrame
df = pd.read_csv("../data_raw/female_frailty_data.csv")
df.columns=df.columns.str.strip()

# Convert the 'Grip strength' column from kg to pounds
df['Grip strength'] = df['Grip strength'] * 2.20462
# Remove trailing spaces from 'Frailty'
df['Frailty'] = df['Frailty'].str.strip()

# Write the updated DataFrame to a new CSV file
df.to_csv("../data_clean/clean_data.csv", index=False)
