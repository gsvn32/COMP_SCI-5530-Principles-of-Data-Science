import pandas as pd

# Create DataFrame
df = pd.read_csv("../data_raw/students_performance_data.csv")

#change all categorical cloumns to numerical
categorical_cols = df.select_dtypes(include='object').columns
for col in categorical_cols:
  df[col] = df[col].astype('category').cat.codes

# Store the cleaned data
df.to_csv('../data_clean/clean_data.csv',index=False)
