import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import precision_recall_curve

# Example data: actual and predicted probabilities
actual = [1, 0, 1, 1, 0, 1, 0, 0, 1, 1]
predicted_prob = [0.9, 0.1, 0.8, 0.4, 0.2, 0.7, 0.3, 0.6, 0.9, 0.5]

# Calculate precision-recall pairs for different probability thresholds
precision, recall, thresholds = precision_recall_curve(actual, predicted_prob)

# Plot Precision-Recall curve
plt.figure(figsize=(8, 6))
plt.plot(recall, precision, color='blue', lw=2)
plt.xlabel('Recall')
plt.ylabel('Precision')
plt.title('Precision-Recall Trade-off')
plt.grid(True)
plt.show()
