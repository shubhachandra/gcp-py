import ipaddress
import pandas as pd

# Load CSV file (Update with actual filename)
input_file = "input.csv"  # Change this to your actual file name
output_file = "output.csv"

# Read the CSV file
df = pd.read_csv(input_file)

# Ensure the column name matches your CSV (Column I contains CIDR blocks)
cidr_column = "I"  # Assuming "I" is the column header name

# Create a new column in "L" to store generated IPs
output_column = "L"  # Change as per your column naming convention

# Function to generate all IPs from a CIDR block
def generate_ip_range(cidr):
    try:
        return ", ".join([str(ip) for ip in ipaddress.ip_network(cidr, strict=False)])
    except ValueError:
        return "Invalid CIDR"

# Apply function to each row in column "I" and store result in column "L"
df[output_column] = df[cidr_column].apply(generate_ip_range)

# Save the updated file with IPs in column "L"
df.to_csv(output_file, index=False)

print(f"✅ Process completed! The output file is saved as: {output_file}")
