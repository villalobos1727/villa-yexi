<?php

header('Content-Type: text/html; charset=utf-8');

date_default_timezone_set('America/Sao_Paulo');

$page_title = $page_content = '';

$hostname = 'localhost';
$username = 'root';
$password = '';
$database = 'mulherestech';

$conn = new mysqli($hostname, $username, $password, $database);

$conn->query("SET NAMES 'utf8'");
$conn->query('SET character_set_connection=utf8');
$conn->query('SET character_set_client=utf8');
$conn->query('SET character_set_results=utf8');

$conn->query('SET GLOBAL lc_time_names = pt_BR');
$conn->query('SET lc_time_names = pt_BR');

function debug($variable, $exit = true, $dump = false)
{
    echo '<pre>';
    if ($dump) var_dump($variable);
    else print_r($variable);
    echo '</pre>';
    if ($exit) die();
};


function dt_convert($date, $format = 'Y-m-d H:i:s')
{
    $date = str_replace('/', '-', $date);
    $d = date_create($date);
    return date_format($d, $format);
}