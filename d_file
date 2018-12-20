From ubuntu:16.04

#we run update
RUN apt update

#we install rabbitmq dependencies
RUN apt -y install wget apt-transport-https iputils-ping net-tools

RUN apt update

#we get the signed key
RUN wget -O - "https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc" | apt-key add -

#we get the repositories ppa for rabbit-erlang and rabbitmq
RUN echo "deb https://dl.bintray.com/rabbitmq-erlang/debian xenial erlang\ndeb https://dl.bintray.com/rabbitmq/debian xenial main" | tee /etc/apt/sources.list.d/bintray.rabbitmq.list




#we run update after downloading the ppas
RUN apt update

#we install erlang-nox
RUN apt install erlang-nox -y

#we install rabbitmq-server
RUN apt install rabbitmq-server -y

#we expose the needed ports for the nodes to work
EXPOSE 4369 5671 5672 25672

#we start the service
CMD ["rabbitmq-server"]
