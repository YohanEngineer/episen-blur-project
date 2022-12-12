import os
import tempfile
from google.cloud import storage

storage_client = storage.Client()

def upload_image(request):
    if request.method == 'OPTIONS':
        # Allows GET & POST requests from any origin with the Content-Type
        # header and caches preflight response for an 3600s
        headers = {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Max-Age': '3600'
        }

        return ('', 204, headers)

    headers = {
        'Access-Control-Allow-Origin': '*'
    }
    image = request.files['image']
    names = str(image).split("'")
    image_name = names[1]
    print(image_name)
    _, temp_local_filename = tempfile.mkstemp()
    image.save(temp_local_filename)
    input_bucket = storage_client.bucket('bucket-input-asy')
    new_blob = input_bucket.blob(image_name)
    new_blob.upload_from_filename(temp_local_filename)
    return ('OK', 200, headers)

