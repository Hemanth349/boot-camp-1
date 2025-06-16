import os

PROJECT_ID = os.getenv('GOOGLE_CLOUD_PROJECT')
INVENTORY_TOPIC = f'projects/{PROJECT_ID}/topics/inventory-updates'
ORDER_TOPIC = f'projects/{PROJECT_ID}/topics/order-processing'
