
# [START functions_imagemagick-setup]

import os
import tempfile

from google.cloud import storage, vision
from wand.image import Image

storage_client = storage.Client()
vision_client  = vision.ImageAnnotationClient()


def blur_offensive_images(data, context):
    file_data = data

    file_name = file_data['name']
    bucket_name = file_data['bucket']

    print(f'process filename {file_name}, bucket_name {bucket_name}')

    blob = storage_client.bucket(bucket_name).get_blob(file_name)
    blob_uri = f'gs://{bucket_name}/{file_name}'
    blob_source = {'source': {'image_uri': blob_uri}}

    print(f'Analyzing {file_name}')

    result = vision_client.safe_search_detection(blob_source)
    detected = result.safe_search_detection

    # process result image
    if detected.adult == 5 or detected.violence == 5:
      print(f'The image {file_name} was detected as inappropriate.')
      return __blur_image(blob)

    else:
        print(f'The image {file_name} was detected as OK.')

# [START functions_blur]
def __blur_image(current_blob):
    file_name = current_blob.name
    _, temp_local_filename = tempfile.mkstemp()

    # download file from bucket
    current_blob.download_to_filename(temp_local_filename)
    
    # Blur the image using ImageMagick.
    with Image(filename= temp_local_filename) as image:
        image.resize(*image.size, blur=16, filter='hamming')
        image.save(filename=temp_local_filename)

    print(f'Image {file_name} was blurred.')

    # Upload result to a second bucket

    blur_bucket = storage_client.bucket('episen-image-blurred')
    new_blob = blur_bucket.blob(file_name)
    new_blob.upload_from_filename(temp_local_filename)

    print(f'Blurred image uploaded to : gs://episen-image-blurred/{file_name}')

    # Delete the temporary file.
    os.remove(temp_local_filename)

# [END functions_blur]