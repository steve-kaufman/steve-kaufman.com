FROM node:alpine as builder

WORKDIR /app

COPY package.json .

RUN npm i

COPY pug pug
COPY sass sass
COPY public public

RUN npm run build


FROM stevekaufman/static-server

WORKDIR /static

COPY --from=builder /app/public .

ENV STATIC_DIR=/static

CMD [ "serve" ]