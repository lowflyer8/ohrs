<?php
require 'connect.php';
if(isset($_POST["submit"])){
    $username =$_POST["username"];
    $password=$_POST["password"];
    $result= mysqli_query($conn, "SELECT * FROM users WHERE username = '$username'");
    $row = mysqli_fetch_assoc($result);
    if(mysqli_num_rows($result) > 0){
        if($password == $row["password"]){
            $_SESSION["login"]= true ;
            $_SESSION["id"]=$row["id"];
            header("location:mainmenu.html");
        }
        else{
            echo
            "<script>alert('wrong password');</script>";
        }
    }
    else{
        echo
        "<script>('user not registered');</script>";
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login</title>
</head>
<body>
    <p>Enter your login credentials</p>
    <br>
    <form action="" method="POST">
        Enter username
        <input name="username" placeholder="username">
        <br>
        Enter password
        <input name="password" placeholder="password">
        <br>
        <button name="submit"type="submit">Submit</button>
    </form>
</body>