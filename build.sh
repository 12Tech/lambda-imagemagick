docker build . -t 12tech/imagemagick:amazonlinux-latest
docker run -it --rm -v ${PWD}/imagemagick:/tmp 12tech/imagemagick:amazonlinux-latest "cp /imagemagick.zip /tmp"