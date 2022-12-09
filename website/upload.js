
let extensions = ["JPEG", "PNG", "GIF", "BMP", "WEBP", "RAW", "ICO", "TIFF"];

// Get the form element
const form = document.querySelector('form');

// Listen for the submit event on the form
form.addEventListener('submit', (event) => {
  // Prevent the default form submission behavior
  event.preventDefault();

  // Get the file input element
  const fileInput = form.querySelector('input[type="file"]');

  // Get the selected file
  const file = fileInput.files[0];

  // Create a new FileReader instance
  const reader = new FileReader();

  // Listen for the load event on the FileReader
  reader.readAsDataURL(file);

  reader.addEventListener('load', () => {
    // Get the contents of the file as a data URL

    let formData = new FormData();
    formData.append('image', file);

    let extension = String(file.type).split('/')[1].toUpperCase()

    if (extensions.includes(extension)) {
      uploadImage(formData);
    } else {
      Swal.fire({
        icon: 'error',
        title: 'Oops...',
        text: 'This is not an image, we can\'t upload it!',
      });
    }
  });
});

function uploadImage(formData) {
  let url = 'https://europe-west1-episen-blur-project.cloudfunctions.net/CFunctions-HTTP-input';
  $.ajax({
    url: url,
    type: 'post',
    enctype: 'multipart/form-data',
    crossDomain: true,
    processData: false,
    contentType: false,
    data: formData,
    success: function (data) {
      console.info(data);
      Swal.fire({
        icon: 'info',
        title: 'Cool...',
        text: 'Your image was uploaded, let\'s check it!',
      });
    },
    error: function (data) {
      console.log(data);
    }
  });
}
