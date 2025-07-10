# Start with a base image containing Java runtime
FROM openjdk:17-jdk-slim

# Add a volume pointing to /tmp
VOLUME /tmp

# Copy the jar file
COPY target/spring-boot-jenkins-docker-1.0.0.jar app.jar

# Run the jar file
ENTRYPOINT ["java","-jar","/app.jar"]
