FROM ubuntu:14.04

# Install deps
RUN apt-get update && apt-get -y install libglib2.0-dev \
libdbus-1-dev libusb-dev libudev-dev libical-dev systemd libreadline-dev

# Download and build source
RUN cd /tmp && \
wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.47.tar.gz && \
tar xvf bluez-5.47.tar.gz && cd bluez-5.47 && \
 ./configure --enable-library && make && make install && \
cp -- attrib/gattool /usr/local/bin/.




CMD /usr/bin/firefox
