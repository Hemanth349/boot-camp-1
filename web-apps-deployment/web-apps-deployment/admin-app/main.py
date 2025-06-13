from flask import Flask, request, jsonify
from google.cloud import pubsub_v1, firestore
import google.auth
import os

app = Flask(__name__)

# Initialize Firestore client
db = firestore.Client()

# Pub/Sub publisher client
publisher = pubsub_v1.PublisherClient()
PROJECT_ID = os.getenv('GCP_PROJECT_ID') or google.auth.default()[1]

INVENTORY_TOPIC = f'projects/{PROJECT_ID}/topics/inventory-updates'
ORDER_TOPIC = f'projects/{PROJECT_ID}/topics/order-processing'

def verify_iam_token():
    # Placeholder for IAM token validation logic
    token = request.headers.get('Authorization')
    if not token or not token.startswith("Bearer "):
        return False
    # Normally verify the token here using google.auth or Firebase Admin SDK
    return True

@app.route('/update_inventory', methods=['POST'])
def update_inventory():
    if not verify_iam_token():
        return jsonify({"error": "Unauthorized"}), 401

    try:
        data = request.json
        item_id = data.get('item_id')
        quantity = data.get('quantity')

        if not item_id or quantity is None:
            return jsonify({"error": "Missing item_id or quantity"}), 400

        db.collection('inventory').document(item_id).set({'quantity': quantity})

        message_data = f'{{"item_id": "{item_id}", "quantity": {quantity}}}'.encode('utf-8')
        publisher.publish(INVENTORY_TOPIC, message_data)

        return jsonify({"status": "Inventory updated"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    # Update Firestore inventory collection
    db.collection('inventory').document(item_id).set({'quantity': quantity})

    # Publish update event to Pub/Sub
    message_data = f'{{"item_id": "{item_id}", "quantity": {quantity}}}'.encode('utf-8')
    publisher.publish(INVENTORY_TOPIC, message_data)

    return jsonify({"status": "Inventory updated"}), 200

@app.route('/process_order', methods=['POST'])
def process_order():
    if not verify_iam_token():
        return jsonify({"error": "Unauthorized"}), 401

    data = request.json
    order_id = data.get('order_id')
    items = data.get('items')  # list of {item_id, quantity}

    if not order_id or not items:
        return jsonify({"error": "Missing order_id or items"}), 400

    # Store order in Firestore
    db.collection('orders').document(order_id).set({'items': items, 'status': 'processing'})

    # Publish order processing event
    message_data = f'{{"order_id": "{order_id}"}}'.encode('utf-8')
    publisher.publish(ORDER_TOPIC, message_data)

    return jsonify({"status": "Order processing started"}), 200

@app.route('/alerts', methods=['GET'])
def alerts():
    # For simplicity, just return a static message or could integrate with logs
    return jsonify({"alerts": "Monitoring and alerts placeholder"}), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
