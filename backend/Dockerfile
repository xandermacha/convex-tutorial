FROM ghcr.io/get-convex/convex-backend:6efab6f2b6c182b90255774d747328cfc7b80dd9
WORKDIR /convex

RUN npm install -g bun
COPY package.json bun.lock ./
RUN bun install

COPY self-hosted/run.sh .
COPY convex convex

ENTRYPOINT ["/bin/bash", "./run.sh"]

VOLUME /convex/data
VOLUME /convex/convex

EXPOSE 3210
EXPOSE 3211