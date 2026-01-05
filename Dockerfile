FROM maven AS build
WORKDIR /app/
COPY . .
RUN mvn clean compile -DskipTests=true package

# ----------------------------------------------------------------

FROM eclipse-temurin:11.0.19_7-jdk-jammy

WORKDIR /app/
ARG NAME=demo
ARG VERSION=0.0.1-SNAPSHOT

COPY --from=build /app/target/${NAME}-${VERSION}.jar /app/demo.jar

ENTRYPOINT ["java", "-jar", "/app/demo.jar"]