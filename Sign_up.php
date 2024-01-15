<?php
include 'connection.php';

$username = $_POST['username'];
$password = $_POST['password'];

$stmt = $connect->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
$stmt->execute([$username, $password]);

echo 'success';
?>