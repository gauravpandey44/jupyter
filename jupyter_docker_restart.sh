#!/bin/bash

#Script to restart the  Jupyter Container

/usr/bin/docker stop  myjupyter2
sleep 20
/usr/bin/docker start myjupyter2
