<?php
include_once '/var/www/db_config.php';

$is_db_init = false;
while (!$is_db_init) {
  sleep(1);

  try {
    $host = HOST;
    $db = DB;

    $pdo = new PDO("mysql:host={$host}", USER, PASSWORD);

    $query = "CREATE DATABASE IF NOT EXISTS `{$db}` CHARACTER SET utf8mb4;";
    $pdo->exec($query) or die(print_r($pdo->errorInfo(), true));

    $query = "USE `{$db}`;";
    $pdo->query($query) or die(print_r($pdo->errorInfo(), true));

    $query = "CREATE TABLE IF NOT EXISTS `board` ( `idx` INT NOT NULL AUTO_INCREMENT , `name` VARCHAR(100) NOT NULL , `pw` VARCHAR(100) NOT NULL , `title` VARCHAR(100) NOT NULL , `content` TEXT NOT NULL , `date` DATE NOT NULL , `hit` INT NOT NULL , PRIMARY KEY (`idx`));";
    $pdo->query($query) or die(print_r($pdo->errorInfo(), true));

    $query = "SHOW TABLES;";
    $result = $pdo->query($query);

    var_dump($result);

    while ($result->fetch()) {
      $is_db_init = true;
    }
  } catch (Exception $e) {
    print "DB ERROR: " . $e->getMessage();
  }
}
