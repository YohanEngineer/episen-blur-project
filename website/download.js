let selected_image = ""
$.ajax({
    url: 'https://us-central1-episen-blur-project.cloudfunctions.net/CFunctions-HTTTP-Search',
    type: 'GET',
    dataType: 'json',
    success: function (files) {
        console.log(files);
        console.log(files['list'])
        for (let i = 0; i < files['list'].length; i++) {
            document.getElementById("list").innerHTML += '<option value="' + files['list'][i] + '">' + files['list'][i] + '</option>'
        }
    }
});

document.getElementById("list").addEventListener('click', function () {
    selected_image = document.getElementById("list").options[list.options.selectedIndex].value;
    console.log(selected_image);
});


document.getElementById("download").addEventListener('click', function () {
    url = 'https://us-central1-episen-blur-project.cloudfunctions.net/CFunctions-HTTTP-Search/?file=' + selected_image

    var aElement = document.createElement('a');
    aElement.href = url;

    aElement.download = 'image.jpg';

    document.body.appendChild(aElement);

    aElement.click();

});


