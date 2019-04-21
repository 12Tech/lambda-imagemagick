FROM amazonlinux
RUN yum -y update && yum -y groupinstall "Development Tools"
RUN yum -y install libpng-devel libjpeg-devel libtiff-devel gcc make curl tar gzip ghostscript-devel

WORKDIR /
RUN curl -O https://imagemagick.org/download/ImageMagick.tar.gz && \
    tar zxvf ImageMagick.tar.gz && \
    cd ./ImageMagick-* && \
    ./configure --prefix=/opt/ --enable-shared=no --enable-static=yes && \
    make && make install && \
    tar zcvf /tmp/imagemagick.tgz /opt/