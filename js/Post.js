﻿var modal = document.getElementById('AddEmbededComment');

// Get the button that opens the modal
var btn = document.getElementById("Testbtn");

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];

// When the user clicks the button, open the modal 
btn.onclick = function () {
    modal.style.display = "block";
}

// When the user clicks on <span> (x), close the modal
span.onclick = function () {
    modal.style.display = "none";
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function (event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}

function SetCommentID()
{
    var buttonClicked = document.getElementById("")
}


$('CommentBox').keyup(updateCount);
$('CommentBox').keydown(updateCount);

function updateCount() {
    var cs = $(this).val().length;
    $('#characters').text(cs);
}

