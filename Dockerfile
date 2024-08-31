FROM maven:3.8.6-openjdk-11 AS build

# Create a non-root user and group
RUN addgroup --system maven && adduser --system --ingroup maven maven

# Set the working directory 
WORKDIR /app

# Create a directory for Maven configuration and set ownwer ship 
RUN mkdir -p /app/.m2 && chown -R maven:maven /app

# Switch to the non-root user
USER maven

#copy the Maven project
COPY --chown=maven:maven . .

# Build the project
RUN mvn clean package

# Stage 2: Run the application using OpenJDK
FROM openjdk:11-jre-slim

# Create a non-root user and group for the runtime container
RUN addgroup --system maven && adduser --system --ingroup maven maven

# Set the working directory and change ownership to the non-root user
WORKDIR /app
RUN chown -R maven:maven /app

# Switch to the non-root user
USER maven

# Copy the JAR file from the build stage
COPY --from=build /app/target/hello-world-1.0-SNAPSHOT.jar /app/hello-world.jar

# Set the entry point to run the application
ENTRYPOINT ["java", "-jar", "/app/hello-world.jar"]

