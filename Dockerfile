# Install wget and maven
# Extract to temporary directory, copy to the desired image
FROM ubuntu:18.04 AS deps

RUN apt-get update \
    && apt-get -y install maven \
    && apt-get -y install wget \
    && apt-get -y install unzip \
    && rm -rf /var/cache/apt/*

WORKDIR /tmp

# Install SFDC Dependencies and Prepare Runtime Environment
RUN wget --no-check-certificate --content-disposition https://github.com/forcedotcom/EMP-Connector/archive/master.zip \
	&& mkdir EMP-Connector \
	&& unzip EMP-Connector-master.zip

RUN cd EMP-Connector-master \
    && mvn clean install

# Prepare project directory
RUN cd /tmp && mkdir Producer

# Build the project
WORKDIR /tmp/Producer
COPY . /tmp/Producer
RUN mvn clean package

# Runtime Container Image.
FROM openjdk:8-jdk-alpine AS build
COPY --from=deps /tmp/Producer/target /bin/project

WORKDIR /bin/project

ENTRYPOINT ["java","-jar","/bin/project/sfdc-streaming-1.1.jar"]
