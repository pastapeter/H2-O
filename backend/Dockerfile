FROM openjdk:11
ARG MYSQL_DRIVER
ARG MYSQL_URL
ARG MYSQL_USERNAME
ARG MYSQL_PASSWORD

ENV MYSQL_DRIVER $MYSQL_DRIVER
ENV MYSQL_URL $MYSQL_URL
ENV MYSQL_USERNAME $MYSQL_USERNAME
ENV MYSQL_PASSWORD $MYSQL_PASSWORD

COPY build/libs/*.jar h2o-server.jar

EXPOSE 8080
ENTRYPOINT java "-Dspring.datasource.driver-class-name=$MYSQL_DRIVER" "-Dspring.datasource.url=$MYSQL_URL" "-Dspring.datasource.username=$MYSQL_USERNAME" "-Dspring.datasource.password=$MYSQL_PASSWORD" "-Dspring.redis.host=$REDIS_HOST" "-Dspring.redis.port=$REDIS_PORT" "-jar" "/h2o-server.jar"
