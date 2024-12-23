FROM nginx:1.23.0

# Combine the RUN commands to reduce layers
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz && \
    gunzip elm.gz && \
    chmod +x elm && \
    mv elm /usr/local/bin/ && \
    mkdir /build

ADD . /build
WORKDIR /build

RUN ls -la && \
    elm make src/Main.elm --optimize --output=elm.js && \
    cp index.html /usr/share/nginx/html/index.html && \
    cp elm.js /usr/share/nginx/html/elm.js

EXPOSE 80
EXPOSE 443
