<?php
include_once './db_config.php';

$dsn = 'mysql:host='.HOST.';dbname='.DB.';port='.PORT.';charset='.CHARSET;

try {
	$pdo = new PDO($dsn, USER, PASSWORD);

} catch (PDOException $e) {
	print 'CONNECT FAILED: ' . $e->getMessage();
	return false;

}
