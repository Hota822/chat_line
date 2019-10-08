/*
function getApiData() {
    var xhr = new XMLHttpRequest();
    var radioButtonId = document.activeElement.value
    xhr.onreadystatechange = function() {
	if (xhr.readyState === 4 && xhr.status === 200) {
	    xhr.open('GET', <%= "#{api_url}?id=radioButtonId" %>);
	    xhr.send();
	    var target = document.getElementById('api');
	    target.innerText = JSON.parse(xhr.responseText);
	}
    };
};

*/


var selection = document.getElementsByClassName('radio');
selection.onclick = function(){
    alert('aaa')
    var xhr = new XMLHttpRequest();
    var radioButtonId = document.activeElement.value;
    var tar = document.getElementById('api');
    tar.innerText ='aaaaaaaaaaaaaaaaaaaaaaa'
    console.log(tar.innerText);
    xhr.onreadystatechange = function(){
	if (xhr.readyState === 4 && xhr.status === 200) {
	    xhr.open('GET', "https://192.168.33.10/kadai?id=" + radioButtonId);
	    xhr.send();
	    var target = document.getElementById('api');
	    target.innerText = JSON.parse(xhr.responseText);
	}
    }
}

