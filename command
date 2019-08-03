docker run -t -p 8888:8888 -v ~/dockers/jupyter/jupyter_notebook:/opt/notebook -d --name myjupyter2 my_jupyter jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --NotebookApp.token='victory' --allow-root --notebook-dir=/opt/notebook


