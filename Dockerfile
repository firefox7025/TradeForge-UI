FROM node:23-bookworm-slim AS builder
RUN apt-get update && apt-get install curl -y 
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz && \
    gunzip elm.gz && \
    chmod +x elm && \
    mv elm /usr/local/bin/ && \
    mkdir /build
ADD . /build
WORKDIR /build
RUN ls -la && elm make src/Main.elm --optimize --output=elm.js
RUN npm install uglify-js --global
RUN uglifyjs elm.js --compress "pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe" | uglifyjs --mangle --output elm.min.js

FROM nginx:1-alpine
COPY --from=builder /build/elm.min.js /usr/share/nginx/html/elm.min.js
COPY --from=builder /build/index.html /usr/share/nginx/html/index.html

EXPOSE 80
EXPOSE 443
