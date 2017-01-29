# VMware vSphere CLI docker container
# Credits:
#  - http://nknu.net/vmware-cli-unattended-install-aka-auto-answering-yes/
#  - https://ausfestivus.wordpress.com/2016/01/07/install-vsphere-cli-on-ubuntu-14-04-lts/

FROM ubuntu:16.04

LABEL maintainer "somsakc@hotmail.com"
LABEL version="1.0"
LABEL description="VMware-vSphere-CLI-6.5.0-4566394"

RUN apt-get update
RUN apt-get install -y build-essential iputils-ping lib32z1 libclass-data-inheritable-perl libclass-methodmaker-perl libcrypt-openssl-rsa-perl libcrypt-ssleay-perl libcrypt-x509-perl libdata-dump-perl libdata-uuid-perl libdevel-stacktrace-perl libexception-class-perl libio-socket-inet6-perl libmodule-build-perl libmodule-install-perl libnet-inet6glue-perl libpath-class-perl libssl-dev libtry-tiny-perl liburi-perl libuuid-perl libxml-libxml-perl libxml-namespacesupport-perl libxml-sax-perl module-init-tools perl-doc uuid-dev
RUN apt-get install -y libsoap-lite-perl
RUN yes | perl -MCPAN -e 'install UUID'
RUN yes | perl -MCPAN -e 'install UUID::Random'

# You must download from https://code.vmware.com/tool/vsphere_cli/6.5
# then put into the same directory of Dockerfile
COPY VMware-vSphere-CLI-6.5.0-4566394.x86_64.tar.gz /root/vcli.tar.gz
RUN cd /root && tar xvf vcli.tar.gz
RUN ls -l /root /root/vmware-vsphere-cli-distrib
RUN yes | PAGER=cat /root/vmware-vsphere-cli-distrib/vmware-install.pl default

ENTRYPOINT ["/usr/bin/esxcli"]
