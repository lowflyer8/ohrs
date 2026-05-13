<!DOCTYPE html>
<html>

<body>

<form method="POST">

    Name:
    <input type="text" name="user">

    <br><br>

    <input type="submit" value="Submit">

</form>

<?php

if($_SERVER["REQUEST_METHOD"] == "POST")
{
    $name = $_POST["user"];

    echo "<h3>Welcome $name</h3>";
}

?>

</body>
</html>