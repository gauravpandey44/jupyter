#Docker file to install python3.8 debian based system
FROM debian

RUN apt-get -y update \
	&& apt-get install -y build-essential  \
	&& apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev \
	&& apt-get install -y wget

ENV PYTHON3_VERSION 3.8.2

ENV PYTHON_PIP_VERSION 20.1

#######################################################################################

#Installing python3
RUN mkdir -p /usr/src/python
RUN cd /usr/src/python \
&& wget "https://www.python.org/ftp/python/${PYTHON3_VERSION%%[a-z]*}/Python-$PYTHON3_VERSION.tgz" \
&& tar -xvf Python-$PYTHON3_VERSION.tgz \
&& rm /usr/src/python/Python-$PYTHON3_VERSION.tgz \
&& cd Python-$PYTHON3_VERSION \
&& ./configure \
		--enable-shared \
		--enable-unicode=ucs4 \
&& make  \
&& make install 

#RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/libpython3.8.so.1.0
RUN ln -s /usr/local/lib/libpython3.8.so.1.0 /usr/lib/libpython3.8.so.1.0 \
	&& python3 -V \
	&& rm -rf /usr/src/python/
RUN rm -rf /usr/src/python/

#######################################################################################

#Installing pip3



Run wget -O /tmp/get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
	&& python3 /tmp/get-pip.py "pip==$PYTHON_PIP_VERSION" \
	&& pip -V



#######################################################################################

#configuring default python3

Run ln -s /usr/local/bin/python3 /usr/local/bin/python



#######################################################################################

#Cleanups

RUN apt-get -qy autoremove

#######################################################################################

#Installing Jupyter notebook



# Create joyyan  user with UID=1000 and in the 'users' group

ENV NB_USER jovyan

ENV NB_UID 1000



RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER 



RUN python3 -m pip install jupyter && \
    mkdir /home/$NB_USER/notebook && \
    chown -R $NB_USER /home/$NB_USER/notebook && \
    chmod -R 755 /home/$NB_USER/notebook


#######################################################################################

#Starting up Jupyter Notebook 

#RUN nohup jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/opt/notebook --allow-root >/dev/null 2>&1 &



#######################################################################################



#Installing ps command in docker

USER root

RUN apt-get -y install procps

# Switch back to jovyan to avoid accidental container runs as root

USER jovyan

