# syntax=docker/dockerfile:1

FROM --platform=$BUILDPLATFORM maven:3.9.11-eclipse-temurin-25 AS build
WORKDIR /app

COPY pom.xml .
RUN mvn -q -DskipTests dependency:go-offline

COPY src ./src
RUN mvn clean package -DskipTests

FROM eclipse-temurin:25.0.2_10-jre-jammy

WORKDIR /app
COPY --from=build /app/target/*.jar /app/demo.jar

ENTRYPOINT ["java", "-jar", "/app/demo.jar"]