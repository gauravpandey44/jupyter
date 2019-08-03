#!/bin/bash

#Script to check for Jupyter Container 

/usr/bin/docker ps | grep myjupyter2 

if [ $? -ne 0 ]
then
#/usr/bin/docker run -t -p 8888:8888 -v ~/dockers/jupyter/jupyter_notebook:/opt/notebook -d --name myjupyter2 my_jupyter jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='victory' --allow-root --notebook-dir=/opt/notebook
#docker run -t -p 8888:8888 -v ~/dockers/jupyter/jupyter_notebook:/opt/notebook -d --name myjupyter2 gauravpandey44/myjupyter2:v2 jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='victory' --allow-root --notebook-dir=/opt/notebook
/usr/bin/docker start myjupyter2_v3
fi

