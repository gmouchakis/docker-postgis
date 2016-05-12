 
FROM debian:jessie

MAINTAINER Yiannis Mouchakis <gmouchakis@gmail.com>

# Install packages.
RUN apt-get update && apt-get install -y \
	postgresql-9.4 \
	postgresql-server-dev-9.4 \
	postgresql-9.4-postgis \
  && apt-get clean  && rm -rf /var/lib/apt/lists/*

ADD initdb check_postgres_data /usr/local/bin/
RUN chmod -v +x /usr/local/bin/initdb
RUN chown -v postgres:postgres /usr/local/bin/initdb
RUN chmod -v +x /usr/local/bin/check_postgres_data

USER postgres

#start postgres, add postgis, create template for strabon and stop postgres
RUN initdb

USER root

#Keep data directory in a tmp directory. Upon docker run files will be moved to original data directory by check_postgres_data script. 
#This enables mounting a host directory to postgres data directory
RUN mv /var/lib/postgresql/9.4/main /var/lib/postgresql/9.4/main_tmp

#postgres port
EXPOSE 5432

CMD check_postgres_data && su - postgres -c "/usr/lib/postgresql/9.4/bin/postgres -D /var/lib/postgresql/9.4/main -c config_file=/etc/postgresql/9.4/main/postgresql.conf"
