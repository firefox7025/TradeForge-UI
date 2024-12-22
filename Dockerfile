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
FROM nginx:latest
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz
RUN gunzip elm.gz
RUN chmod +x elm
RUN mv elm /usr/local/bin/
RUN mkdir /build
ADD . /build
WORKDIR /build
RUN elm make src/Main.elm
RUN elm make src/Main.elm --optimize --output=elm.js
RUN cp index.html /usr/share/nginx/html/index.html
RUN cp elm.js /usr/share/nginx/html/elm.js
EXPOSE 80
EXPOSE 443