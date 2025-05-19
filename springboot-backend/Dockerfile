#get the jdk docker image
FROM openjdk:17-jdk-slim
#name of the directory of the application in the container
WORKDIR /app
#points to the location of the jar file
ARG JAR_FILE=target/*.jar
#copies from local directory to containers /app directory
COPY ${JAR_FILE} app.jar
#informs docker to listen on port 8080
EXPOSE 8080
#commands to run the server when container starts
ENTRYPOINT [ "java", "-jar", "app.jar" ]

#metadata
LABEL maintainer="rishichirchi@example.com"
LABEL version="1.0"
LABEL description="Spring Boot application containerized with Docker"
