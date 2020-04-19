# docker-supertuxkart-server

SuperTuxKart server in Docker container (https://supertuxkart.net)



## Usage

Run it with parameters to create a WAN or LAN server as described in SuperTuxKart documentation.  Additionally add
parameter to docker to publish server port.  For example, to create a LAN server:

    $ docker run --rm --publish=2759:2759/udp --lan-server=docker_server

To specify your own server config use the -v parameter:

    $ docker run --rm --publish=2759:2759/udp -v <path to server_config.xml on host>:/home/stk/.config/supertuxkart/config-0.10/server_config.xml --server-config=/home/stk/.config/supertuxkart/config-0.10/server_config.xml
