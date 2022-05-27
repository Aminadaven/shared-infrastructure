FROM aminadaven/scratch-jre:min-17

# Example of Spring Boot layered application extracted from jar
ARG EXTRACTED=/build/extracted
ARG LIMITED_USER=1000
COPY --chown=$LIMITED_USER:$LIMITED_USER "${EXTRACTED}/dependencies" /app
COPY --chown=$LIMITED_USER:$LIMITED_USER "${EXTRACTED}/spring-boot-loader" /app
COPY --chown=$LIMITED_USER:$LIMITED_USER "${EXTRACTED}/snapshot-dependencies" /app
COPY --chown=$LIMITED_USER:$LIMITED_USER "${EXTRACTED}/application" /app

#    SPRING_CONFIG_LOCATION=classpath:/application.yml

ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
