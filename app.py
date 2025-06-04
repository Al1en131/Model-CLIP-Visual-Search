from flask import Flask, request, jsonify
import clip
import torch
from PIL import Image

app = Flask(__name__)

device = "cpu"  # Jangan pakai CUDA di Railway
model, preprocess = clip.load("ViT-B/32", device=device)

@app.route('/embed-image', methods=['POST'])
def embed_image():
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400

    try:
        file = request.files['image']
        image = Image.open(file.stream).convert("RGB")
        image = preprocess(image).unsqueeze(0).to(device)

        with torch.no_grad():
            features = model.encode_image(image)

        embedding = features.cpu().numpy()[0].tolist()
        return jsonify({'embedding': embedding})
    except Exception as e:
        return jsonify({'error': 'Embedding failed', 'message': str(e)}), 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000)
