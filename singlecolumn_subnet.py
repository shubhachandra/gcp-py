import ipaddress
import pandas as pd

# Define the base subnet
base_subnet = ipaddress.IPv4Network("100.126.0.0/17")

# Define subnet masks from /18 to /28
subnet_masks = list(range(18, 29))

# Generate all subnets from /18 to /28
all_subnets = []
for mask in subnet_masks:
    all_subnets.extend([str(subnet) for subnet in base_subnet.subnets(new_prefix=mask)])

# Create DataFrame with a single column
df_single_column = pd.DataFrame(all_subnets, columns=["Subnets"])

# Save to CSV
csv_filename = "subnets_single_column_100.126.0.0_17.csv"
df_single_column.to_csv(csv_filename, index=False)

print(f"CSV file generated: {csv_filename}")
