FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

RUN apt update
RUN apt install -y software-properties-common \ 
        python3.7 \
        python3-pip \
        git \
        nano \
        openssh-server

RUN pip3 install tensorflow-gpu==1.14

RUN mkdir -p /var/run/sshd
RUN echo 'root:teste' | chpasswd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
COPY ./sshd_config /etc/ssh/

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]


# EXPOSE 5000