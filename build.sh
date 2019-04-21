docker build . -t 12tech/imagemagick:amazonlinux-latest
docker run -it --rm -v ${PWD}/imagemagick:/tmp 12tech/imagemagick:amazonlinux-latest "cp /opt/imagemagick /tmp"