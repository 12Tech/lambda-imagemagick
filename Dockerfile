FROM amazonlinux:2017.03.1.20170812
RUN yum -y install git python36 python36-pip zip && yum clean all
RUN python3 -m pip install --upgrade pip && python3 -m pip install boto3
RUN yum -y update && yum -y groupinstall "Development Tools" && yum clean all
RUN yum -y install libpng-devel libjpeg-devel libtiff-devel gcc make curl tar gzip ghostscript-devel && yum clean all

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
