import random
import json
from datetime import datetime, timedelta

def generate_random_date(start_date, end_date):
    return start_date + timedelta(seconds=random.randint(0, (end_date - start_date).total_seconds()))

statuses = ["READY_TO_PICKUP", "CONFIRMED", "OUT_FOR_DELIVERY", "CREATED", "RETURNED_TO_SENDER", "NOT_READY", "PICKUP_TIME_EXPIRED", "AVIZO", "SENT_FROM_SORTING_CENTER"]

data = []

for i in range(1000):
    status = random.choice(statuses)
    obj = {
        "id": f"100000000000000000000{i + 1}",
        "status": status,
        "sender": f"Sender {i + 1}",
        "shipmentType": random.choice(["PARCEL_LOCKER", "COURIER"])
    }
    if status == "READY_TO_PICKUP":
        start_date = datetime(2021, 1, 1)
        end_date = datetime(2023, 12, 31)
        obj["expiryDate"] = generate_random_date(start_date, end_date).isoformat() + "Z"
        obj["storedDate"] = generate_random_date(start_date, end_date).isoformat() + "Z"
    if status == "DELIVERED":
        obj["pickupDate"] = generate_random_date(start_date, end_date).isoformat() + "Z"
    data.append(obj)

# Save the data to a JSON file
with open('generatedPacks.json', 'w') as json_file:
    json.dump(data, json_file, indent=4)

print("Data saved to 'generatedPacks.json'")
