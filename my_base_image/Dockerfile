FROM ubuntu:latest

ENV TZ=Asia/Tokyo DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ffmpeg \
    git \
    imagemagick \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libglib2.0-0 \
    openssh-server \
    sudo \
    supervisor \
    wget \
    vim


## customized bellow

ARG USER_ID
ARG USER_NAME

COPY supervisord.conf /tmp/
RUN cat /tmp/supervisord.conf | sed s/USERNAME/$USER_NAME/g > /etc/supervisor/conf.d/supervisord.conf && \
    rm /tmp/supervisord.conf && \
    sed -i 's/#X11UseLocalhost yes/X11UseLocalhost no/' /etc/ssh/sshd_config && \
    mkdir -p /var/run/sshd /var/log/supervisor /work && \
    useradd -m -u $USER_ID -s /bin/bash $USER_NAME

#install anaconda3 ${USER_NAME} locally

WORKDIR /opt

# download anaconda package and install anaconda
# archive -> https://repo.continuum.io/archive/

#RUN wget https://repo.continuum.io/archive/Anaconda3-2020.07-Linux-x86_64.sh && \
#    su $USER_NAME -c "sh /opt/Anaconda3-2020.07-Linux-x86_64.sh -b -p /home/$USER_NAME/anaconda3" && \
#    rm -f Anaconda3-2020.07-Linux-x86_64.sh

# set path
ENV PATH /home/$USER_NAME/anaconda3/bin:$PATH

WORKDIR /home/$USER_NAME

USER ${USER_NAME}

RUN wget https://repo.continuum.io/archive/Anaconda3-2020.07-Linux-x86_64.sh && \
    sh ./Anaconda3-2020.07-Linux-x86_64.sh -b -p /home/$USER_NAME/anaconda3 && \
    rm -f ./Anaconda3-2020.07-Linux-x86_64.sh && \
    echo "export PATH=/home/$USER_NAME/anaconda3/bin:${PATH}" >> /home/$USER_NAME/.bashrc && \
    conda update -n base -c defaults conda -y && \
    conda install flake8 lightgbm -y && \
    conda install nodejs -y && \
    conda install jupytext -c conda-forge -y && \
    jupyter lab build && \
    pip install --upgrade pip && \
    pip install opencv-python && \
    pip install nibabel \
    pip install japanize-matplotlib


WORKDIR /

USER root

EXPOSE 22
CMD ["/usr/bin/supervisord"]
