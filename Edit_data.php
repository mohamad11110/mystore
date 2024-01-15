<?php

	include 'connection.php';
	
	$id = $_POST['id'];
	$itemcode = $_POST['itemcode'];
	$itemname = $_POST['itemname'];
	$price = $_POST['price'];
	$stock= $_POST['stock'];
	
	$stmt = $connect->prepare("UPDATE tb_item SET item_code = ?, item_name = ?, price = ?, stock = ? WHERE id = ?");
	$stmt->bind_param("sssss", $itemcode, $itemname, $price, $stock, $id);
	$stmt->execute();
?>