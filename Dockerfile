#Docker file to install python3.8 alpine
FROM ubuntu
Maintainer Gaurav Pandey
ENV PYTHON3_VERSION 3.9.9
ENV PYTHON_PIP_VERSION 22.0.3
ENV DEBIAN_FRONTEND noninteractive
ENV GOLANG_VERSION 1.17.7
RUN apt-get -y update \
    && apt-get install -y apt-utils build-essential   \
    && apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev\
    && apt-get install -y wget git
#######################################################################################

#Installing python3 & Installing pip3 & Cleanups

RUN mkdir -p /usr/src/python \
    && cd /usr/src/python \
    && wget "https://www.python.org/ftp/python/${PYTHON3_VERSION%%[a-z]*}/Python-$PYTHON3_VERSION.tgz" \
    && tar -xvf Python-$PYTHON3_VERSION.tgz \
    && rm /usr/src/python/Python-$PYTHON3_VERSION.tgz \
    && cd Python-$PYTHON3_VERSION \
    && ./configure \
        --enable-shared \
        --enable-unicode=ucs4 \
    && make  \
    && make install \
    && ln -s /usr/local/lib/libpython3.8.so.1.0 /usr/lib/libpython3.8.so.1.0 \
    && ln -s /usr/local/bin/python3 /usr/local/bin/python \
    && wget -O /tmp/get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
    && python3 /tmp/get-pip.py "pip==$PYTHON_PIP_VERSION" \
    && apt-get -qy autoremove \
    && rm -rf /usr/src/python/

##################################   Installing golang  ###################################

RUN wget https://go.dev/dl/go$GOLANG_VERSION.linux-arm64.tar.gz \
    && tar -C /usr/local -xzf go$GOLANG_VERSION.linux-arm64.tar.gz \
    && rm  go$GOLANG_VERSION.linux-arm64.tar.gz 

ENV PATH $PATH:/usr/local/go/bin:/home/jovyan/go/bin/

#######################################################################################
##################################Installing Jupyter notebook
# Create joyyan  user with UID=1000 and in the 'users' group

ENV NB_USER jovyan
ENV NB_UID 1000
RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER \
    && python3 -m pip install jupyter  \
    && mkdir /home/$NB_USER/notebook  \
    && chown -R $NB_USER /home/$NB_USER/notebook \
    && chmod -R 755 /home/$NB_USER/notebook


##################################   Installing golang module for jupyter ###################################

# RUN env GO111MODULE=off go get -d -u github.com/gopherdata/gophernotes \
#     && cd "$(go env GOPATH)"/src/github.com/gopherdata/gophernotes \    
#     && env GO111MODULE=on go install \
#     && mkdir -p /usr/local/share/jupyter/kernels/gophernotes \
#     && cp kernel/* /usr/local/share/jupyter/kernels/gophernotes \
#     && cd /usr/local/share/jupyter/kernels/gophernotes \
#     && chmod +w ./kernel.json # in case copied kernel.json has no write permission \
#     && sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json \
#     && chmod -R 755 /root/go

# Switch back to jovyan to avoid accidental container runs as root

USER jovyan

RUN env GO111MODULE=off go get -d -u github.com/gopherdata/gophernotes \
    && cd "$(go env GOPATH)"/src/github.com/gopherdata/gophernotes \    
    && env GO111MODULE=on go install \
    && mkdir -p ~/.local/share/jupyter/kernels/gophernotes \
    && cp kernel/* ~/.local/share/jupyter/kernels/gophernotes \
    && cd ~/.local/share/jupyter/kernels/gophernotes \
    && chmod +w ./kernel.json # in case copied kernel.json has no write permission \
    && sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json \
    #&& chmod -R 755 /root/go




# Switch back to jovyan to avoid accidental container runs as root

USER jovyan
