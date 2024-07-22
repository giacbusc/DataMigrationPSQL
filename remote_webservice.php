<?php
//attributi per la connessione al database remoto phpmyadmin
$host = "localhost";
$username = "root";
$password = "";
$database = "my_zanda5ie";

$conn = new mysqli($host, $username, $password, $database);

//verifica se la connessione è corretta
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

//select generica per restituire tutti i dati
$sql = "SELECT * FROM ".$_GET['tabella'];
$result = $conn->query($sql);

//creazione dell'array contenente tutti i dati 
$data = array();
if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $data[] = $row;
    }
}

$conn->close();

//restituizione dei dati in formato json
header('Content-Type: application/json');
echo json_encode($data);
?>
