import matplotlib.pyplot as plt
from sklearn.metrics import precision_score, recall_score, f1_score, precision_recall_curve


# Example data: actual and predicted values
actual = [1, 0, 1, 1, 0, 1, 0, 0, 1, 1]
predicted = [1, 0, 1, 0, 0, 1, 0, 1, 1, 0]

# Calculate Precision
precision = precision_score(actual, predicted)

# Calculate Recall
recall = recall_score(actual, predicted)

# Calculate F1-Score
f1 = f1_score(actual, predicted)

# Print the results
print(f"Precision: {precision}")
print(f"Recall: {recall}")
print(f"F1-Score: {f1}")

# Calculate precision-recall pairs for different probability thresholds
precision, recall, thresholds = precision_recall_curve(actual, predicted)

# Plot Precision-Recall curve
plt.figure(figsize=(8, 6))
plt.plot(recall, precision, color='blue', lw=2)
plt.xlabel('Recall')
plt.ylabel('Precision')
plt.title('Precision-Recall Trade-off')
plt.grid(True)
plt.show()