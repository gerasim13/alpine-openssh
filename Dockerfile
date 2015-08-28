FROM alpine
MAINTAINER Pavel Litvinenko <gerasim13@gmail.com>
RUN apk update && \
    apk upgrade && \
    apk add --update acf-openssh
COPY sshd_config /etc/ssh/sshd_config
RUN cd /etc/ssh && \
    ssh-keygen -f ./ssh_host_ecdsa_key -N '' -t ecdsa && \
    ssh-keygen -f ./ssh_host_dsa_key -N ''  -t dsa && \
    ssh-keygen -f ./ssh_host_ed25519_key -N '' -t ed25519 && \
    ssh-keygen -f ./ssh_host_rsa_key -N '' -t rsa
RUN adduser -D user -h /data/ && \
    echo user:password | chpasswd
VOLUME ["/data/"]
EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd"]
CMD ["-D"]
