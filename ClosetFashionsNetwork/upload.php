<?php
  
    include("./dbinfo.inc.php");
    
    mysql_connect($mysql_host, $mysql_user, $mysql_password);
    
    mysql_close();
//set_time_limit(0);

    
$username = $_GET["username"];
    
   // echo "$username !!! \r\n";    

$uploadDir = './users/'.$username.'/';      //Uploading to same directory as PHP file

    //echo "$uploaddir !!! \r\n ";
    
$file = basename($_FILES['userfile']['name']);
$uploadFile = $file;
$randomNumber = rand(0, 99999); 
$newName = $uploadDir . $randomNumber . $uploadFile;


    
//echo "$newName !!! \r\n";

if (is_uploaded_file($_FILES['userfile']['tmp_name'])) {

//list($width, $height, $type, $attr) = getimagesize($uploadDir."80186.png");
      
       // echo "height".$height;
	echo "$randomNumber";

} else {
	echo "FAIL";
}

if ($_FILES['userfile']['size']> 750000) {
	exit("Your file is too large."); 
}

if (move_uploaded_file($_FILES['userfile']['tmp_name'], $newName)) {
    $postsize = ini_get('post_max_size');   //Not necessary, I was using these
    $canupload = ini_get('file_uploads');    //server variables to see what was 
    $tempdir = ini_get('upload_tmp_dir');   //going wrong.
    $maxsize = ini_get('upload_max_filesize');
}
    
    
    

    
    
?>