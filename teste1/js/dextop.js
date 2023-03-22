$("#start-btn").click(function() {
    $("#start-menu").toggle();
});

$("#ie").click(function() {
    $("#ie-text").css("background-color","#316ac5");
    $("#bin-text").css("background-color","rgba(0,0,0,0)");
});

$("#bin").click(function() {
    $("#bin-text").css("background-color","#316ac5");
    $("#ie-text").css("background-color","rgba(0,0,0,0)");
});


$(".desktop").click(function() {
    $("#start-menu").css("display","none");
});


$("#ie-start").click(function() {
    window.location = "https://www.youtube.com/watch?v=EY8usFt6mow"
});

$("#ie-dank").click(function() {
    window.location = "https://www.youtube.com/watch?v=EY8usFt6mow"
});

$("#log-off-btn").click(function() {
    window.location = "logon.html"
});

$("#shutdown-btn").click(function() {
    window.location = "BSOD.html"
});


//#timing set time
var d = new Date(); // for now
//d.getHours(); // => 9
//d.getMinutes(); // =>  30
//d.getSeconds();


document.getElementById('timing').innerHTML = d.getHours()+":"+d.getMinutes();