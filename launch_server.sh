#/bin/sh

cd build/web

python3 -m http.server 9090 >/dev/null 2>&1 & # sends the program to the background
