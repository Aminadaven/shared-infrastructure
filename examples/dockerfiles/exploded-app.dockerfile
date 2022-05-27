FROM aminadaven/scratch-jre:min-17

# Example of "exploded jar" which layers first the dependencies and resources and then the classes:
ARG LIMITED_USER=1000
COPY --chown=$LIMITED_USER:$LIMITED_USER "/build/dependencies" "/app/dependencies"
COPY --chown=$LIMITED_USER:$LIMITED_USER "/build/resources/main" "/app"
COPY --chown=$LIMITED_USER:$LIMITED_USER "/build/classes/java/main" "/app"

#    SPRING_CONFIG_LOCATION=classpath:/application.yml

ENTRYPOINT ["java","-cp","/app:/app/dependencies/*", "yourPackage.YourApplication"]
