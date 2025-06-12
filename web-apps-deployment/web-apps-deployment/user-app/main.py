from flask import Flask, request, jsonify, send_from_directory
from google.cloud import pubsub_v1
import os
import json

app = Flask(__name__)
project_id = 'project-2-458822'
topic_id = 'inventory-events'  # replace with your actual topic name
publisher = pubsub_v1.PublisherClient()
topic_path = publisher.topic_path(project_id, topic_id)

@app.route('/api/publish', methods=['POST'])
def publish():
    data = request.get_json()
    if not data:
        return jsonify({'error': 'Invalid request, no JSON body'}), 400

    message = json.dumps(data).encode('utf-8')
    try:
        future = publisher.publish(topic_path, message)
        return jsonify({'message_id': future.result()}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/')
def index():
    return send_from_directory('.', 'index.html')
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=int(os.environ.get('PORT', 8080)))
