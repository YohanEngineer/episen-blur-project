let selected_image = ""
$.ajax({
    url: 'https://europe-west1-episen-blur-project.cloudfunctions.net/CFunctions-HTTTP-Search',
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


document.getElementById("download").addEventListener('click', async function () {
    url = 'https://europe-west1-episen-blur-project.cloudfunctions.net/CFunctions-HTTTP-Search/?file=' + selected_image;
    var aElement = document.createElement('a');
    aElement.href = url;

    aElement.download = selected_image;

    document.body.appendChild(aElement);

    aElement.click();

    await sleep(2000)
    document.body.remove(aElement);
    window.location.href = "index.html";
    window.focus();

});

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}





