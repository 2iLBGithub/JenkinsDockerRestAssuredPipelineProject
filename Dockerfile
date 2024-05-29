FROM openjdk:17-slim

RUN apt-get update && apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

WORKDIR /app

COPY DockerExpressServer .

RUN npm install

COPY DockerRestAssuredServer .

RUN mvn package

EXPOSE 3000

CMD ["npm", "start"]
ENTRYPOINT ["sh", "-c", "if [ \"$1\" = 'tests' ]; then mvn test; else $@; fi"]