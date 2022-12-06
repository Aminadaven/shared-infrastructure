# The general / universal dockerfile!
ARG JAVA_VER=17
FROM azul/zulu-openjdk-alpine:$JAVA_VER as customjre

ARG JRE_SIZE=min
COPY create-jre.sh /create-jre.sh
RUN chmod +x /create-jre.sh \
    && ./create-jre.sh $JRE_SIZE

FROM scratch
# Lower the privilages to non-root user
COPY --from=customjre /etc/passwd /etc/passwd
ARG LIMITED_USER=1000
USER $LIMITED_USER

# These are the 2 needed libs to run the JRE:
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /lib/libz.so.1 /lib/libz.so.1
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /lib/ld-musl-x86_64.so.1 /lib/ld-musl-x86_64.so.1
# This is the custom JRE:
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /lib/runtime /lib/runtime
# This is required for Spring Boot applications to work properly:
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /tmp /tmp

ENV PATH="/lib/runtime/bin:${PATH}" \
 SPRING_JMX_ENABLED=false \
 SPRING_CONFIG_LOCATION=classpath:/

# Create and set workdir
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /app /app
WORKDIR /app

ENTRYPOINT ["java"]
CMD ["--version"]
