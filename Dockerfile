FROM nginx:1.23.0

# Combine the RUN commands to reduce layers
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz && \
    gunzip elm.gz && \
    chmod +x elm && \
    mv elm /usr/local/bin/ && \
    mkdir /build

ADD . /build
WORKDIR /build
RUN apt get install npm -y && npm install uglify-js --global
RUN ls -la && \
    elm make src/Main.elm --optimize --output=elm.js && \
    cp index.html /usr/share/nginx/html/index.html && \
    uglifyjs elm.js --compress "pure_funcs=[F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9],pure_getters,keep_fargs=false,unsafe_comps,unsafe" | uglifyjs --mangle --output elm.min.js
    cp elm.js /usr/share/nginx/html/elm.js 

EXPOSE 80
EXPOSE 443
