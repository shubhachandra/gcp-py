import pandas as pd
import json

# Load CSV file
input_file = "your_file.csv"  # Replace with your actual file name
df = pd.read_csv(input_file)

# Column containing JSON data (replace 'json_column' with your actual column name)
json_column = "json_column_name"  # Update with the actual column name

# Function to extract "IpCidrRange"
def extract_ip_cidr(json_data):
    try:
        data = json.loads(json_data)  # Convert string to dictionary
        return data.get("IpCidrRange", "N/A")  # Extract value or return 'N/A' if missing
    except (json.JSONDecodeError, TypeError):
        return "Invalid JSON"  # Handle errors

# Create a new column with extracted values
df["IpCidrRange"] = df[json_column].apply(extract_ip_cidr)

# Save the updated CSV
output_file = "updated_file.csv"
df.to_csv(output_file, index=False)

print(f"Updated CSV saved as: {output_file}")
