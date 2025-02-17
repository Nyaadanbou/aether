<?php

/* Servers configuration */
$i = 0;

$i++;
$cfg['Servers'][$i]['host'] = 'mariadb'; /* 会解析为 "mariadb" 容器的 IP 地址 */
$cfg['Servers'][$i]['port'] = '3306';
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['AllowNoPassword'] = true;

/* End of servers configuration */

$cfg['blowfish_secret'] = sodium_hex2bin('b019da786155816ce59f45719e4d6fb1384194371b48fe3cd4ad251f62072dc3');
