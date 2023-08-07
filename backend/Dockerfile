FROM openjdk:11

COPY build/libs/*.jar h2o-server.jar

EXPOSE 8080
ENTRYPOINT ["java", "-Dspring.datasource.driver-class-name=${MYSQL_DRIVER}", "-Dspring.datasource.url=${MYSQL_URL}", "-Dspring.datasource.username=${MYSQL_USERNAME}", "-Dspring.datasource.password=${MYSQL_PASSWORD}", "-jar", "/h2o-server.jar"]

