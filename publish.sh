VERSION=mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec
docker build --build-arg VERSION=${VERSION} -t spring-boot-docker .
docker tag spring-boot-docker shreyasvh/spring-boot-docker:${VERSION}
docker tag spring-boot-docker shreyasvh/spring-boot-docker:latest
docker login
docker push shreyasvh/spring-boot-docker:${VERSION}
docker push shreyasvh/spring-boot-docker:latest
