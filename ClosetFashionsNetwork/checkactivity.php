
<html><style type="text/css">

.modalOverlay
{
  width:100%;
 height:100%;
  position:absolute;
  top:0;
  left:0;
  margin:0;
  padding:0;
  background:#000;
 opacity:0;
  -webkit-transition: opacity 0.3s ease-in;
  z-index:101;
}


.modalWindow
{
  position:absolute;
  top:0px;
left:0px;
  margin:0;
  border:2px solid #fff;
  width:280px;
  //height:350px;
  //overflow: hidden;
  //overflow-y: scroll;
  color:black;
  padding:10px;
  line-height:18px;
  opacity:0;
  z-index:102;
  background:white;
  -webkit-border-radius:8px;
  -webkit-box-shadow:-1px 2px 12px rgba(0, 0, 0, 0.91);
  -webkit-transition: opacity 0.3s ease-in;
}


body {margin:0;padding:0;width:320px;font-family: "Futura", "Futura-CondensedExtraBold", sans-serif;background-color:white;font-size:14px;color:black; line-height:18px;overflow-x:hidden;}

section{font-family: "Futura", "Futura-Condensed", sans-serif;font-size:40px;font-weight:bold;color:gray; line-height:36px;}

logo{text-align:middle;font-family: "Futura", "Futura-CondensedExtraBold", sans-serif;font-size:45px;font-weight:bold;color:black; line-height:40px;overflow-x:hidden;}

logomag{text-align:middle;font-family: "Futura", "Futura-CondensedExtraBold", sans-serif;font-size:45px;font-weight:bold;color:#ce71db; line-height:40px;overflow-x:hidden;}

name{font-family: "Futura", "Futura-CondensedExtraBold", sans-serif;font-size:40px;font-weight:bold;color:black; line-height:36px;}

country{font-family: "Futura", "Futura-CondensedExtraBold", sans-serif;font-size:40px;font-weight:gray;color:black; line-height:36px;}

a {text-decoration: none;color:#003399;} 

as{text-decoration: none;font-size:10;font-weight:bold;color:#003399; line-height:14px;} 

y{font-size:14;color:black; line-height:18px;}

table{font-size:14;color:black; line-height:18px;}

t{font-size:8;color:gray; font-style:italic;line-height:14px;}

tb{font-size:11;font-style:normal;color:black;line-height:14px;}

comment{font-size:12;color:black; line-height:12px;}

commentT{font-size:14;color:333399; line-height:18px;}

like{font-size:12;color:black; line-height:18px;}

about{font-family: "Futura", "Futura-CondensedExtraBold", sans-serif;font-size:16px;color:black; line-height:22px;}

aboutmag{font-family: "Futura", "Futura-CondensedExtraBold", sans-serif;font-size:18px;font-weight:bold; line-height:22px;color:#ce71db}



form{line-height:0px;}
</style>
<head>
<meta name="viewport" content="width=device-width">

<meta name="viewport" content="initial-scale = 1.00, user-scalable = no">
<script src="./ajax.js"></script>
<script type="text/javascript">

function preventDefaultScrolling(event)
{
  //event.preventDefault(); //this stops the page from scrolling.
}

var previousY;

function exitPopUp()
{
divtest.style.display="block";
document.getElementById('footer').style.display='block';

window.scrollTo(0,previousY);

document.removeEventListener('touchmove',preventDefaultScrolling,false);

document.ontouchmove = function(e){ return true; }

modalWindowElement.style.opacity = 0;
    document.body.removeChild(modalWindowElement);
 }

var modalWindowElement = null;


//show the modal overlay and popup window

var divtest;
function showPopUpMessage(username, postnum) {
  
document.getElementById('divbody').style.display='hidden';
//alert(username + postnum);

document.addEventListener('touchmove',preventDefaultScrolling,false);
   
  modalWindowElement = document.createElement("div");
  modalWindowElement.className = 'modalWindow';
  modalWindowElement.innerHTML = "<div style='float: left; text-align: left; width:310px;padding:0px;'><input type='image' src='backweb@2x.jpg' style='width:310px'  value='Back' onclick='exitPopUp();return false;'><br><br></div><div id ='divpostloadname' style='float: left; text-align: left;width:100px;'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a></div><div id='divpostloadtime' style='float: right; text-align: right'><br><span class='divtrack"+username+"'></span></div><div style='float: left; text-align: left; width:310px;padding:0px;'><br></div><div id='divpostloaddesc' style='float: left; text-align: left; width:310px;padding:0px;'>Loading . . .</div><div style='float: left; text-align: left; width:310px;padding:0px;'><br></div><div id='divpostloadimage' style='float: left; text-align: left;width:155px;padding:0px;'><img width=155 src='http://closetfashionista.uphero.com/users/"+username+"/"+postnum+".png'></div><div style='float: left; text-align: left;width:155px;background:#f5e4ff;padding:0px;min-height:346px;'><div id='divpostloadcomm' style='float: right; text-align: left;width:145px;background:#f5e4ff;padding-left:5px;padding-right:5px;padding-top:5px;'>Loading . . .</div><div style='float: right; text-align: left; width:145px;background:#f5e4ff;padding-left:5px;padding-right:5px;''><form class='loadpostform' onsubmit='ajax_comment(&apos;&apos;,&apos;"+username+"&apos;,"+postnum+",&apos;&apos;,&apos;loadalladd&apos;); return false;'><input type='text' value='"+cuser +"' name='username' style='visibility:hidden; height: 0px; width: 0px;'><input type='text' value='"+username+"' name='touser' style='visibility:hidden; height: 0px; width: 0px;'><input type='text' value='"+postnum+"' name='topost' style='visibility:hidden;height: 0px; width: 0px;'><input  id='commload' type='text' name='comment' value='Leave a comment' style='height: 30px; width: 145px; border: 0; padding: 0px; font-size:14px;' onclick='clearloadcommentbox()'><button type='submit' value='Do A' style='visibility:hidden;height: 0px; width: 0px;'></button></form></div><div class='divlikes"+username+postnum+"' style='float: right; text-align: left; width:145px;background:#f5e4ff;padding-left:5px;padding-right:5px;padding-bottom:5px;'></div></div>";

//modalWindowElement.style.left = 10+ "px";
modalWindowElement.style.padding = 3+ "px";
modalWindowElement.style.width = 310+ "px";  document.body.appendChild(modalWindowElement);
  //setTimeout(function() {

    modalWindowElement.style.opacity = 1;

  //}, 300);
         
         previousY = window.pageYOffset;
        var ypx = 0 + "px";

modalWindowElement.style.top = ypx;

window.scrollTo(0,0);

ajax_post(username,postnum,'retrieve');

var test = "divbody";
divtest =document.getElementById('divbody');
divtest.style.display="none";
}

function showPopUpUserTracks(username,set) {
  document.location = 'catch:startactivity';
document.getElementById('divbody').style.display='hidden';

document.addEventListener('touchmove',preventDefaultScrolling,false);
   
  modalWindowElement = document.createElement("div");
  modalWindowElement.className = 'modalWindow';
  modalWindowElement.innerHTML = "<div style='float: left; text-align: left; width:310px;padding:0px;'><input type='image' src='backweb@2x.jpg' style='width:310px'  value='Back' onclick='exitPopUp();return false;'><br><br></div><div id='divtracksload' style='float: left; text-align: left; width:310px;padding:0px;'><br>Searching for user. . .</div><div style='float: left; text-align: left; width:310px;padding:0px;'><br></div>";

//modalWindowElement.style.left = 10+ "px";
modalWindowElement.style.padding = 3+ "px";
modalWindowElement.style.width = 310+ "px";  document.body.appendChild(modalWindowElement);
  //setTimeout(function() {

    modalWindowElement.style.opacity = 1;

  //}, 300);
         
         previousY = window.pageYOffset;
        var ypx = 0 + "px";

modalWindowElement.style.top = ypx;

window.scrollTo(0,0);

ajax_returntracks(username,set);

var test = "divbody";
divtest =document.getElementById('divbody');
divtest.style.display="none";

document.getElementById('footer').style.display="none";
}


function showPopUpRate() {



document.addEventListener('touchmove',preventDefaultScrolling,false);
   
  modalWindowElement = document.createElement("div");
  modalWindowElement.className = 'modalWindow';
  modalWindowElement.innerHTML = "<div style='float: left; text-align: left; width:310px;padding:0px;'><input type='image' src='backweb@2x.jpg' style='width:310px'  value='Back' onclick='exitPopUp();return false;'><br><br></div><div id='divtracksload' style='float: left; text-align: left; width:290px;padding:10px;'><b>Special Offer! Give your friends FREE copies of ClosetFashions!<b><br><br>If you have the full version, write a review on the App Store saying what you like about ClosetFashions and we'll give you FIVE promo codes so that five of your friends or family can download it for FREE! After you write the review, just email tcdevs@gmail.com with your App Store reviewer name and we'll send you the codes once we see your review.  Only 45 codes are available so act fast! Thanks! - ClosetFashions</div><div style='float: left; text-align: left; width:310px;padding:0px;'><br></div>";

//modalWindowElement.style.left = 10+ "px";
modalWindowElement.style.padding = 3+ "px";
modalWindowElement.style.width = 310+ "px";  document.body.appendChild(modalWindowElement);
  //setTimeout(function() {

    modalWindowElement.style.opacity = 1;

  //}, 300);
         
         previousY = window.pageYOffset;
        var ypx = 0 + "px";

modalWindowElement.style.top = ypx;

window.scrollTo(0,0);


var test = "divbody";
divtest =document.getElementById('divbody');
divtest.style.display="none";

document.getElementById('footer').style.display="none";
}
</script>




 


<script>
function ajax_returntracks(username,set) {
       var poststring = "username=" + username+"&set="+set;
    // alert(poststring);

        var submitTo = 'returntracks.php';

        http('POST', submitTo, ajax_returntracksresponse,poststring);
   }

function ajax_returntracksresponse(data) {

       document.location = 'catch:stopactivity';

var divtrackslist = document.getElementById('divtracksload');

divtrackslist.innerHTML = "";


var itemsinkey=data['username'].length;
        var sets=data['set'][0];
var foruser=data['foruser'][0];

if(sets=='tracks'){
divtrackslist.innerHTML = divtrackslist.innerHTML + "<div style='float: left; text-align: left; width:310px;padding:0px;'>Your tracks<hr size=4 color=gray><br></div>";
}else{
divtrackslist.innerHTML = divtrackslist.innerHTML + "<div style='float: left; text-align: left; width:310px;padding:0px;'>"+foruser+"'s trackers<hr size=4 color=gray><br></div>";
}


       for (var i=0; i<itemsinkey;i++)      {

            var user = data['username'][i];
divtrackslist.innerHTML = divtrackslist.innerHTML + "<br><a href='./feed.php?cuser="+cuser+"&guser="+user+"&mode=profile'>"+ user+"</a>";

}
 
}
</script>

<script>

function showPopUpUserSearch() {
  document.location = 'catch:startactivity';

document.getElementById('divbody').style.display='hidden';

document.addEventListener('touchmove',preventDefaultScrolling,false);
   
  modalWindowElement = document.createElement("div");
  modalWindowElement.className = 'modalWindow';
  modalWindowElement.innerHTML = "<div style='float: left; text-align: left; width:310px;padding:0px;'><input type='image' src='backweb@2x.jpg' style='width:310px'  value='Back' onclick='exitPopUp();return false;'><br><br></div><div id='divusersearchload' style='float: left; text-align: left; width:310px;padding:0px;'><br>Loading . . .</div><div style='float: left; text-align: left; width:310px;padding:0px;'><br></div>";

//modalWindowElement.style.left = 10+ "px";
modalWindowElement.style.padding = 3+ "px";
modalWindowElement.style.width = 310+ "px";  document.body.appendChild(modalWindowElement);
  //setTimeout(function() {

    modalWindowElement.style.opacity = 1;

  //}, 300);
         
         previousY = window.pageYOffset;
        var ypx = 0 + "px";

modalWindowElement.style.top = ypx;

window.scrollTo(0,0);

ajax_search();

var test = "divbody";
divtest =document.getElementById('divbody');
divtest.style.display="none";
document.getElementById('footer').style.display="none";
}

function ajax_search() {

var formobj = document.getElementsByClassName('searchbox');

var searchuser=  formobj[0].search.value;


     var poststring = "searchuser=" + searchuser
   

     var submitTo = 'search.php';

   http('POST', submitTo, ajax_searchresponse,poststring);
   }

function ajax_searchresponse(data) {
       document.location = 'catch:stopactivity';

var divsearchlist = document.getElementById('divusersearchload');

divsearchlist.innerHTML = "";


var itemsinkey=data['username'].length;

divsearchlist.innerHTML = divsearchlist.innerHTML + "<div style='float: left; text-align: left; width:310px;padding:0px;'>User search results<hr size=4 color=gray><br></div>";


   for (var i=0; i<itemsinkey;i++)      {

        var user = data['username'][i];
divsearchlist.innerHTML = divsearchlist.innerHTML + "<br><a href='./feed.php?cuser="+cuser+"&guser="+user+"&mode=profile'>"+ user+"</a>";

}

if(itemsinkey == 0){
 divsearchlist.innerHTML = divsearchlist.innerHTML + "<br>Sorry, user was not found.";

}
}
</script>

</script>




<script>
var feedpostuser=new Array();
var feedpostnum=new Array();
var feedpostloadcount=0;
var morecount = 0;


function ajax_loadmore(username,n){
document.location = 'catch:startactivity';
morecount=morecount+10;
//alert(morecount);
var loadmorepoststring;
if(mode =='')
loadmorepoststring = "username=" + username +  "&set=" + morecount;
if(mode =='global')
loadmorepoststring = "username=" + username +  "&set=" + morecount + "&mode=global";
if(mode =='profile')
loadmorepoststring = "username=" + username +  "&set=" + morecount + "&mode=profile&guser=" + guser;
if(mode =='cty')
loadmorepoststring = "username=" + username +  "&set=" + morecount + "&mode=cty&country=" + country;     

    //alert(loadmorepoststring);
      
        var submitTo = 'loadmore.php';

n.parentNode.parentNode.removeChild(n.parentNode);

feedpostuser.length = 0;
feedpostnum.length = 0;

      http('POST', submitTo, ajax_loadmoreresponse,loadmorepoststring);

}

function ajax_loadmoren(username,n){
morecount=morecount+10;
//alert(morecount);
var loadmorepoststring;
if(mode =='')
loadmorepoststring = "username=" + username +  "&set=" + morecount;
if(mode =='global')
loadmorepoststring = "username=" + username +  "&set=" + morecount + "&mode=global";
if(mode =='profile')
loadmorepoststring = "username=" + username +  "&set=" + morecount + "&mode=profile&guser=" + guser;
if(mode =='cty')
loadmorepoststring = "username=" + username +  "&set=" + morecount + "&mode=cty&country=" + country;     

    //alert(loadmorepoststring);
      
        var submitTo = 'loadmore.php';

//n.parentNode.removeChild(n);

document.removeChild(n);

feedpostuser.length = 0;
feedpostnum.length = 0;

      http('POST', submitTo, ajax_loadmoreresponse,loadmorepoststring);

}

function ajax_loadmoreresponse(data) 
{
document.location = 'catch:stopactivity';

        //alert(newcount);
        var itemsinkey=data['username'].length;
        var set=data['set'][0];
        
var divfeed = document.getElementById('divbody');

       var i=0;
       for ( i=0; i<itemsinkey;i++)      {

            var username = data['username'][i];
            var postnum= data['postnum'][i];
            var description = data['description'][i];
            var touser = data['touser'][i];
            var topost = data['topost'][i];
            var comment= data['comment'][i];
            var timesince = data['timesince'][i];
            var type = data['type'][i];
           var country = data['country'][i];

if (type == 'li'){

 if(touser== cuser && username != cuser){
 divfeed.innerHTML = divfeed.innerHTML +"<div style='margin:3px;float:left;text-align: left;width:230px'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a> liked your outfit (<a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'>"+topost+"</a>).";
}
else if(username == cuser && touser != cuser){
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:230px'>You liked <a href='./feed.php?cuser="+cuser+"&guser="+touser+"&mode=profile'>"+touser+"</a>'s outfit (<a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'>"+topost+"</a>).";
}
else if(username == touser && cuser != username){
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:230px'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a> liked their own outfit (<a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'>"+topost+"</a>).";
}
else if(username == touser && cuser==username){
divfeed.innerHTML = divfeed.innerHTML+ "<div style='margin:3px;float:left;text-align: left;width:230px'>You liked your own outfit (<a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'>"+topost+"</a>).";
}
else{
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:230px'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a> liked <a href='./feed.php?cuser="+cuser+"&guser="+touser+"&mode=profile'>"+touser+"</a>'s outfit (<a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'>"+topost+"</a>).";
}

}//end if li

if (type == 'tr'){

if(touser== cuser){
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:230px'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a> is now tracking you.";
}
else if(username == cuser){
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:230px'>You are now tracking <a href='./feed.php?cuser="+cuser+"&guser="+touser+"&mode=profile'>"+touser+"</a>.";
}
else{
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:230px'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a> is now tracking <a href='./feed.php?cuser="+cuser+"&guser="+touser+"&mode=profile'>"+touser+"</a>.";
}
}//end if tr

if (type == 'co'){

 if(touser== cuser && username != cuser){
 divfeed.innerHTML = divfeed.innerHTML +"<div style='margin:3px;float:left;text-align: left;width:230px'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a> commented on your outfit (<a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'>"+topost+"</a>).";
}
else if(username == cuser && touser != cuser){
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:230px'>You commented on <a href='./feed.php?cuser="+cuser+"&guser="+touser+"&mode=profile'>"+touser+"</a>'s outfit (<a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'>"+topost+"</a>).";
}
else if(username == touser){
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:230px'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a> commented on their own outfit (<a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'>"+topost+"</a>).";
}
else if(username == touser && username==cuser){
divfeed.innerHTML = divfeed.innerHTML+ "<div style='margin:3px;float:left;text-align: left;width:230px'>You commented on your own outfit (<a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'>"+topost+"</a>).";
}
else{
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:230px'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a> commented on <a href='./feed.php?cuser="+cuser+"&guser="+touser+"&mode=profile'>"+touser+"</a>'s outfit (<a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'>"+topost+"</a>).";
}

}//end if co


if (type != 'po'){ 
divfeed.innerHTML = divfeed.innerHTML+ "</div><div style='margin:3px;float:right; text-align: right;'><t>"+timesince+" ago</t><br><br><br><br></div>";
}


if (type == 'co'){ 
divfeed.innerHTML = divfeed.innerHTML+ "<div style='float: left; text-align:left;'><br><br><br><br></div><div style='width:175px;float:left;margin:10px;'><div style='padding:10px;background:#f5e4ff;float:left;-webkit-border-radius:4px;-webkit-box-shadow:-1px 2px 12px rgba(0, 0, 0, 0.91);'>&quot;<commentT>"+comment+"</commentT>&quot;</div></div><div style='margin-left:10px;float:left;'><div style='margin:0px;width:75px;'><a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'><img width=75 src='./users/"+touser+"/"+topost+".png'></a></div><br></div>";
}

if (type == 'li'){
 divfeed.innerHTML = divfeed.innerHTML + "<div style='margin-left:100px;float:left;'><br><div style='margin:0px;width:75px;'><a href='javascript:return null;' onclick='showPopUpMessage(&apos;"+touser+"&apos;,"+  topost + "); return false;'><img width=75 src='./users/"+touser+"/"+topost+".png'></a></div><br></div>";
}


if (type == 'po'){ 

if (mode != 'cty'&&((mode != 'global' && cuser !=username)||(mode != 'profile' && mode != 'global' && cuser ==username))){
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin: 3px'><div style='float: left; text-align:left;width:100px;'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a></div><div style='float: right; text-align: right'><t>"+timesince+" ago</t><br><span class='divtrack"+username+"'></span></div><div style='float: left; text-align:left;'><br><br></div><div id='desc' style='float: left; text-align:left;width:300px'><y>" +description + "</y></div><div style='float:left;width:300px'><br></div><div style='padding:0px; -webkit-border-radius:0px;-webkit-box-shadow:-1px 2px 12px rgba(0, 0, 0, 0.91);float: left;width:315px;'><div style='width:155px;float:left;'><img width=155 src='./users/"+username+"/"+postnum+".png'></div><div style='float: right;width:160px;min-height:346px;background:#f5e4ff;'><div id='div"+username+postnum+"' style='float:right;text-align: left;width:150px;background:#f5e4ff;padding-left:5px;padding-right:5px;padding-top:5px;'>Loading comments...</div><div style='float: right; text-align: left; width:150px;background:#f5e4ff;padding-left:5px;padding-right:5px;'><form class='"+username+postnum+"' onsubmit='ajax_comment(&apos;&apos;,&apos;"+username+"&apos;,"+postnum+",&apos;&apos;,&apos;addrecent&apos;); return false;'><input type='text' value='"+cuser +"' name='username' style='visibility:hidden; height: 0px; width: 0px;'><input type='text' value='"+username+"' name='touser' style='visibility:hidden; height: 0px; width: 0px;'><input type='text' value='"+postnum+"' name='topost' style='visibility:hidden;height: 0px; width: 0px;'><input  id='comm"+username+postnum+"' type='text' name='comment' value='Leave a comment' style='height: 30px; width: 150px; border: 0; padding: 0px; font-size:14px;' onclick='clearcommentbox(&apos;comm"+username+postnum+"&apos;)'><button type='submit' value='Do A' style='visibility:hidden;height: 0px; width: 0px;'></button></form></div><div class='divlikes"+username+postnum+"' style='float: right; text-align: left; width:150px;background:#f5e4ff;padding-left:5px;padding-right:5px;padding-bottom:5px;'></div></div></div><div style='float: left; text-align:left;width:310px;'><br></div>";

if(newcount>0){
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:310px;'><hr size=4 color=#ce71db></div>";
newcount--;}
else{
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin:3px;float:left;text-align: left;width:310px;'><hr size=4 color=gray></div>";}

}
else if (mode == 'global' || mode == 'cty'){
divfeed.innerHTML = divfeed.innerHTML + "<div style='margin: 3px'><div style='float: left; text-align:left;width:100px;'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a>/"+country+"</div><div style='float: right; text-align: right'><t>"+timesince+" ago</t><br><span class='divtrack"+username+"'></span></div><div style='float: left; text-align:left;'><br><br></div><div id='desc' style='float: left; text-align:left;width:300px'><y>" +description + "</y></div><div style='float:left;width:300px'><br></div></div><div style='padding:0px; -webkit-border-radius:0px;-webkit-box-shadow:-1px 2px 12px rgba(0, 0, 0, 0.91);float: left;width:315px;'><div style='width:155px;float:left;'><img width=155 src='./users/"+username+"/"+postnum+".png'></div><div style='float: right;width:160px;min-height:346px;background:#f5e4ff;'><div id='div"+username+postnum+"' style='float:right;text-align: left;width:150px;background:#f5e4ff;padding-left:5px;padding-right:5px;padding-top:5px;'>Loading comments...</div><div style='float: right; text-align: left; width:150px;background:#f5e4ff;padding-left:5px;padding-right:5px;'><form class='"+username+postnum+"' onsubmit='ajax_comment(&apos;&apos;,&apos;"+username+"&apos;,"+postnum+",&apos;&apos;,&apos;addrecent&apos;); return false;'><input type='text' value='"+cuser +"' name='username' style='visibility:hidden; height: 0px; width: 0px;'><input type='text' value='"+username+"' name='touser' style='visibility:hidden; height: 0px; width: 0px;'><input type='text' value='"+postnum+"' name='topost' style='visibility:hidden;height: 0px; width: 0px;'><input  id='comm"+username+postnum+"' type='text' name='comment' value='Leave a comment' style='height: 30px; width: 150px; border: 0; padding: 0px; font-size:14px;' onclick='clearcommentbox(&apos;comm"+username+postnum+"&apos;)'><button type='submit' value='Do A' style='visibility:hidden;height: 0px; width: 0px;'></button></form></div><div class='divlikes"+username+postnum+"' style='float: right; text-align: left; width:150px;background:#f5e4ff;padding-left:5px;padding-right:5px;padding-bottom:5px;'></div></div></div><div style='float: left; text-align:left;width:310px;'><br></div><div style='margin:3px;float:left;text-align: left;width:310px;'><hr size=4 color=gray></div>";
}
else if (mode == 'profile' && cuser==username){
divfeed.innerHTML = divfeed.innerHTML + "<span id='divpost"+username+postnum+"'><div style='margin: 3px'><div style='float: left; text-align:left;width:100px;'><a href='./feed.php?cuser="+cuser+"&guser="+username+"&mode=profile'>"+username+"</a></div><div style='float: right; text-align: right'><t>"+timesince+" ago</t><br><a href='javascript:return null;' onclick='ajax_post(&apos;"+cuser+"&apos;,&apos;"+postnum+"&apos;,&apos;remove&apos;); return false;'><t>Remove your post</t></a><span class='divtrack"+username+"'></span></div><div style='float: left; text-align:left;'><br><br></div><div id='desc' style='float: left; text-align:left;width:300px'><y>" +description + "</y></div><div style='float:left;width:300px'><br></div><div style='padding:0px; -webkit-border-radius:0px;-webkit-box-shadow:-1px 2px 12px rgba(0, 0, 0, 0.91);float: left;width:315px;'><div style='width:155px;float:left;'><img width=155 src='./users/"+username+"/"+postnum+".png'></div><div style='float: right;width:160px;min-height:346px;background:#f5e4ff;'><div id='div"+username+postnum+"' style='float:right;text-align: left;width:150px;background:#f5e4ff;padding-left:5px;padding-right:5px;padding-top:5px;'>Loading comments...</div><div style='float: right; text-align: left; width:150px;background:#f5e4ff;padding-left:5px;padding-right:5px;'><form class='"+username+postnum+"' onsubmit='ajax_comment(&apos;&apos;,&apos;"+username+"&apos;,"+postnum+",&apos;&apos;,&apos;addrecent&apos;); return false;'><input type='text' value='"+cuser +"' name='username' style='visibility:hidden; height: 0px; width: 0px;'><input type='text' value='"+username+"' name='touser' style='visibility:hidden; height: 0px; width: 0px;'><input type='text' value='"+postnum+"' name='topost' style='visibility:hidden;height: 0px; width: 0px;'><input  id='comm"+username+postnum+"' type='text' name='comment' value='Leave a comment' style='height: 30px; width: 150px; border: 0; padding: 0px; font-size:14px;' onclick='clearcommentbox(&apos;comm"+username+postnum+"&apos;)'><button type='submit' value='Do A' style='visibility:hidden;height: 0px; width: 0px;'></button></form></div><div class='divlikes"+username+postnum+"' style='float: right; text-align: left; width:150px;background:#f5e4ff;padding-left:5px;padding-right:5px;padding-bottom:5px;'></div></div></div><div style='float: left; text-align:left;width:310px;'><br></div><div style='margin:3px;float:left;text-align: left;width:310px;'><hr size=4 color=gray></div></span>";
}

//ajax_track(cuser,username,'checkfeed');
feedpostuser.push(username);
feedpostnum.push(postnum);


}//end if po

if (type != 'po'){ 
if(newcount>0){
divfeed.innerHTML = divfeed.innerHTML +"<div style='float: left; text-align:left;width:310px;'><br></div><div style='margin:3px;float:left;text-align: left;width:310px;'><hr size=4 color=#ce71db></div>";
newcount--;}
else{
divfeed.innerHTML = divfeed.innerHTML +"<div style='float: left; text-align:left;width:310px;'><br></div><div style='margin:3px;float:left;text-align: left;width:310px;'><hr size=4 color=gray></div>";}

}

}//end for itemsinkey

if(set != 0){
divfeed.innerHTML = divfeed.innerHTML + "<br><br><br><br><div style='float: left; text-align:left;'><input type='image' src='loadmore@2x.jpg' style='width:320px' id='exitp' value='Load more' onclick='ajax_loadmore(&apos;"+cuser+"&apos;,this); return false;'></div>";
}

ajax_post(feedpostuser[0],feedpostnum[0],'retrievefeed');

}//end function
</script>
<script>
var divlikesclear;
function ajax_like(username,touser,topost,set) {

document.location = 'catch:startactivity';
       var addlikepoststring = "username=" + username +  "&touser=" + touser + "&topost=" + topost+ "&set=" + set;
     
      // alert(addlikepoststring);
       divlikesclear = "divlikes" + touser+topost;
        var submitTo = 'like.php';

      http('POST', submitTo, ajax_likeresponse,addlikepoststring);
   }

function ajax_likeresponse(data) 
{
document.location = 'catch:stopactivity';
cleardivclass(divlikesclear);
        var itemsinkey=data['userwholiked'].length;
         var numcheck = data['check'][0];
var touser = data['touser'][0];
var topost = data['topost'][0];


        if(itemsinkey ==1)
        var userplural = "person";
         else var userplural = "people";
        if(itemsinkey - 1 ==1)
        var otherplural = "person";
         else var otherplural = "people";


var likes=document.getElementsByClassName(divlikesclear);
var j;

for(j=0;j<likes.length;++j){

if(numcheck==0){
likes[j].innerHTML =likes[j].innerHTML+ 
"<a href='javascript:return null;' onclick='ajax_like(&apos;"+cuser+"&apos;,&apos;"+touser+"&apos;,"+  topost+",&apos;add&apos;); return false;'>Like it!</a><hr size=4>";
}

if(numcheck ==1 && itemsinkey ==1){
likes[j].innerHTML =likes[j].innerHTML+
"<hr size=2 color=white><y>You like this.</y>";
}

else {

      if (numcheck==1){
likes[j].innerHTML =likes[j].innerHTML+
"<hr size=4><like><y>You and <b>"+(itemsinkey-1)+" other "+otherplural+"</b> like this.</y>";
}
if (numcheck==0 && itemsinkey != 0){
likes[j].innerHTML =likes[j].innerHTML+ "<y>Liked by <b>" + itemsinkey + " " + userplural + ".</b></y>";
}

if (itemsinkey != 0)
likes[j].innerHTML =likes[j].innerHTML+"<br><br><y>(";

             var i=0;
              for ( i=0; i<itemsinkey;i++)
              {
                var username = data['userwholiked'][i];
                  if(i == itemsinkey -1 && i != 0) 
                  {
likes[j].innerHTML =likes[j].innerHTML+
"and <a href='./feed.php?cuser="+ cuser + "&guser="+username +"&mode=profile'>"+username+"</a>)</y>";
                   }
                else if (i == itemsinkey -1 && i == 0){
                    likes[j].innerHTML =likes[j].innerHTML+
"<a href='./feed.php?cuser="+ cuser + "&guser="+username +"&mode=profile'>"+username+"</a>)</y> ";
                    } 
else {
 likes[j].innerHTML =likes[j].innerHTML+"<a href='./feed.php?cuser="+cuser+ "&guser="+username +"&mode=profile'>"+username+"</a>, ";
                    }

    }
}


}//close for
}
    </script>



<script>
var cuser;
var guser;
var mode;
var country;
var newcount;
function setPage(g,e,f,h)
{
   cuser = g;
  guser= e;
 mode = f;
country = h;
}
function setNew(i)
{
   newcount = i;
}
</script>





<script>
var divpostclear;
function ajax_post(username,postnum,set) {
document.location = 'catch:startactivity';
       var poststring = "username=" + username + "&postnum=" + postnum + "&set=" + set;
    // alert(poststring);
      
    divpostclear="divpost"+username+postnum;

        var submitTo = 'post.php';

        http('POST', submitTo, ajax_postresponse,poststring);
   }


function ajax_postresponse(data) {

document.location = 'catch:stopactivity';
var set = data['set'][0];
var username = data['username'][0];
var postnum = data['postnum'][0];
var description = data['description'][0];
var ago = data['ago'][0];

if(set=='retrieve'){

document.getElementById('divpostloadname').innerHTML = "<a>"+ username + "</a>";
document.getElementById('divpostloadtime').innerHTML = "<t>"+ago + " ago</t><br><span class='divtrack"+username+"'><y></y></span>" ;
document.getElementById('divpostloaddesc').innerHTML =  "<y>" +description + "</y>";

ajax_track(cuser,username,'check');
ajax_comment('',username,postnum,'','loadpopup');
ajax_like(cuser,username,postnum,'check');
}
else if (set=='retrievefeed'){
//alert(username + postnum);
ajax_track(cuser,username,'checkfeed');
ajax_comment('',username,postnum,'','retrievefeed');
ajax_like(cuser,username,postnum,'check');

}
else if (set=='remove'){
    clearcomments(divpostclear);
}
}




</script>

<script>
var divtrackclear;
function ajax_track(username,touser,set) {
document.location = 'catch:startactivity';
       var trackpoststring = "username=" + username +  "&touser=" + touser + "&set=" + set;
     

       divtrackclear = "divtrack" + touser;
    //  alert(trackpoststring);
     // alert(divtrackclear);

        var submitTo = 'track.php';
if(username != touser)
        http('POST', submitTo, ajax_trackresponse,trackpoststring);

}


function ajax_trackresponse(data) {

document.location = 'catch:stopactivity';
           cleardivclass(divtrackclear);

var check = data['check'][0];
var set = data['set'][0];
var touser= data['touser'][0];
var feed=0;
if(set=='checkfeed') feed=1;


if(set == 'check' || set=='checkfeed'){
      if(check == 1) set = 'track';
      else set = 'untrack';
}


if (set == 'track'){
var tracks=document.getElementsByClassName(divtrackclear);
var i =0;
for(i=0;i<tracks.length;++i){
tracks[i].innerHTML = "<as>Tracking this user!</as><br><a href='javascript:return null;' onclick='javascript:ajax_track(&apos;"+cuser+"&apos;,&apos;"+touser+"&apos;,&apos;untrack&apos;); return false;'><t>Untrack</t></a>";
}
}

if (set == 'untrack'){
var tracks=document.getElementsByClassName(divtrackclear);
var i =0;
for(i=0;i<tracks.length;++i){
tracks[i].innerHTML = "<br><a href='javascript:return null;' onclick='javascript:ajax_track(&apos;"+cuser+"&apos;,&apos;"+touser+"&apos;,&apos;track&apos;); return false;'><t>Track this user</t></a>";
}
}


}


</script>


    <script>
var divclear;
var divclearfeed;
function ajax_comment(cuser,touser,topost,time,set) {
    document.location = 'catch:startactivity';
    var removecommentpoststring = "username=" + cuser + "&touser=" + touser +"&topost=" + topost + "&time=" + time;
    
var commclear;
if(set== 'loadalladd' ) commclear = "commload";
else commclear = "comm" + touser +topost;

if(set=='loadpopup' || set== 'loadalladd' || set =='removeall') {
 divclear = "divpostloadcomm";
 divclearfeed = "div" + touser+topost;
}
else if(set=='retrievefeed'){

  divclear = "div"+ touser + topost;
}
else
  divclear = "div" + touser+ topost;

//alert(divclear);

var loadform;
if(set== 'loadalladd' || set== 'loadpopup') loadform = "loadpostform";
else loadform = touser+topost;
      
       var formobj = document.getElementsByClassName(loadform);

//var string = "test";
//string = formobj[0].comment.value;

        var submitTo = 'comment.php';


 if(set=='all' || set=='loadpopup' || set=='retrievefeed'){
var allcommpoststring = "touser=" + touser + "&topost=" + topost;
    
http('POST', submitTo, ajax_commentresponse,allcommpoststring,set);
}
else if (set=='removerecent' || set =='removeall'){
    http('POST', submitTo, ajax_commentresponse,removecommentpoststring,set);
}
else{
        
    http('POST', submitTo, ajax_commentresponse,formobj[0],set);
if(set != 'recent')
    clearcommentboxandblur(commclear);
}

}
    
function ajax_commentresponse(data)     {
    document.location = 'catch:stopactivity';
       var itemsinkey=data['userwhocommented'].length;
var totalcomments = data['count'][0];
var touser = data['touser'][0];
var topost = data['topost'][0];
   var set = data['set'][0];
    
        clearcomments(divclear);
    
document.getElementById(divclear).innerHTML =document.getElementById(divclear).innerHTML+
"<div style='float: left; text-align: left'><tb>Comments ("+totalcomments+")</tb></div>";

if(itemsinkey < totalcomments)           {
document.getElementById(divclear).innerHTML =document.getElementById(divclear).innerHTML+
 "<a href='javascript:return null;' onclick='javascript:ajax_comment(&apos;&apos;,&apos;"+touser+"&apos;,"+topost+",&apos;&apos;,&apos;all&apos;); return false;'><div style='float: right; text-align: right'><t>Load previous</t></div></a>";
}

document.getElementById(divclear).innerHTML =document.getElementById(divclear).innerHTML+ "<br><hr size=2 color=white >";


        var i=0;
       for ( i=0; i<itemsinkey;i++)      {

            var userwhocommented = data['userwhocommented'][i];
            var comment = data['comment'][i];
            var time = data['time'][i];
            var ago = data['ago'][i];
         
             document.getElementById(divclear).innerHTML =document.getElementById(divclear).innerHTML+

"<div style='float: left; text-align: left'><a href='./feed.php?cuser="+cuser+"&guser="+userwhocommented+"&mode=profile'>"+ userwhocommented + "</a></div><div style='float: right; text-align: right'><t>" + ago+ " ago</t></div><br><br><comment>" + comment + "</comment><br>";


if(cuser==userwhocommented && set !='loadpopup' && set !='loadalladd' && set !='removeall'){ 
document.getElementById(divclear).innerHTML =document.getElementById(divclear).innerHTML+ "<a href='javascript:return null;' onclick='javascript:ajax_comment(&apos;" + cuser + "&apos;," + "&apos;" + touser + "&apos;,"+topost+",&apos;" + time + "&apos;,&apos;removerecent&apos;); return false;'><div style='float: right; text-align: right'><t>Remove</t></div></a><br>";
}

if(cuser==userwhocommented && (set =='loadpopup' || set == 'loadalladd' || set=='removeall')){ 
document.getElementById(divclear).innerHTML =document.getElementById(divclear).innerHTML+ "<a href='javascript:return null;' onclick='javascript:ajax_comment(&apos;" + cuser + "&apos;," + "&apos;" + touser + "&apos;,"+topost+",&apos;" + time + "&apos;,&apos;removeall&apos;); return false;'><div style='float: right; text-align: right'><t>Remove</t></div></a><br>";
}



document.getElementById(divclear).innerHTML =document.getElementById(divclear).innerHTML+"<hr size=2 color=white >";

   }

if (divclear == 'divpostloadcomm') {
divclear = divclearfeed;
ajax_comment('',touser,topost,'','recent');
}

if (set=='retrievefeed' && feedpostloadcount<feedpostuser.length-1){
++feedpostloadcount;
ajax_post(feedpostuser[feedpostloadcount],feedpostnum[feedpostloadcount],'retrievefeed');
}
else{
 feedpostloadcount=0;
}

}
    
    </script>

<script>
function clearcommentbox(cc){

document.getElementById(cc).value = "";
}

function clearloadcommentbox(){

document.getElementById('commload').value = "";
}

function clearcommentboxandblur(cc){

document.getElementById(cc).value = "";
document.getElementById(cc).blur();
}

function clearcomments(divid){

document.getElementById(divid).innerHTML ="";
}

function cleardivclass(divclass){
var tracks=document.getElementsByClassName(divclass);
var i =0;
for(i=0;i<tracks.length;++i){
tracks[i].innerHTML = "";
}
}
</script>
</head>
<body>

<?php 


include("./dbinfo.inc.php");
include("./functions.php");

    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    
    @mysql_select_db($mysql_database) or die( "Unable to select database");
    
    $cuser=$_GET['cuser'];
    $guser=$_GET['guser'];
    $mode=$_GET['mode'];
    $country=$_GET['country'];
    $country = urldecode($country);
    $gotmore=0;

?><script>setPage('<?echo "$cuser', '$guser','$mode','$country";?>');
</script> <?

$newcount=0;

$querylaston="SELECT laston FROM users WHERE username = '$cuser'";
    $resultlaston=mysql_query($querylaston);
$numlast=mysql_numrows($resultlaston);

if ($numlast >0){
    $laston = mysql_result($resultlaston,'0',"laston");}
$oldlaston = $laston;

if ($mode == null){ // TRACKER INFO


$querytracking="SELECT * FROM tracks WHERE username = '$cuser'";
    $result=mysql_query($querytracking);
    $numtracking = mysql_numrows($result);

$tempquery = "CREATE TABLE temptracks SELECT * FROM tracks";
mysql_query($tempquery);

$tempquery = "CREATE TABLE tempcomments SELECT * FROM comments";

mysql_query($tempquery);

$query="(SELECT * FROM posts JOIN tracks WHERE (tracks.username = '$cuser' AND posts.username = tracks.touser) OR (tracks.username ='$cuser' AND tracks.touser = '$cuser' AND posts.username ='$cuser'))

UNION (SELECT * FROM comments JOIN tracks WHERE (tracks.username = '$cuser' AND comments.username = tracks.touser) OR (tracks.username ='$cuser' AND tracks.touser = '$cuser' AND comments.username ='$cuser') OR (tracks.username ='$cuser' AND tracks.touser = '$cuser' AND comments.touser ='$cuser')) 

UNION (SELECT * FROM comments JOIN tempcomments WHERE tempcomments.username = '$cuser' AND comments.topost = tempcomments.topost AND comments.touser = tempcomments.touser AND comments.username != '$cuser' AND comments.touser != '$cuser') 


UNION (SELECT * FROM likes JOIN tracks WHERE (tracks.username = '$cuser' AND likes.username = tracks.touser) OR (tracks.username ='$cuser' AND tracks.touser = '$cuser' AND likes.touser ='$cuser'))

UNION (SELECT * FROM tracks JOIN temptracks WHERE (temptracks.username = '$cuser' AND tracks.username = temptracks.touser) OR (temptracks.username ='$cuser' AND temptracks.touser = '$cuser' AND tracks.touser ='$cuser'))

ORDER BY 8 DESC";
    
$result=mysql_query($query);
if ($result !='')
    $num=mysql_numrows($result);
else $num=0;
    
   $query="DROP TABLE temptracks";
   mysql_query($query);

$query="DROP TABLE tempcomments";
   mysql_query($query);

$query="DROP TABLE tempposts";
   mysql_query($query);

$query="DROP TABLE templikes";
   mysql_query($query);


$t=0;
if($t<$num){
$username =            mysql_result($result,$t,"username");
   $type = mysql_result($result,$t,"type");
   $time = mysql_result($result,$t,"time");

while($time > $laston && $t<$num)
{
  if ($t != $num-1)
{
    $usernamen = mysql_result($result,$t+1,"username");
$timen = mysql_result($result,$t+1,"time");
$typen = mysql_result($result,$t+1,"type");

if($usernamen == $username && $timen == $time && $typen==$type){}
else{
     
      $newcount++;
}

}//close if t is not equal num - 1
else {
$newcount++;}

$t++;

if($t<$num){
$username =            mysql_result($result,$t,"username");
   $type = mysql_result($result,$t,"type");
   $time = mysql_result($result,$t,"time");}//close

}//close while

}//close if t less than num

}//close if mode null


?><script>setNew('<?echo "$newcount";?>');</script> <?


echo $newcount;
    ?>
</body>
</html>