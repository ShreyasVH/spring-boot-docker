FROM openjdk
WORKDIR /app/
COPY . .
ENTRYPOINT ["sh", "./start.sh"]