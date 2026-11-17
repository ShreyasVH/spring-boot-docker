# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM maven:3.10.0-eclipse-temurin-27-alpine AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:27-jre-alpine

WORKDIR /app
COPY --from=build /app/target/*.jar /app/demo.jar

ENTRYPOINT ["java", "-jar", "/app/demo.jar"]