# The general / universal dockerfile!
ARG JAVA_VER=17
FROM azul/zulu-openjdk-alpine:$JAVA_VER as customjre

ARG JRE_SIZE=min
COPY create-jre.sh /create-jre.sh
RUN chmod +x /create-jre.sh \
    && ./create-jre.sh $JRE_SIZE fonts

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

# The required files and libs to support fonts:
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /etc/fonts /etc/fonts
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/share/fonts/OTF/overpass-regular.otf /usr/share/fonts/OTF/overpass-regular.otf
# Minimal libs for fonts
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libfontconfig.so.1 /usr/lib/libfontconfig.so.1
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libfontconfig.so.1.12.0 /usr/lib/libfontconfig.so.1.12.0
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/share/fontconfig /usr/share/fontconfig
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/share/xml/fontconfig/fonts.dtd /usr/share/xml/fontconfig/fonts.dtd
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /lib/libuuid.so.1 /lib/libuuid.so.1
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /lib/libuuid.so.1.3.0 /lib/libuuid.so.1.3.0
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/bin/xmlwf /usr/bin/xmlwf
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libexpat.so.1 /usr/lib/libexpat.so.1
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libexpat.so.1.8.7 /usr/lib/libexpat.so.1.8.7
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libfreetype.so.6 /usr/lib/libfreetype.so.6
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libfreetype.so.6.18.1 /usr/lib/libfreetype.so.6.18.1
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libpng16.so.16 /usr/lib/libpng16.so.16
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libpng16.so.16.37.0 /usr/lib/libpng16.so.16.37.0
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libbz2.so.1 /usr/lib/libbz2.so.1
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libbz2.so.1.0.8 /usr/lib/libbz2.so.1.0.8
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libbrotlicommon.so.1 /usr/lib/libbrotlicommon.so.1
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libbrotlicommon.so.1.0.9 /usr/lib/libbrotlicommon.so.1.0.9
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libbrotlidec.so.1 /usr/lib/libbrotlidec.so.1
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libbrotlidec.so.1.0.9 /usr/lib/libbrotlidec.so.1.0.9
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libbrotlienc.so.1 /usr/lib/libbrotlienc.so.1
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /usr/lib/libbrotlienc.so.1.0.9 /usr/lib/libbrotlienc.so.1.0.9

ENV PATH="/lib/runtime/bin:${PATH}" \
 SPRING_JMX_ENABLED=false \
 SPRING_CONFIG_LOCATION=classpath:/

# Create and set workdir
COPY --from=customjre --chown=$LIMITED_USER:$LIMITED_USER /app /app
WORKDIR /app

CMD ["java", "--version"]
