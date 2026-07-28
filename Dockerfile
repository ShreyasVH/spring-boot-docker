# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM maven:3.9.16-eclipse-temurin-26-alpine AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:26.0.1_8-jre-jammy

WORKDIR /app
COPY --from=build /app/target/*.jar /app/demo.jar

ENTRYPOINT ["java", "-jar", "/app/demo.jar"]