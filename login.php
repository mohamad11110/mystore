<?php
include 'connection.php';

$username = $_POST['username'];
$password = $_POST['password'];

$stmt = $connect->prepare("SELECT * FROM users WHERE username = ? AND password = ?");
$stmt->execute([$username, $password]);
$user = $stmt->fetch();

if ($user) {
    echo 'success';
} else {
    echo 'failure';
}
?>