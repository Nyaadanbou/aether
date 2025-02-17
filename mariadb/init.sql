-- 创建专门给插件使用的数据库用户
CREATE USER IF NOT EXISTS 'minecraft'@'%' IDENTIFIED BY '';
GRANT ALL PRIVILEGES ON *.* TO 'minecraft'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

-- 创建 phpMyAdmin 需要的数据库
CREATE DATABASE IF NOT EXISTS phpmyadmin;
