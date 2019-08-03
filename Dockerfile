
FROM debian
RUN apt-get -y update 

FROM python:3.7
COPY requirements.txt /tmp
WORKDIR /tmp
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

RUN python3.7 -m pip install jupyter && \
    mkdir /opt/notebook

# cleanup
RUN apt-get -qy autoremove

RUN nohup jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/opt/notebook --allow-root >/dev/null 2>&1 &
