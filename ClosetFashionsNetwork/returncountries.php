<?php
    include("./dbinfo.inc.php");
include("./functions.php");
    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    @mysql_select_db($mysql_database) or die( "Unable to select database");
$query="SELECT * FROM countries ORDER BY country ASC";
$ctyresult = mysql_query($query);
$num=mysql_numrows($ctyresult);
$i=0;
while($i < $num){
$countrygot = mysql_result($ctyresult, $i, "country");
$numusers = mysql_result($ctyresult, $i, "numusers");
$numposts = mysql_result($ctyresult, $i, "numposts");
if($numposts > 0){
echo ",$countrygot";
}
$i++;
}
mysql_close();
?>
