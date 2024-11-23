'''
Mean Absolute Error (MAE): It is the average of the absolute differences between the actual and predicted values. It gives an idea of how wrong the predictions are on average.
Root Mean Squared Error (RMSE): It is the square root of the average of the squared differences between the actual and predicted values. It gives more weight to larger errors and is useful when large errors are particularly undesirable.
'''

import numpy as np
from sklearn.metrics import mean_absolute_error, mean_squared_error
import matplotlib.pyplot as plt

# Example data: actual and predicted values
actual = np.array([3, -0.5, 2, 7])
predicted = np.array([2.5, 0.0, 2, 8])

# Calculate Mean Absolute Error (MAE)
mae = mean_absolute_error(actual, predicted)

# Calculate Root Mean Squared Error (RMSE)
rmse = np.sqrt(mean_squared_error(actual, predicted))

# Print the results
print(f"Mean Absolute Error (MAE): {mae}")
print(f"Root Mean Squared Error (RMSE): {rmse}")

'''
If the MAE is 0.5, it means that on average, the model's predictions are 0.5 units away from the actual values.
If the RMSE is 0.612, it means that the model's predictions deviate from the actual values by approximately 0.612 units on average, 
with larger errors having a greater impact on this metric.
'''

# Scatter plot to visualize model performance
plt.figure(figsize=(8, 6))
plt.scatter(actual, predicted, color='blue', label='Predicted vs Actual')
plt.plot([min(actual), max(actual)], [min(actual), max(actual)], color='red', linestyle='--', label='Ideal Fit')
plt.xlabel('Actual Values')
plt.ylabel('Predicted Values')
plt.title('Model Performance: Actual vs Predicted Values')
plt.legend()
plt.grid(True)
plt.show()
