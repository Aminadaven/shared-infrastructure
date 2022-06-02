FROM aminadaven/scratch-jre:min-17

# Example of "exploded jar" which layers first the dependencies and resources and then the classes:
ARG LIMITED_USER=1000
COPY --chown=$LIMITED_USER:$LIMITED_USER "/build/dependencies" "/app/dependencies"
COPY --chown=$LIMITED_USER:$LIMITED_USER "/build/resources/main" "/app"
COPY --chown=$LIMITED_USER:$LIMITED_USER "/build/classes/java/main" "/app"

#    SPRING_CONFIG_LOCATION=classpath:/application.yml

# FIXME: Old syntax, remove when verify the new syntax works
# ENTRYPOINT ["java","-cp","/app:/app/dependencies/*", "yourPackage.YourApplication"]

# TODO: check which syntax works, since the base image have ENTRYPOINT ["java"]
ENTRYPOINT ["java","-cp","/app:/app/dependencies/*"]
# ENTRYPOINT ["-cp","/app:/app/dependencies/*"]
# with this way we should be able to send the image the main class name at runtime instead of buildtime, 
# so it is easier to have the same dockerfile in all projects
CMD ["yourPackage.YourApplication"]
