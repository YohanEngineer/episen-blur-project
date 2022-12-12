resource "google_storage_bucket" "bucket-storage-functions" {
  name     = "bucket-storage-functions-asy"
  location = "EU"
  # To delete a bucket with objects inside
  force_destroy               = true
  uniform_bucket_level_access = true
  project                     = "episen-blur-project"
  storage_class               = "STANDARD"
  public_access_prevention    = "inherited"
}

resource "google_storage_bucket_object" "archive" {
  name   = "function1.zip"
  bucket = "bucket-storage-functions-asy"
  source = "/Users/yohan/episen-blur-project/upload-function/function1.zip"
}

resource "google_cloudfunctions_function" "function-test-asy" {
  name                  = "function-test-asy"
  description           = "My function"
  runtime               = "python310"
  project               = "episen-blur-project"
  region                = "europe-west1"
  available_memory_mb   = 512
  source_archive_bucket = "bucket-storage-functions-asy"
  source_archive_object = "function1.zip"
  trigger_http          = true
  entry_point           = "upload_image"
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = "episen-blur-project"
  region         = "europe-west1"
  cloud_function = "function-test-asy"

  role   = "roles/cloudfunctions.invoker"
  member = "allUsers"
}
