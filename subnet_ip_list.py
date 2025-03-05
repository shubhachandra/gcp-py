import ipaddress
import pandas as pd
import itertools

# Define the base subnet
base_subnet = ipaddress.IPv4Network("100.126.0.0/17")

# Define subnet masks from /18 to /28
subnet_masks = list(range(18, 29))

# Generate all subnets for each mask, including the base subnet
subnet_dict = {17: [base_subnet]}  # Start with the base subnet
for mask in subnet_masks:
    subnet_dict[mask] = [subnet for parent in subnet_dict[mask - 1] for subnet in parent.subnets(new_prefix=mask)]

# Prepare data for DataFrame
data = []

# Iterate through smallest subnets and track their parent subnets
for smallest_subnet in subnet_dict[28]:  # Start from the smallest subnet
    row = {}
    current_subnet = smallest_subnet
    
    for mask in reversed(range(17, 29)):  # From /28 back to /17
        row[f"/{mask}"] = str(current_subnet)
        if mask > 17:
            current_subnet = next((subnet for subnet in subnet_dict[mask-1] if current_subnet.subnet_of(subnet)), None)
    
    data.append(row)

# Create DataFrame and sort columns
df = pd.DataFrame(data)
df = df[["/" + str(mask) for mask in range(17, 29)]]

# Save to CSV
csv_filename = "subnets_100.126.0.0_17.csv"
df.to_csv(csv_filename, index=False)

print(f"CSV file generated: {csv_filename}")
