#docker run -t -p 8888:8888 -v ~/dockers/jupyter/jupyter_notebook:/opt/notebook -d --name myjupyter2 my_jupyter jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='victory' --allow-root --notebook-dir=/opt/notebook

#docker run -t --user root -e NB_USER=gaurav -e NB_UID=$(id -u) -e NB_GID=$(id -g)  -p 8888:8888 -v ~/dockers/jupyter/jupyter_notebook:/opt/notebook -d --name myjupyter2_v5 myjupyter2:v5 jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='victory' --allow-root --notebook-dir=/opt/notebook

docker run -d -p 8888:8888 -v ~/dockers/jupyter/jupyter_notebook:/home/jovyan/notebook -d --name myjupyter2_v7 myjupyter2:v7 jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='victory' --allow-root --notebook-dir=/home/jovyan/notebook
