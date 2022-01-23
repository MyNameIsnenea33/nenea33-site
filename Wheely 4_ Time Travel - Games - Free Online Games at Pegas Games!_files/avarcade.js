/*
AV Arcade Pro front-end javascript functions

Author: Andy Venus
Rating stars rollover by Addam M. Driver

*/

var sMax;	// Isthe maximum number of stars
var holder; // Is the holding pattern for clicked state
var preSet; // Is the PreSet value onces a selection has been made
var rated;
var lastHSpage; // Last highscore page
var glWidth; // global game width
var glHeight; // global game height
var fullscreen_active; // Toggle fullscreen game active

window.onresize = resizeFullscreen;

// AJAX for all browsers
function GetXmlHttpObject() {
    var xmlHttp = null;
    try {
        // Firefox, Opera 8.0+, Safari
        xmlHttp = new XMLHttpRequest();
    }
    catch(e) {
        //Internet Explorer
        try {
            xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        }
        catch(e) {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
    }
    return xmlHttp;
}

// AJAX POST FUNCTION
function AjaxPost(url, param, success_function) {
	xmlHttp = GetXmlHttpObject();
    if (xmlHttp == null) {
        alert("Your browser doesn't support AJAX. You should upgrade it!")
        return
    }
    xmlHttp.onreadystatechange = success_function;
    xmlHttp.open("POST", url, true);
    xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlHttp.send(param);
}

function div(d) {
    return document.getElementById(d);
}

// Rollover for image Stars //
function rating(num){
	sMax = 0;	// Isthe maximum number of stars
	for(n=0; n<num.parentNode.childNodes.length; n++){
		if(num.parentNode.childNodes[n].nodeName == "A"){
			sMax++;	
		}
	}
	
	if(!rated){
		s = num.id.replace("_", ''); // Get the selected star
		a = 0;
		for(i=1; i<=sMax; i++){		
			if(i<=s){
				document.getElementById("_"+i).className = "on";
				holder = a+1;
				a++;
			}else{
				document.getElementById("_"+i).className = "";
			}
		}
	}
}

// For when you roll out of the the whole thing //
function off(me){
	if(!rated){
		if(!preSet){	
			for(i=1; i<=sMax; i++){		
				document.getElementById("_"+i).className = "";
			}
		}else{
			rating(preSet);
		}
	}
}

// When you actually rate something //
function rateIt(me, id, site_url){
	if(!rated){
		preSet = me;
		rated=1;
		sendRate(me, id, site_url);
		rating(me);
	}
}

// Send the rating information somewhere using Ajax or something like that
function sendRate(sel, id, site_url){
	AjaxPost(site_url+"/includes/view_game/ajax/add_rating.php", "id=" + id + "&rating=" + sel.title, 
			 function () {}
	)
}

// ADD/DELETE FAV GAME
function AddFav(id, typ, site_url, unfav, fav) {
	AjaxPost(site_url+"/includes/view_game/ajax/add_fav.php", "id=" + id, 
			 function () {}
	)
	
	if (typ == 0) {
		div('favbutton').innerHTML = '<a href="#" onclick="AddFav('+id+', 1, \''+site_url+'\', \''+unfav+'\', \''+fav+'\'); return false">'+unfav+'</a>';
	}
	else {
		div('favbutton').innerHTML = '<a href="#" onclick="AddFav('+id+', 0, \''+site_url+'\', \''+unfav+'\', \''+fav+'\'); return false">'+fav+'</a>';
	}
}


// ADD COMMENT

function AddComment(id, site_url, type) {
	if (div('the_comment').value != '') {
	div('comment_submit').disabled=true;
	div('comment_submit').value="Adding comment...";
	
	thecomment = div('the_comment').value; 
	
	if (type == 'game') {
		post_url = "/includes/view_game/ajax/add_comment.php"
	}
	else {
		post_url = "/includes/news/ajax/news_add_comment.php"
	}
	
	AjaxPost(site_url+post_url, "comment="+thecomment+"&id="+id, 
	function () {
		if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
 			if (xmlHttp.responseText == '') {
	 			alert("An error occured in sending your comment");
 			}
 			else if (xmlHttp.responseText == '<e1>') {
	 			alert("Please wait 60 seconds between comments");
	 			div('comment_submit').value="Add comment";
				div('comment_submit').disabled=false;
 			}
 			else {
 				if (type == 'game') {
  					var container = document.getElementById('comment_list');
  				}
  				else {
  					var container = document.getElementById('news_comment_list');
  				}
  				var new_element = document.createElement('li');
  				new_element.innerHTML = xmlHttp.responseText;
  				container.insertBefore(new_element, container.firstChild);
  				window.location.hash="1"; 
  				div('comment_submit').value="Comment added!";
  				div('the_comment').value = '';
  				setTimeout("EnableButton()",30000);
  			}
		}
	}
	)
	}
}

// Re-enable add-comment button

function EnableButton () {
	div('comment_submit').value="Add comment";
	div('comment_submit').disabled=false;
}

function clickclear(thisfield, defaulttext) {
	if (thisfield.value == defaulttext) {
		thisfield.value = "";
	}
}
    
function clickrecall(thisfield, defaulttext) {
	if (thisfield.value == "") {
		thisfield.value = defaulttext;
	}
}

// Ajax delete comment
function DeleteComment(id, site_url) {
	AjaxPost(site_url+"/admin/includes/delete_comment.php", "id=" + id, 
			 function () {
					div('comment-' + id).style.display = 'none';
    		}
	)
}


// Ajax delete news comment
function DeleteNewsComment(id, site_url) {
	AjaxPost(site_url+"/admin/includes/delete_news_comment.php", "id=" + id, 
			 function () {
					div('comment-' + id).style.display = 'none';
    		}
	)
}

// Load game after ad has been shown
function ShowGame() {
	div('ava-game_container').style.display = 'inline';
	div('ava-advert_container').style.display = 'none';
}

// Show ad countdown
currentsecond = 15;
function countdown(){
	if (currentsecond!=1){
		currentsecond-=1
		div('zzz').innerHTML = currentsecond;
	}
	else{
		ShowGame();
		return
	}
	setTimeout("countdown()",1000)
} 

// Highscore pagintation
function HighscorePage(id, page, leaderboard, site_url, type) {
	div('highscores_ajax').style.opacity = 0.5;
	div('highscore_pages').innerHTML = '<img src="'+site_url+'/images/loader.gif" />';
	
	if (type == 1) {
		lb = div('leaderboard_select').value;
	}
	else {
		lb = leaderboard;
	}
		
	AjaxPost(site_url+"/includes/view_game/highscores.inc.php?id="+id+"&page="+page+'&lb_id='+lb, '', 
	function () {
		div('highscores_ajax').innerHTML = xmlHttp.responseText;
		div('highscores_ajax').style.opacity = 1;
		lastHSpage = page;
	}
	)
}

// Delete highscore
function DeleteHighscore(id, site_url) {
	AjaxPost(site_url+"/admin/includes/delete_highscore.php?", 'id='+id, 
	function () {
		div('game_highscore'+id).style.display = 'none';
	}
	)
}

// REPORT GAME
function SendReport(id, site_url, type) {
	div('report_submit').disabled=true;
	div('report_submit').value="Reporting game...";
	
	thereport = div('the_report').value; 
	
	AjaxPost(site_url+"/includes/view_game/ajax/add_report.php", "report="+thereport+"&id="+id+"&type="+type, 
	function () {
	div('report_submit').disabled=true;
	div('report_submit').value="Game Reported!";
	HidePopup('ava-popup');
	}
	)
//setTimeout("toggleSlide('reportform')",1000);
}

// Window popup
function ShowJsPopup(id, url, title) {
	window.open (url,
"mywindow","menubar=1,resizable=1,width=620,height=250"); 
}

// Show AV Arcade JS popup
function ShowPopup(id, url, title) {
	AjaxPost(url, "", 
		function () {
			if (xmlHttp.readyState == 4 || xmlHttp.readyState == "complete") {
				div(id + '-content').innerHTML = xmlHttp.responseText;
				
				div('ava-game_container').style.visibility = 'hidden';
				div(id + '-title').innerHTML = title;
				div(id).style.display = 'inline';
				div('overlay').style.display = 'inline';
				page_height = getDocHeight();
				div('overlay').style.height = page_height + 'px';
				FadeDiv('overlay', 0, 'up', 0.5);
				div('overlay').onclick = HidePopup;
  			}
		}
	)
}

// Hide AV Arcade JS popup
function HidePopup(id) {
	div('ava-popup').style.display = 'none';
    div('overlay').style.display = 'none';
    div('ava-game_container').style.visibility = 'visible';
}

// Fade a div into view
function FadeDiv(id, opacity, fade, limit) {
    	if (opacity < limit) {
       	    opacity = opacity + 0.08
        	div(id).style.opacity = opacity;
        	setTimeout('FadeDiv("' + id + '", ' + opacity + ', "up", ' + limit + ')', 10); // call doMove() in 20 msec
    	}
}

// Get the document height
function getDocHeight() {
    var D = document;
    return Math.max(
        Math.max(D.body.scrollHeight, D.documentElement.scrollHeight),
        Math.max(D.body.offsetHeight, D.documentElement.offsetHeight),
        Math.max(D.body.clientHeight, D.documentElement.clientHeight)
    );
}

// Fullscreen flash game
function GetHeight() {
	var y = 0;
	if (self.innerHeight) {
		y = self.innerHeight;
	}
	else if (document.documentElement && document.documentElement.clientHeight) {
		y = document.documentElement.clientHeight;
	}
	else if (document.body)	{
		y = document.body.clientHeight;
	}
    return y;
}
function ResizeFlash(gHeight, gWidth) {
	wHeight = GetHeight();
	
	glHeight = gHeight;
	glWidth = gWidth;
	
	w1 = (wHeight / gHeight);
	w2 = (gWidth * w1);
	
	halfWidth = (w2 / 2);
	
	div('eID').setAttribute("width", w2);
	div('eID').setAttribute("height",  wHeight);
	div('ava-game_container').className = 'flash_popup';
	div('ava-game_container').style.marginLeft = '-'+halfWidth+'px';
	
	div('overlay').style.display = 'inline';
	page_height = getDocHeight();
	div('overlay').style.height = page_height + 'px';
	FadeDiv('overlay', 0, 'up', 0.5);
	div('overlay').onclick = ResetFlash;
	
	div('close_fs').style.display = 'inline';
	
	fullscreen_active = 1;
}
function ResetFlash() {
	div('eID').setAttribute("width", glWidth);
	div('eID').setAttribute("height",  glHeight);
	div('ava-game_container').className = 'flash_nopopup';
	div('ava-game_container').style.marginLeft = '0px';
	
	div('overlay').style.display = 'none';
	div('close_fs').style.display = 'none';
	
	fullscreen_active = 0;
}
function resizeFullscreen() {
	if (fullscreen_active == 1) {
		ResizeFlash(glHeight, glWidth);
	}
}

function searchSubmit(site_url, extension) {
	value = div('search_textbox').value;
	value = value.replace(' ', '+');
	window.location = site_url+'/search/'+value+extension;
}