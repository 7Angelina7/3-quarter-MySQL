/* 1) Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, 
который указывался при установке.
*/

[mysql]
user=root
password=

/* 2) Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, 
числового id и строкового name.
*/
C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql
mysql> CREATE DATABASE example;
Query OK, 1 row affected (0.01 sec)

mysql> CREATE DATABASE sample;
Query OK, 1 row affected (0.01 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| example            |
| gb                 |
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sample             |
| sys                |
| world              |
+--------------------+
9 rows in set (0.05 sec)
mysql> SHOW VARIABLES LIKE 'datadir';
+---------------+---------------------------------------------+
| Variable_name | Value                                       |
+---------------+---------------------------------------------+
| datadir       | C:\ProgramData\MySQL\MySQL Server 8.0\Data\ |
+---------------+---------------------------------------------+
1 row in set, 1 warning (0.01 sec)
mysql> use example;
Database changed
mysql> CREATE TABLE users (id int(8), name varchar(255));
Query OK, 0 rows affected, 1 warning (0.03 sec)

mysql> SHOW TABLES;
+-------------------+
| Tables_in_example |
+-------------------+
| users             |
+-------------------+
1 row in set (0.00 sec)
mysql> DESCRIBE users;
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| id    | int          | YES  |     | NULL    |       |
| name  | varchar(255) | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

/* 3) Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
*/

C:\Windows\system32>cd C:\Program Files\MySQL\MySQL Server 8.0\bin

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u root -p example > example.sql
Enter password: ******
C:\Program Files\MySQL\MySQL Server 8.0\bin>dir
 Том в устройстве C не имеет метки.
 Серийный номер тома: 5463-112B

 Содержимое папки C:\Program Files\MySQL\MySQL Server 8.0\bin

14.04.2023  15:47    <DIR>          .
14.04.2023  15:47    <DIR>          ..
19.08.2022  12:40            15 872 comerr64.dll
14.04.2023  15:47             1 869 example.sql
16.12.2022  16:42           233 472 fido2.dll
16.12.2022  16:42            54 418 fido2.lib
19.08.2022  12:40           390 144 gssapi64.dll
16.12.2022  16:43           793 088 harness-library.dll
16.12.2022  09:21         6 422 120 ibd2sdi.exe
16.12.2022  09:21         6 411 376 innochecksum.exe
08.12.2021  12:30           269 312 jemalloc.dll
19.08.2022  12:40            64 000 k5sprt64.dll
19.08.2022  12:40         1 223 168 krb5_64.dll
19.08.2022  12:40           112 128 krbcc64.dll
30.11.2022  16:03         3 438 592 libcrypto-1_1-x64.dll
19.11.2021  20:03         1 839 616 libmecab.dll
16.12.2022  16:23         6 141 440 libprotobuf-debug.dll
16.12.2022  16:22         1 390 080 libprotobuf-lite-debug.dll
16.12.2022  16:41           598 528 libprotobuf-lite.dll
16.12.2022  16:41           943 314 libprotobuf-lite.lib
16.12.2022  16:42         2 844 672 libprotobuf.dll
16.12.2022  16:42         3 976 168 libprotobuf.lib
23.11.2022  22:15           110 592 libsasl.dll
30.11.2022  16:03           690 176 libssl-1_1-x64.dll
16.12.2022  09:21         6 353 016 lz4_decompress.exe
16.12.2022  09:22         6 661 232 myisamchk.exe
16.12.2022  09:22         6 504 560 myisamlog.exe
16.12.2022  09:22         6 566 000 myisampack.exe
16.12.2022  09:22         6 544 504 myisam_ftdump.exe
16.12.2022  09:22         7 324 776 mysql.exe
16.12.2022  09:22         7 212 144 mysqladmin.exe
16.12.2022  09:22         7 565 936 mysqlbinlog.exe
16.12.2022  09:22         7 219 312 mysqlcheck.exe
16.12.2022  09:22        54 815 848 mysqld.exe
16.12.2022  09:22         7 284 848 mysqldump.exe
16.12.2022  16:21             7 881 mysqldumpslow.pl
16.12.2022  16:21            28 776 mysqld_multi.pl
16.12.2022  09:22            42 112 mysqlharness_stdx.dll
16.12.2022  09:22            66 680 mysqlharness_tls.dll
16.12.2022  09:22         7 203 952 mysqlimport.exe
16.12.2022  09:22         7 719 536 mysqlpump.exe
16.12.2022  09:22         7 732 848 mysqlrouter.exe
16.12.2022  09:22            69 776 mysqlrouter_connection_pool.dll
16.12.2022  09:22            97 944 mysqlrouter_destination_status.dll
16.12.2022  09:22           271 992 mysqlrouter_http.dll
16.12.2022  09:22           115 352 mysqlrouter_http_auth_backend.dll
16.12.2022  09:22            38 544 mysqlrouter_http_auth_realm.dll
16.12.2022  09:22         6 273 672 mysqlrouter_io_component.dll
16.12.2022  09:22         6 313 088 mysqlrouter_keyring.exe
16.12.2022  09:22         7 501 944 mysqlrouter_lib.dll
16.12.2022  09:23         8 063 120 mysqlrouter_metadata_cache.dll
16.12.2022  09:23         6 284 928 mysqlrouter_passwd.exe
16.12.2022  09:23         6 269 064 mysqlrouter_plugin_info.exe
16.12.2022  09:23         7 260 800 mysqlrouter_routing.dll
16.12.2022  09:23         7 201 904 mysqlshow.exe
16.12.2022  09:23         7 221 360 mysqlslap.exe
16.12.2022  09:23         6 300 800 mysql_config_editor.exe
16.12.2022  09:23         7 294 088 mysql_migrate_keyring.exe
16.12.2022  09:23         7 199 376 mysql_secure_installation.exe
16.12.2022  09:23         6 325 888 mysql_ssl_rsa_setup.exe
16.12.2022  09:23         6 233 728 mysql_tzinfo_to_sql.exe
16.12.2022  09:23         7 298 168 mysql_upgrade.exe
16.12.2022  09:23         6 286 464 my_print_defaults.exe
16.12.2022  09:23         7 163 496 perror.exe
23.11.2022  22:15            47 104 saslSCRAM.dll
19.08.2022  12:40            48 128 xpprof64.dll
16.12.2022  09:24         6 253 176 zlib_decompress.exe
              65 файлов    308 252 010 байт
               2 папок  255 706 832 896 байт свободно
C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p sample < example.sql
Enter password: ******

C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p
Enter password: ******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 28
Server version: 8.0.32 MySQL Community Server - GPL

Copyright (c) 2000, 2023, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
mysql> USE sample;
Database changed
mysql> SHOW TABLES;
+------------------+
| Tables_in_sample |
+------------------+
| users            |
+------------------+
1 row in set (0.00 sec)
mysql> DESCRIBE sample.users;
+-------+--------------+------+-----+---------+-------+
| Field | Type         | Null | Key | Default | Extra |
+-------+--------------+------+-----+---------+-------+
| id    | int          | YES  |     | NULL    |       |
| name  | varchar(255) | YES  |     | NULL    |       |
+-------+--------------+------+-----+---------+-------+
2 rows in set (0.01 sec)
