FROM node:10-alpine

RUN apk add ffmpeg git python3 build-base
RUN addgroup app
RUN adduser -S -G app app

WORKDIR /app
RUN chown app:app .

RUN mkdir /data
RUN chown app:app /data

USER app
RUN git clone https://github.com/asquared/aa-recorder .
RUN npm install

VOLUME ["/data"]
CMD ["bin/aa-recorder", "/data/config.json"]

