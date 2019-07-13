#######################################################################################
#                                                                              
# Copyright 2019 Nick Miller.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this 
# file except in compliance with the License.
#
# You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under 
# the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF 
# ANY KIND, either express or implied. See the License for the specific language 
# governing permissions and limitations under the License.
#
# Based on a fork of fauria/docker-vsftpd by Fer Uría (https://github.com/fauria/
# docker-vsftpd) released under the Apache License, Version 2.0.
#
#######################################################################################

# Source image
FROM alpine:latest

# Upgrade packages
RUN apk --no-cache upgrade

# Install required packages
RUN apk --no-cache add bash vsftpd db

# Configure defaults for environment variables
ENV FTP_USER **String**
ENV FTP_PASS **Random**
ENV PASV_ADDRESS **IPv4**
ENV PASV_ADDR_RESOLVE NO
ENV PASV_ENABLE YES
ENV PASV_MIN_PORT 21100
ENV PASV_MAX_PORT 21110
ENV XFERLOG_STD_FORMAT NO
ENV LOG_STDOUT **Boolean**
ENV FILE_OPEN_MODE 0666
ENV LOCAL_UMASK 077

# Copy files into place
COPY ./etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./etc/pam.d/vsftpd_virtual /etc/pam.d/vsftpd_virtual
COPY ./usr/sbin/run-vsftpd.sh /usr/sbin/run-vsftpd.sh

# Configure volumes
VOLUME /home/vsftpd
VOLUME /var/log/vsftpd

# Expose ports 20 and 21
EXPOSE 20 21

# The command to run on launch
CMD ["/usr/sbin/run-vsftpd.sh"]
