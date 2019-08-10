#Docker file to install python2.7 & python3.7 both in debian based system


FROM debian
RUN apt-get -y update \
	&& apt-get install -y build-essential  \
	&& apt-get install -y libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev \
	&& apt-get install -y wget
ENV PYTHON2_VERSION 2.7.16
ENV PYTHON3_VERSION 3.7.4
ENV PYTHON_PIP_VERSION 19.2.1

######################################################################################
#Installing python2

RUN mkdir -p /usr/src/python \
&& cd /usr/src/python \
&& wget "https://www.python.org/ftp/python/${PYTHON2_VERSION%%[a-z]*}/Python-$PYTHON2_VERSION.tgz" \
&& tar -xvf Python-$PYTHON2_VERSION.tgz \
&& rm /usr/src/python/Python-$PYTHON2_VERSION.tgz \
&& cd Python-$PYTHON2_VERSION \
&& ./configure \
		--enable-shared \
		--enable-unicode=ucs4 \
&& make -j$(getconf _NPROCESSORS_ONLN) \
&& make install 

RUN ln -s /usr/local/lib/libpython2.7.so.1.0 /usr/lib/libpython2.7.so.1.0 \
	&& python -V \
	&& rm -rf /usr/src/python/Python-$PYTHON2_VERSION

	
#######################################################################################
#Installing pip2

Run wget -O /tmp/get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
	&& python2 /tmp/get-pip.py "pip==$PYTHON_PIP_VERSION" \
	&& pip -V

#######################################################################################
#Installing python3

RUN cd /usr/src/python \
&& wget "https://www.python.org/ftp/python/${PYTHON3_VERSION%%[a-z]*}/Python-$PYTHON3_VERSION.tgz" \
&& tar -xvf Python-$PYTHON3_VERSION.tgz \
&& rm /usr/src/python/Python-$PYTHON3_VERSION.tgz \
&& cd Python-$PYTHON3_VERSION \
&& ./configure \
		--enable-shared \
		--enable-unicode=ucs4 \
&& make -j$(getconf _NPROCESSORS_ONLN) \
&& make install 

RUN ln -s /usr/local/lib/libpython3.7m.so.1.0 /usr/lib/libpython3.7m.so.1.0 \
	&& python -V \
	&& rm -rf /usr/src/python/

	
#######################################################################################
#Installing pip3

Run wget -O /tmp/get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
	&& python3 /tmp/get-pip.py "pip==$PYTHON_PIP_VERSION" \
	&& pip -V

#######################################################################################
#configuring default python3
Run rm /usr/local/bin/python && ln -s /usr/local/bin/python3 /usr/local/bin/python

#######################################################################################
#Cleanups
RUN apt-get -qy autoremove
#######################################################################################
#Installing Jupyter notebook
RUN python3 -m pip install jupyter && \
    mkdir /opt/notebook

#######################################################################################
#Installing python2 kernel in Jupyter notebook
RUN python2 -m pip install ipykernel 
RUN python2 -m ipykernel install --user

#######################################################################################
#Starting up Jupyter Notebook 
RUN nohup jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/opt/notebook --allow-root >/dev/null 2>&1 &

#######################################################################################


