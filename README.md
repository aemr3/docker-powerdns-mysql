docker-powerdns-mysql
=====================

PowerDNS with mysql backend

Running powerdns server with mysql backend
------------------------------------------

docker run --name powerdns --link mysql:mysql -p 53:53 -p 53:53/udp -d ennweb/powerdns-mysql

The following environment variables are available:

* -e MYSQL_HOST=... (defaults to the IP and port of the linked mysql container)
* -e MYSQL_USER=... (defaults to "root")
* -e MYSQL_PASS=... (defaults to the value of the MYSQL_ROOT_PASSWORD environment variable from the linked mysql container)
* -e MYSQL_DB=... (defaults to "powerdns")
