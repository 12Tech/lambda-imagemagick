docker build . -t 12tech/imagemagick:latest
docker run -it --rm -v ${PWD}/imagemagick:/dist 12tech/imagemagick:latest