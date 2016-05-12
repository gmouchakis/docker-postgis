# docker-postgis

This is the docker container for postgis.

To build docker-postgis go into the docker-postgis directory and run

    docker build -t postgis .

To run it 

    docker run --name postgis -p 5432:5432 postgis

To keep data in a host directory run it as 

    docker run --name postgis -p 5432:5432 -v /path/to/data:/var/lib/postgresql/9.4/main postgis
