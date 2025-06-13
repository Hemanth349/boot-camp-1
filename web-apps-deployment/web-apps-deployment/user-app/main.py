from flask import Flask, request, jsonify, send_from_directory
from google.cloud import pubsub_v1
from flask_cors import CORS
import os
import json
import logging

app = Flask(__name__)
CORS(app)
logging.basicConfig(level=logging.INFO)

project_id = 'project-2-458822'
topic_id = 'inventory-events'
publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path(project_id, topic_id)

@app.route('/api/publish', methods=['POST'])
def publish():
    data = request.get_json()
    required_fields = ['product_id', 'quantity', 'timestamp']
    
    if not data or not all(field in data for field in required_fields):
        return jsonify({'error': f'Missing required fields: {required_fields}'}), 400

    try:
        message = json.dumps(data).encode('utf-8')
        future = publisher.publish(topic_path, message)
        message_id = future.result()
        logging.info(f"Published message: {data}")
        return jsonify({'message_id': message_id}), 200
    except Exception as e:
        logging.error(f"Failed to publish: {e}")
        return jsonify({'error': str(e)}), 500

@app.route('/')
def index():
    return send_from_directory('.', 'index.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
