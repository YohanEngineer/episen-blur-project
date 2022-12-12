resource "google_storage_bucket_object" "function1" {
  name   = "function1.zip"
  bucket = "bucket-storage-functions-asy"
  source = "../../upload-function/function1.zip"
}

resource "google_storage_bucket_object" "function2" {
  name   = "function2.zip"
  bucket = "bucket-storage-functions-asy"
  source = "../../verify-image-function/function2.zip"
}

resource "google_storage_bucket_object" "function3" {
  name   = "function3.zip"
  bucket = "bucket-storage-functions-asy"
  source = "../../download-function/function3.zip"
}


resource "google_cloudfunctions_function" "CFunctions-HTTP-input" {
  name                         = "CFunctions-HTTP-input"
  description                  = "Function used to upload an image to a specific bucket using HTTP request"
  runtime                      = "python310"
  project                      = "episen-blur-project"
  region                       = "europe-west1"
  available_memory_mb          = 512
  source_archive_bucket        = "bucket-storage-functions-asy"
  source_archive_object        = "function1.zip"
  trigger_http                 = true
  https_trigger_security_level = "SECURE_OPTIONAL"
  ingress_settings             = "ALLOW_ALL"
  entry_point                  = "upload_image"
}

resource "google_cloudfunctions_function" "C-Function-Detect-Offensive-Image" {
  name                = "C-Function-Detect-Offensive-Image"
  description         = "Function used to verify an image when uploaded to a specific bucket using storage trigger"
  runtime             = "python38"
  project             = "episen-blur-project"
  region              = "europe-west1"
  available_memory_mb = 512
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = "bucket-input-asy"
  }
  environment_variables = {
    BUCKET_INPUT     = "bucket-input-asy"
    BUCKET_BLURRED   = "bucket-image-blurred-asy"
    BUCKET_UNBLURRED = "bucket-image-unblurred-asy"
  }
  source_archive_bucket = "bucket-storage-functions-asy"
  source_archive_object = "function2.zip"
  entry_point           = "blur_offensive_images"
}

resource "google_cloudfunctions_function" "CFunctions-HTTTP-Search" {
  name                  = "CFunctions-HTTTP-Search"
  description           = "Function used to download an image from a specific bucket using HTTP request"
  runtime               = "python38"
  project               = "episen-blur-project"
  region                = "europe-west1"
  available_memory_mb   = 512
  source_archive_bucket = "bucket-storage-functions-asy"
  source_archive_object = "function3.zip"
  trigger_http          = true
  environment_variables = {
    UNBLURRED_BUCKET = "bucket-image-unblurred-asy"
  }
  https_trigger_security_level = "SECURE_OPTIONAL"
  ingress_settings             = "ALLOW_ALL"
  entry_point                  = "download"
}

resource "google_cloudfunctions_function_iam_member" "invoker1" {
  project        = "episen-blur-project"
  region         = "europe-west1"
  cloud_function = "CFunctions-HTTP-input"

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}

resource "google_cloudfunctions_function_iam_member" "invoker3" {
  project        = "episen-blur-project"
  region         = "europe-west1"
  cloud_function = "CFunctions-HTTTP-Search"

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
