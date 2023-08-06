FROM openjdk:11

COPY build/libs/*.jar h2o-server.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/h2o-server.jar"]

