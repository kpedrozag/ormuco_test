FROM ubuntu:16.04

RUN apt update && \
	apt -y install wget apt-transport-https

# RUN apt -y install iputils-ping net-tools wget

RUN wget -O - \
	"https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc" | \
	apt-key add - && \
	apt-key adv \
	--keyserver "hkps.pool.sks-keyservers.net" \
	--recv-keys "0x6B73A36E6026DFCA" && \
	echo "deb https://dl.bintray.com/rabbitmq-erlang/debian xenial erlang\ndeb https://dl.bintray.com/rabbitmq/debian xenial main" | \
	tee /etc/apt/sources.list.d/bintray.rabbitmq.list

RUN apt update && apt -y install \
	erlang-nox \
	rabbitmq-server

# Ports: 
# 4369 used by rabbit nodes and cli tools
# 5672 default port of rabbit to listen
# 15672 used for api clients and management
# 25672, 35672 port for erlang and cli tools communication

EXPOSE 4369 5672 15672 25672 35672

COPY start_rabbit.sh start_rabbit.sh

CMD ["/bin/bash", "start_rabbit.sh"]