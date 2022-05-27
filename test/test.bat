docker build --build-arg TEST_IMAGE=jre --build-arg TEST_FILE=EnvTest -t test .
:: we can add  --build-arg DEBUG=true to debug fonts
docker run test -it

