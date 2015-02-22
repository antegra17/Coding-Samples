<?php
    include("./dbinfo.inc.php");

function returnFeedPopAll($cuser,$set,$mode,$guser,$country){

$jsonfeed['set'] = array();
$jsonfeed['username'] = array();
$jsonfeed['postnum'] = array();
$jsonfeed['description'] = array();
$jsonfeed['touser'] = array();
$jsonfeed['topost'] = array();
$jsonfeed['comment'] = array();
$jsonfeed['timesince'] = array();
$jsonfeed['type'] = array();
$jsonfeed['country'] = array();


if ($mode == '') {

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
    $num=mysql_numrows($result);
    
   $query="DROP TABLE temptracks";
   mysql_query($query);

$query="DROP TABLE tempcomments";
   mysql_query($query);

$query="DROP TABLE tempposts";
   mysql_query($query);

$query="DROP TABLE templikes";
   mysql_query($query);
}
else if ($mode=='global'){
$query="SELECT * FROM posts ORDER BY numlikes DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);
}
else if ($mode=='cty'){
$query="SELECT * FROM posts,users WHERE posts.username = users.username  AND users.country = '$country' ORDER BY posts.time DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);

//echo "$num";
}
else if ($mode == 'profile'){
$query="SELECT * FROM posts WHERE username = '$guser' ORDER BY posts.time DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);
//echo "$num";
}
$i=$set;

if ($num <= $set +8){
   $set = 0;
}
else {
$totalnum = $num; $num = $set+8;
}
array_push ($jsonfeed['set'],$set);


    while ($i < $num)
    {
        $username = mysql_result($result,$i,"username");
        $postnum = mysql_result($result,$i,"postnum");
$description = mysql_result($result,$i,"description");
        $touser = mysql_result($result,$i,"touser");
        $topost = mysql_result($result,$i,"topost");
        $comment = mysql_result($result,$i,"comment");
        $time = mysql_result($result,$i,"time");
        $type = mysql_result($result,$i,"type");


$resultdiff= mysql_query("SELECT TIMESTAMPDIFF(SECOND,'$time',CURRENT_TIMESTAMP)");
$row=mysql_fetch_array($resultdiff);
$ago=$row["TIMESTAMPDIFF(SECOND,'$time',CURRENT_TIMESTAMP)"];
$timesince = time_since($ago);

if ($i != $totalnum-1 && $i <= $totalnum-1)
{
    $usernamen = mysql_result($result,$i+1,"username");
    $tousern = mysql_result($result,$i+1,"touser");
$timen = mysql_result($result,$i+1,"time");
$typen = mysql_result($result,$i+1,"type");
}

if (($username == $usernamen && $time == $timen && $touser==$tousern && $type==$typen) || $type=='ts'){
}
else{
array_push ($jsonfeed['username'],$username);
array_push ($jsonfeed['postnum'],$postnum);
array_push ($jsonfeed['description'],$description);
array_push ($jsonfeed['touser'],$touser);
array_push ($jsonfeed['topost'],$topost);
array_push ($jsonfeed['comment'],$comment);
array_push ($jsonfeed['timesince'],$timesince);
array_push ($jsonfeed['type'],$type);

if($mode=='global'){
$querycty="SELECT * FROM users WHERE username = '$username'";
    $resultcty=mysql_query($querycty);
   $countryget = mysql_result($resultcty,0,"country");
array_push ($jsonfeed['country'],$countryget);
}
if($mode=='cty'){
array_push ($jsonfeed['country'],$country);
}



}

 $i++;
}

return $jsonfeed;
}




function returnLCpopall($cuser,$set,$mode,$guser,$country){

$jsonfeed['set'] = array();
$jsonfeed['username'] = array();
$jsonfeed['postnum'] = array();
$jsonfeed['description'] = array();
$jsonfeed['touser'] = array();
$jsonfeed['topost'] = array();
$jsonfeed['comment'] = array();
$jsonfeed['timesince'] = array();
$jsonfeed['type'] = array();
$jsonfeed['country'] = array();

    
$jsonfeed['numlikes'] = array();
$jsonfeed['numcomments'] = array();
$jsonfeed['likecheck'] = array();
$jsonfeed['likeusers'] = array();
$jsonfeed['commentusers'] = array();
$jsonfeed['commenttexts'] = array();
$jsonfeed['commentagos'] = array();
$jsonfeed['commenttimes'] = array();

if ($mode == '') {

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
    $num=mysql_numrows($result);
    
   $query="DROP TABLE temptracks";
   mysql_query($query);

$query="DROP TABLE tempcomments";
   mysql_query($query);

$query="DROP TABLE tempposts";
   mysql_query($query);

$query="DROP TABLE templikes";
   mysql_query($query);
}
else if ($mode=='global'){
$query="SELECT * FROM posts ORDER BY numlikes DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);
}
else if ($mode=='cty'){
$query="SELECT * FROM posts,users WHERE posts.username = users.username  AND users.country = '$country' ORDER BY posts.time DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);

//echo "$num";
}
else if ($mode == 'profile'){
$query="SELECT * FROM posts WHERE username = '$guser' ORDER BY posts.time DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);
//echo "$num";
}
$i=$set;

if ($num <= $set +8){
   $set = 0;
}
else {
$totalnum = $num; $num = $set+8;
}
array_push ($jsonfeed['set'],$set);


    while ($i < $num)
    {
        $username = mysql_result($result,$i,"username");
        $postnum = mysql_result($result,$i,"postnum");
$description = mysql_result($result,$i,"description");
        $touser = mysql_result($result,$i,"touser");
        $topost = mysql_result($result,$i,"topost");
        $comment = mysql_result($result,$i,"comment");
        $time = mysql_result($result,$i,"time");
        $type = mysql_result($result,$i,"type");


$resultdiff= mysql_query("SELECT TIMESTAMPDIFF(SECOND,'$time',CURRENT_TIMESTAMP)");
$row=mysql_fetch_array($resultdiff);
$ago=$row["TIMESTAMPDIFF(SECOND,'$time',CURRENT_TIMESTAMP)"];
$timesince = time_since($ago);

if ($i != $totalnum-1 && $i <= $totalnum-1)
{
    $usernamen = mysql_result($result,$i+1,"username");
    $tousern = mysql_result($result,$i+1,"touser");
$timen = mysql_result($result,$i+1,"time");
$typen = mysql_result($result,$i+1,"type");
}

if (($username == $usernamen && $time == $timen && $touser==$tousern && $type==$typen) || $type=='ts'){
}
else{

//start return all likes

$query= "SELECT username FROM likes WHERE username = '$cuser' AND touser='$username' AND topost='$postnum'";
    $resultcheck=mysql_query($query);
    $likecheck=mysql_numrows($resultcheck);

array_push ($jsonfeed['likecheck'],$likecheck);



$query="SELECT * FROM likes WHERE likes.touser='$username' AND likes.topost='$postnum'";

$resultlikes=mysql_query($query);

$numlikes=mysql_numrows($resultlikes);

array_push ($jsonfeed['username'],$username);
array_push ($jsonfeed['postnum'],$postnum);
array_push ($jsonfeed['numlikes'],$numlikes);

$c=0;
    while ($c < $numlikes)
    {
$userwholiked=mysql_result($resultlikes,$c,"username");

array_push ($jsonfeed['likeusers'],$userwholiked);


$c++;
    } 


//end return likes start comments

$query="SELECT * FROM comments WHERE comments.touser='$username' AND comments.topost='$postnum' ORDER BY comments.id";

     $resultcomments=mysql_query($query);

$numcomments=mysql_numrows($resultcomments);

array_push ($jsonfeed['numcomments'],$numcomments);


if($numcomments >6)
$c=$numcomments-6;
else $c=0;

    while ($c < $numcomments)
    {
$userwhocommented=mysql_result($resultcomments,$c,"username");
$comment=mysql_result($resultcomments,$c,"comment");
$timecommented=mysql_result($resultcomments,$c,"time");

$resultdiff= mysql_query("SELECT TIMESTAMPDIFF(SECOND,'$timecommented',CURRENT_TIMESTAMP)");
$row=mysql_fetch_array($resultdiff);
$ago=$row["TIMESTAMPDIFF(SECOND,'$timecommented',CURRENT_TIMESTAMP)"];
$timesince = time_since($ago);

array_push ($jsonfeed['commentusers'],$userwhocommented);
array_push ($jsonfeed['commenttexts'],$comment);

array_push ($jsonfeed['commentagos'],$timesince);

array_push ($jsonfeed['commenttimes'],$timecommented);


$c++;

    }

//end return comments

}
$i++;
}

return $jsonfeed;
}


function returnFeed($cuser,$set,$mode,$guser,$country){

$jsonfeed['set'] = array();
$jsonfeed['username'] = array();
$jsonfeed['postnum'] = array();
$jsonfeed['description'] = array();
$jsonfeed['touser'] = array();
$jsonfeed['topost'] = array();
$jsonfeed['comment'] = array();
$jsonfeed['timesince'] = array();
$jsonfeed['type'] = array();
$jsonfeed['country'] = array();


if ($mode == '') {

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
    $num=mysql_numrows($result);
    
   $query="DROP TABLE temptracks";
   mysql_query($query);

$query="DROP TABLE tempcomments";
   mysql_query($query);

$query="DROP TABLE tempposts";
   mysql_query($query);

$query="DROP TABLE templikes";
   mysql_query($query);
}
else if ($mode=='global'){
$query="SELECT * FROM posts ORDER BY posts.time DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);
}
else if ($mode=='cty'){
$query="SELECT * FROM posts,users WHERE posts.username = users.username  AND users.country = '$country' ORDER BY posts.time DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);

//echo "$num";
}
else if ($mode == 'profile'){
$query="SELECT * FROM posts WHERE username = '$guser' ORDER BY posts.time DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);
//echo "$num";
}
$i=$set;

if ($num <= $set +8){
   $set = 0;
}
else {
$totalnum = $num; $num = $set+8;
}
array_push ($jsonfeed['set'],$set);


    while ($i < $num)
    {
        $username = mysql_result($result,$i,"username");
        $postnum = mysql_result($result,$i,"postnum");
$description = mysql_result($result,$i,"description");
        $touser = mysql_result($result,$i,"touser");
        $topost = mysql_result($result,$i,"topost");
        $comment = mysql_result($result,$i,"comment");
        $time = mysql_result($result,$i,"time");
        $type = mysql_result($result,$i,"type");


$resultdiff= mysql_query("SELECT TIMESTAMPDIFF(SECOND,'$time',CURRENT_TIMESTAMP)");
$row=mysql_fetch_array($resultdiff);
$ago=$row["TIMESTAMPDIFF(SECOND,'$time',CURRENT_TIMESTAMP)"];
$timesince = time_since($ago);

if ($i != $totalnum-1 && $i <= $totalnum-1)
{
    $usernamen = mysql_result($result,$i+1,"username");
    $tousern = mysql_result($result,$i+1,"touser");
$timen = mysql_result($result,$i+1,"time");
$typen = mysql_result($result,$i+1,"type");
}

if (($username == $usernamen && $time == $timen && $touser==$tousern && $type==$typen) || $type=='ts'){
}
else{
array_push ($jsonfeed['username'],$username);
array_push ($jsonfeed['postnum'],$postnum);
array_push ($jsonfeed['description'],$description);
array_push ($jsonfeed['touser'],$touser);
array_push ($jsonfeed['topost'],$topost);
array_push ($jsonfeed['comment'],$comment);
array_push ($jsonfeed['timesince'],$timesince);
array_push ($jsonfeed['type'],$type);

if($mode=='global'){
$querycty="SELECT * FROM users WHERE username = '$username'";
    $resultcty=mysql_query($querycty);
   $countryget = mysql_result($resultcty,0,"country");
array_push ($jsonfeed['country'],$countryget);
}
if($mode=='cty'){
array_push ($jsonfeed['country'],$country);
}



}

 $i++;
}

return $jsonfeed;
}


function returnLC($cuser,$set,$mode,$guser,$country){

$jsonfeed['set'] = array();
$jsonfeed['username'] = array();
$jsonfeed['postnum'] = array();
$jsonfeed['description'] = array();
$jsonfeed['touser'] = array();
$jsonfeed['topost'] = array();
$jsonfeed['comment'] = array();
$jsonfeed['timesince'] = array();
$jsonfeed['type'] = array();
$jsonfeed['country'] = array();

    
$jsonfeed['numlikes'] = array();
$jsonfeed['numcomments'] = array();
$jsonfeed['likecheck'] = array();
$jsonfeed['likeusers'] = array();
$jsonfeed['commentusers'] = array();
$jsonfeed['commenttexts'] = array();
$jsonfeed['commentagos'] = array();
$jsonfeed['commenttimes'] = array();

if ($mode == '') {

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
    $num=mysql_numrows($result);
    
   $query="DROP TABLE temptracks";
   mysql_query($query);

$query="DROP TABLE tempcomments";
   mysql_query($query);

$query="DROP TABLE tempposts";
   mysql_query($query);

$query="DROP TABLE templikes";
   mysql_query($query);
}
else if ($mode=='global'){
$query="SELECT * FROM posts ORDER BY posts.time DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);
}
else if ($mode=='cty'){
$query="SELECT * FROM posts,users WHERE posts.username = users.username  AND users.country = '$country' ORDER BY posts.time DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);

//echo "$num";
}
else if ($mode == 'profile'){
$query="SELECT * FROM posts WHERE username = '$guser' ORDER BY posts.time DESC";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);
//echo "$num";
}
$i=$set;

if ($num <= $set +8){
   $set = 0;
}
else {
$totalnum = $num; $num = $set+8;
}
array_push ($jsonfeed['set'],$set);


    while ($i < $num)
    {
        $username = mysql_result($result,$i,"username");
        $postnum = mysql_result($result,$i,"postnum");
$description = mysql_result($result,$i,"description");
        $touser = mysql_result($result,$i,"touser");
        $topost = mysql_result($result,$i,"topost");
        $comment = mysql_result($result,$i,"comment");
        $time = mysql_result($result,$i,"time");
        $type = mysql_result($result,$i,"type");


$resultdiff= mysql_query("SELECT TIMESTAMPDIFF(SECOND,'$time',CURRENT_TIMESTAMP)");
$row=mysql_fetch_array($resultdiff);
$ago=$row["TIMESTAMPDIFF(SECOND,'$time',CURRENT_TIMESTAMP)"];
$timesince = time_since($ago);

if ($i != $totalnum-1 && $i <= $totalnum-1)
{
    $usernamen = mysql_result($result,$i+1,"username");
    $tousern = mysql_result($result,$i+1,"touser");
$timen = mysql_result($result,$i+1,"time");
$typen = mysql_result($result,$i+1,"type");
}

if (($username == $usernamen && $time == $timen && $touser==$tousern && $type==$typen) || $type=='ts'){
}
else{

//start return all likes

$query= "SELECT username FROM likes WHERE username = '$cuser' AND touser='$username' AND topost='$postnum'";
    $resultcheck=mysql_query($query);
    $likecheck=mysql_numrows($resultcheck);

array_push ($jsonfeed['likecheck'],$likecheck);



$query="SELECT * FROM likes WHERE likes.touser='$username' AND likes.topost='$postnum'";

$resultlikes=mysql_query($query);

$numlikes=mysql_numrows($resultlikes);

array_push ($jsonfeed['username'],$username);
array_push ($jsonfeed['postnum'],$postnum);
array_push ($jsonfeed['numlikes'],$numlikes);

$c=0;
    while ($c < $numlikes)
    {
$userwholiked=mysql_result($resultlikes,$c,"username");

array_push ($jsonfeed['likeusers'],$userwholiked);


$c++;
    } 


//end return likes start comments

$query="SELECT * FROM comments WHERE comments.touser='$username' AND comments.topost='$postnum' ORDER BY comments.id";

     $resultcomments=mysql_query($query);

$numcomments=mysql_numrows($resultcomments);

array_push ($jsonfeed['numcomments'],$numcomments);


if($numcomments >6)
$c=$numcomments-6;
else $c=0;

    while ($c < $numcomments)
    {
$userwhocommented=mysql_result($resultcomments,$c,"username");
$comment=mysql_result($resultcomments,$c,"comment");
$timecommented=mysql_result($resultcomments,$c,"time");

$resultdiff= mysql_query("SELECT TIMESTAMPDIFF(SECOND,'$timecommented',CURRENT_TIMESTAMP)");
$row=mysql_fetch_array($resultdiff);
$ago=$row["TIMESTAMPDIFF(SECOND,'$timecommented',CURRENT_TIMESTAMP)"];
$timesince = time_since($ago);

array_push ($jsonfeed['commentusers'],$userwhocommented);
array_push ($jsonfeed['commenttexts'],$comment);

array_push ($jsonfeed['commentagos'],$timesince);

array_push ($jsonfeed['commenttimes'],$timecommented);


$c++;

    }

//end return comments

}
$i++;
}

return $jsonfeed;
}





function time_since($since) {
    $chunks = array(
        array(60 * 60 * 24 * 365 , 'year'),
        array(60 * 60 * 24 * 30 , 'month'),
        array(60 * 60 * 24 * 7, 'week'),
        array(60 * 60 * 24 , 'day'),
        array(60 * 60 , 'hour'),
        array(60 , 'minute'),
        array(1 , 'second')
    );

    for ($i = 0, $j = count($chunks); $i < $j; $i++) {
        $seconds = $chunks[$i][0];
        $name = $chunks[$i][1];
        if (($count = floor($since / $seconds)) != 0) {
            break;
        }
    }

    $print = ($count == 1) ? '1 '.$name : "$count {$name}s";
    return $print;
}





function returnComments($touser,$topost,$set){

$query="SELECT * FROM comments WHERE comments.touser='$touser' AND comments.topost='$topost' ORDER BY comments.id";

     $resultcomments=mysql_query($query);

$numcomments=mysql_numrows($resultcomments);

$jsoncomments['touser'] = array();
$jsoncomments['topost'] = array();
$jsoncomments['count'] = array();
$jsoncomments['userwhocommented'] = array();
$jsoncomments['comment'] = array();
$jsoncomments['time'] = array();
$jsoncomments['ago'] = array();
$jsoncomments['set'] = array();

array_push ($jsoncomments['touser'],$touser);
array_push ($jsoncomments['topost'],$topost);
array_push ($jsoncomments['count'],$numcomments);
array_push ($jsoncomments['set'],$set);

if ($set =='addrecent' || $set == 'removerecent' || $set=='recent' || $set == 'retrievefeed')
{
if($numcomments >6)
$c=$numcomments-6;
else $c=0;
}else $c=0;

    while ($c < $numcomments)
    {
$userwhocommented=mysql_result($resultcomments,$c,"username");
$comment=mysql_result($resultcomments,$c,"comment");
$timecommented=mysql_result($resultcomments,$c,"time");

$resultdiff= mysql_query("SELECT TIMESTAMPDIFF(SECOND,'$timecommented',CURRENT_TIMESTAMP)");
$row=mysql_fetch_array($resultdiff);
$ago=$row["TIMESTAMPDIFF(SECOND,'$timecommented',CURRENT_TIMESTAMP)"];
$timesince = time_since($ago);

array_push ($jsoncomments['userwhocommented'],$userwhocommented);
array_push ($jsoncomments['comment'],$comment);
array_push ($jsoncomments['time'],$timecommented);
array_push ($jsoncomments['ago'],$timesince);

$c++;

    }

return $jsoncomments;
}




function returnPost($username,$postnum,$set){

$query="SELECT * FROM posts WHERE username = '$username' AND postnum ='$postnum'";

    $result=mysql_query($query);
    
    $num=mysql_numrows($result);

if ($num >0){

$username = mysql_result($result,0,"username");
        $postnum = mysql_result($result,0,"postnum");
$description = mysql_result($result,0,"description");
        $time = mysql_result($result,0,"time");
}
   
$resultdiff= mysql_query("SELECT TIMESTAMPDIFF(SECOND,'$time',CURRENT_TIMESTAMP)");
$row=mysql_fetch_array($resultdiff);
$ago=$row["TIMESTAMPDIFF(SECOND,'$time',CURRENT_TIMESTAMP)"];
$timesince = time_since($ago);

$jsonpost['username'] = array();
$jsonpost['postnum'] = array();
$jsonpost['description'] = array();
$jsonpost['ago'] = array();
$jsonpost['set'] = array();

array_push ($jsonpost['username'],$username);
array_push ($jsonpost['postnum'],$postnum);
array_push ($jsonpost['description'],$description);
array_push ($jsonpost['ago'],$timesince);
array_push ($jsonpost['set'],$set);


return $jsonpost;
}

?>



