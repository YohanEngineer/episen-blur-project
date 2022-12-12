resource "google_storage_bucket" "episen-input-asy-terraformed" {
  name     = "episen-input-asy-terraformed"
  location = "EU"
  # To delete a bucket with objects inside
  force_destroy               = true
  uniform_bucket_level_access = true
  project                     = "episen-blur-project"
  storage_class               = "STANDARD"
  public_access_prevention    = "inherited"
}

resource "google_storage_bucket" "episen-unblurred-asy-terraformed" {
  name     = "episen-unblurred-asy-terraformed"
  location = "EU"
  # To delete a bucket with objects inside
  force_destroy               = true
  uniform_bucket_level_access = true
  project                     = "episen-blur-project"
  storage_class               = "STANDARD"
  public_access_prevention    = "inherited"
}

resource "google_storage_bucket" "episen-blurred-asy-terraformed" {
  name     = "episen-blurred-asy-terraformed"
  location = "EU"
  # To delete a bucket with objects inside
  force_destroy               = true
  uniform_bucket_level_access = true
  project                     = "episen-blur-project"
  storage_class               = "STANDARD"
  public_access_prevention    = "inherited"
}