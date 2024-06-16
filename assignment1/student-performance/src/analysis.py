# load DataFrame
df = pd.read_csv("../data_raw/students_performance_data.csv")

# 1. Distribution of math scores
# Analysis: This visualization shows the distribution of math scores in the dataset. It allows us to see the central tendency, spread, and shape of the data.
df['math score'].plot.hist()
plt.xlabel('Math Score')
plt.ylabel('Frequency')
plt.title('Distribution of Math Scores')
plt.savefig('math_scores.png')

# 2. Correlation between math and parental level of education
# Analysis: This visualization shows the relationship between math and parental level of education. It allows us to see if there is a positive or negative correlation between the two variables.
df.plot.scatter(x='parental level of education',y='math score', )
plt.xlabel('parental level of education')
plt.ylabel('Math Score')
plt.title('Correlation between Math and parental level of education')
plt.savefig('scatter_plot_math_vs_parent_lvl_edu.png')

# 3. Boxplot of writing scores by gender
# Analysis: This visualization shows the distribution of writing scores by gender. It allows us to see the median, quartiles, and outliers for each group.
df.boxplot(column='writing score', by='gender')
plt.xlabel('Gender')
plt.ylabel('Writing Score')
plt.title('Boxplot of Writing Scores by Gender')
plt.savefig('bxplot_gender_vs_w_score.png')

# 4. Bar chart of average scores by race/ethnicity
# Analysis: This visualization shows the average math scores for each racial/ethnic group. It allows us to see if there are any significant differences in average scores between groups.
df.groupby('race/ethnicity')['math score'].mean().plot.bar()
plt.xlabel('Race/Ethnicity')
plt.ylabel('Average Math Score')
plt.title('Average Math Scores by Race/Ethnicity')
plt.savefig('bar_avg_math_by_race.png')


# 5. Pie chart of lunch type
# Analysis: This visualization shows the proportion of students who receive free/reduced lunch and those who pay for lunch.
df['lunch'].value_counts().plot.pie()
plt.xlabel('Lunch Type')
plt.ylabel('Frequency')
plt.title('Pie Chart of Lunch Type')
plt.savefig('pie_lunch-type.png')
