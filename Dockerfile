FROM openjdk:17-jdk-slim AS builder

COPY . /app

WORKDIR /app

RUN ./gradlew clean build
    

EXPOSE 8080

CMD ["java", "-jar", "/app/demo-0.0.1-SNAPSHOT.jar"]