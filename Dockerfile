FROM amazonlinux:2017.03.1.20170812
RUN yum -y install git python36 python36-pip zip && yum clean all
RUN python3 -m pip install --upgrade pip && python3 -m pip install boto3
RUN yum -y update && yum -y groupinstall "Development Tools" && yum clean all
RUN yum install yum-plugin-downloadonly
RUN yum -y install bzip2-devel freetype-devel libjpeg-devel \
                libpng-devel libtiff-devel giflib-devel zlib-devel \
                ghostscript-devel djvulibre-devel libwmf-devel \
                jasper-devel libtool-ltdl-devel libX11-devel \
                libXext-devel libXt-devel lcms-devel \
                libxml2-devel librsvg2-devel OpenEXR-devel wget && yum clean all

WORKDIR /
RUN wget ftp://ftp.graphicsmagick.org/pub/GraphicsMagick/delegates/libpng-1.5.28.tar.gz && \
    tar xvzf libpng-1.5.28.tar.gz && \
    cd libpng-1.5.28 && \
    ./configure --prefix=/opt && make && make install

RUN curl -O https://imagemagick.org/download/ImageMagick.tar.gz && \
    tar zxvf ImageMagick.tar.gz && \
    cd ./ImageMagick-* && \
    ./configure --prefix=/opt/ --enable-shared=no --enable-static=yes --disable-installed && \
    make && make install && mkdir -p /dist && \
    strip -s /opt/bin/magick /opt/lib/*.a && \
    rm -rf /opt/share /opt/include /opt/etc && \
    cd /opt && zip -9 -q -x *.git* --symlinks -r /imagemagick.zip bin lib

ENTRYPOINT [ "cp", "/imagemagick.zip",  "/dist" ]
