resource "google_storage_bucket" "episen-input-asy-terraformed" {
  name     = "bucket-episen-input-asy"
  location = "EU"
  # To delete a bucket with objects inside
  force_destroy               = true
  uniform_bucket_level_access = true
  project                     = "episen-blur-project"
  storage_class               = "STANDARD"
  public_access_prevention    = "inherited"
}

resource "google_storage_bucket" "episen-unblurred-asy-terraformed" {
  name     = "bucket-episen-unblurred-asy"
  location = "EU"
  # To delete a bucket with objects inside
  force_destroy               = true
  uniform_bucket_level_access = true
  project                     = "episen-blur-project"
  storage_class               = "STANDARD"
  public_access_prevention    = "inherited"
}

resource "google_storage_bucket" "episen-blurred-asy-terraformed" {
  name     = "bucket-episen-blurred-asy"
  location = "EU"
  # To delete a bucket with objects inside
  force_destroy               = true
  uniform_bucket_level_access = true
  project                     = "episen-blur-project"
  storage_class               = "STANDARD"
  public_access_prevention    = "inherited"
}

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