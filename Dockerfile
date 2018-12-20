FROM ubuntu:16.04

RUN apt update && \
	apt -y install \
	wget \
	apt-transport-https \
	iputils-ping \
	net-tools

RUN wget -O - "https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc" | apt-key add - 

RUN	apt-key adv --keyserver "hkps.pool.sks-keyservers.net" --recv-keys "0x6B73A36E6026DFCA"

RUN	echo "deb https://dl.bintray.com/rabbitmq-erlang/debian xenial erlang\ndeb https://dl.bintray.com/rabbitmq/debian xenial main" | tee /etc/apt/sources.list.d/bintray.rabbitmq.list

RUN apt update && \
	apt -y install \
	erlang-nox \
	rabbitmq-server

# Copy the file to the rabbit folder for cluster config
COPY --chown=rabbitmq:rabbitmq .erlang.cookie /var/lib/rabbitmq/.erlang.cookie

# Ports: 
# 4369 used by rabbit nodes and cli tools
# 5672, 5671 default port of rabbit to listen
# 15672 used for api clients and management
# 25672, 35672 port for erlang and cli tools communication

EXPOSE 4369 5671 5672 25672 35672 35682

CMD ["rabbitmq-server"]