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

function downloadFile(data, name) {
    const blob = new Blob([data], {type: "octet-stream"});
    console.log(blob);
    const href = new createObjectURL(blob);
    const a = Object.assign(document.createElement('a'), {
        href,
        style : "display:None",
        download : name
    });

    a.click();
    URL.revokeObjectURL(href)
}


document.getElementById("download").addEventListener('click', function () {
    url = 'https://us-central1-episen-blur-project.cloudfunctions.net/CFunctions-HTTTP-Search/?file=' + selected_image
    $.ajax({
        url: url,
        type: 'GET',
        success: function (data) {
            //https://codepen.io/shospodarets/pen/emWmBz
            // var blob = new Blob([data], { type: "application/octet-stream" });
            // //Check the Browser type and download the File.
            // var isIE = false || !!document.documentMode;
            // if (isIE) {
            //     window.navigator.msSaveBlob(blob, fileName);
            // } else {
            //     var url = window.URL || window.webkitURL;
            //     link = url.createObjectURL(blob);
            //     var a = $("<a />");
            //     a.attr("download", selected_image);
            //     a.attr("href", link);
            //     $("body").append(a);
            //     a[0].click();
            //     $("body").remove(a);
            // }
            downloadFile(data, selected_image)
        }
    });
});


