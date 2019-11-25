FROM alpine:3.10

RUN apk add --no-cache\
 g++\
 make\
 python3-dev

RUN wget -O - 'https://sourceforge.net/projects/omniorb/files/omniORB/omniORB-4.2.3/omniORB-4.2.3.tar.bz2'\
 | tar jxf -
WORKDIR /omniORB-4.2.3
RUN PYTHON=/usr/bin/python3 ./configure\
 --disable-thread-tracing\
 --prefix=/opt/omniorb
RUN make -j$(nproc)
RUN make install
WORKDIR /
# replace paths to install /usr/local
RUN find /opt/omniorb -type f\
 | xargs sed -i -e 's@/opt/omniorb@/usr/local@g'
RUN strip /opt/omniorb/lib/lib*so
