# compilation
FROM eclipse-temurin:17-jdk-alpine AS builder


RUN apk add --no-cache maven

WORKDIR /app
COPY pom.xml .
COPY src ./src


RUN mvn clean package -DskipTests

FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app
COPY --from=builder /app/target/cloud-gateway-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8082

ENTRYPOINT ["java", "-jar", "app.jar"]