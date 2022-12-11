import os
from google.cloud import storage

storage_client = storage.Client()

def download(request):
    if request.method == 'OPTIONS':
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
    
    file = str(request.args.get('file'))
    bucket_name = os.getenv("UNBLURRED_BUCKET")

    if request.args.get('file') == None:
        files = list_blobs(bucket_name)
        json = {"list": []}
        for file in files :
            json["list"].append(file)
        return (json, 200, headers)
    else :
        print(file)
        file_content = download_image(file, bucket_name)
        headers = {
        'Access-Control-Allow-Origin': '*',
        'Content-Disposition': 'attachment; filename={}'.format(file)
        }
        return (file_content,200,headers)


def list_blobs(bucket_name):

    # Note: Client.list_blobs requires at least package version 1.17.0.
    blobs = storage_client.list_blobs(bucket_name)

    files = []
    for blob in blobs:
        print(blob.name)
        files.append(blob.name)
    
    return files

def download_image(file_name, bucket_name):
    bucket = storage_client.bucket(bucket_name)
    file = bucket.get_blob(file_name)
    file_content = file.download_as_string()

    return file_content
