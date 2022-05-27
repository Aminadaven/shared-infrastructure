ARG TEST_IMAGE=aminadaven/scratch-jre:min-17
FROM azul/zulu-openjdk-alpine:17 as builder

ARG TEST_FILE="FontTest"

COPY ClassLoader.java .
COPY "$TEST_FILE.java" .

RUN javac *.java

FROM ${TEST_IMAGE}

ARG TEST_FILE
ARG DEBUG=false
ENV RUN_CLASS=$TEST_FILE \
 SUN_JAVA2D_DEBUGFONTS=$DEBUG

COPY --from=builder *.class .

ENTRYPOINT ["java", "ClassLoader"]
