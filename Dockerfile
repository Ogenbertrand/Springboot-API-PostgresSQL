FROM openjdk:17-jdk-slim AS builder
WORKDIR /app

COPY build.gradle gradlew settings.gradle ./
COPY gradle/ gradle/
COPY src/ src/

RUN chmod +x gradlew \
    && ./gradlew clean build -x test

FROM openjdk:17-jdk-slim
WORKDIR /app

COPY --from=builder /app/build/libs/*.jar /app/

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/demo-0.0.1-SNAPSHOT.jar"]