
FROM debian
RUN apt-get -y update && \
#apt-get -y install python2.7 && \
#apt-get -y install python-pip && \
apt-get -y install python3 && \
apt-get -y install python3-pip


RUN python3 -m pip install --upgrade pip && \
python3 -m pip install jupyter && \
mkdir /opt/notebook

# cleanup
RUN apt-get -qy autoremove

RUN nohup jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/opt/notebook --allow-root >/dev/null 2>&1 &
