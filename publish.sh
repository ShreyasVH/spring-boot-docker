IMAGE_NAME="shreyasvh/spring-boot-docker"
VERSION=$(mvn -q -Dexec.executable=echo -Dexec.args='${project.version}' --non-recursive exec:exec | tr -d '\r' | tail -n 1 | xargs)
echo "IMAGE=[$IMAGE_NAME]"
echo "VERSION=[$VERSION]"
docker buildx create --use --name multiarch-builder 2>/dev/null || docker buildx use multiarch-builder
docker buildx inspect --bootstrap
docker login
docker buildx build --platform linux/amd64,linux/arm64 --build-arg VERSION="${VERSION}" -t "${IMAGE_NAME}:${VERSION}" -t "${IMAGE_NAME}:latest" --push .
