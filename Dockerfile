FROM eclipse-temurin:17-jdk-jammy as config-server-builder
WORKDIR /opt/app
COPY .mvn/ .mvn
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY ./src ./src
RUN ./mvnw clean install -DskipTests


FROM eclipse-temurin:17-jre-jammy
WORKDIR /opt/app
EXPOSE 8888
COPY --from=config-server-builder /opt/app/target/*.jar /opt/app/config-server.jar
ENTRYPOINT ["java", "-jar", "/opt/app/config-server.jar" ]