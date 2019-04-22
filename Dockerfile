FROM amazonlinux
RUN yum -y update && yum -y groupinstall "Development Tools"
RUN yum -y install libpng-devel libjpeg-devel libtiff-devel gcc make curl tar gzip ghostscript-devel

WORKDIR /
RUN curl -O https://imagemagick.org/download/ImageMagick.tar.gz && \
    tar zxvf ImageMagick.tar.gz && \
    cd ./ImageMagick-* && \
    ./configure --prefix=/opt/ --enable-shared=no --enable-static=yes && \
    make && make install && \
    mkdir -p /dist && \
    strip -s /opt/bin/magick /opt/lib/libMagick*.a && \
    zip --symlinks -9 -r /imagemagick.zip /opt

ENTRYPOINT [ "cp", "/imagemagick.zip",  "/dist" ]
