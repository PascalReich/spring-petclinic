# Two step build


# Build app w maven
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline

COPY src ./src
RUN mvn clean
RUN mvn package -DskipTests

# Run app w openjdk
FROM openjdk:27-ea-slim-bookworm
WORKDIR /app
COPY --from=builder /app/target/*.jar petclinic.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "petclinic.jar"]