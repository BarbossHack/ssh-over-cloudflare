FROM alpine

RUN apk update && \
    apk add --no-cache openssh

RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
RUN echo 'IgnoreUserKnownHosts yes' >> /etc/ssh/sshd_config
RUN echo 'root:toor' | chpasswd
RUN /usr/bin/ssh-keygen -A

RUN dd if=/dev/random of=/root/10M.file bs=1M count=10

ENTRYPOINT ["/usr/sbin/sshd", "-D"]
