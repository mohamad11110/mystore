<?php
	include 'connection.php';
	$id=$_POST['id'];
	$connect->query("DELETE FROM tb_item WHERE id=".$id);

?>