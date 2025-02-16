![Docker Automated build](https://img.shields.io/docker/automated/m400/jupyterlab) ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/m400/jupyterlab?logo=docker&style=plastic)  ![Docker Pulls](https://img.shields.io/docker/pulls/m400/jupyterlab?logo=docker&style=plastic)  

## Jupyter Notebook Docker Image - linux/AMD64

The container image is intended for a single user on a private network.  

The container image uses ubuntu as base image with latest versions of miniconda3 and jupyterlab.
See https://jupyterlab.readthedocs.io/en/stable/

The container image has a preconfigured changeable password (admin) and a ssl certificate that is generated on build. 
The password can easily be changed after starting the container and ssl can be disabled by adding empty environmental variable `-e CERT=`

*Additional python packages can be installed with the `conda` command in the jupyterlab terminal.

```
VOLUME /notebooks            Volume is default folder required for saved work to persist (.ipynb files etc..)
VOLUME /root/miniconda3/pkgs Volume required to save user installed conda packages
VOLUME /root/miniconda3/lib  Volume required to save user installed conda packages.
VOLUME /root/.jupyter        Volume required to change password and save.
```

## Docker run command for HTTPS
#### Default password = admin

`docker run -d -p 8888:8888 --name jupyter -v notebooks:/notebooks -v config:/root/.jupyter -v lib:/root/miniconda3/lib -v pkgs:/root/miniconda3/pkgs m400/jupyterlab`

Point web browser to `https://127.0.0.1:8888`  or `https://your_IP:8888`   Default password `admin`

Typing `https://` is requried.

## Docker run command for HTTP 
#### Default password = admin

`docker run -d -p 8888:8888 --name jupyter -e CERT= -v notebooks:/notebooks -v config:/root/.jupyter -v lib:/root/miniconda3/lib -v pkgs:/root/miniconda3/pkgs m400/jupyterlab`

Point web browser to `http://127.0.0.1:8888`  or `http://your_IP:8888`   Default password `admin`

### To change default password

`docker exec -it <ContainerName> bash`  

```
(base) root@4c3a707e0f87:/# jupyter server password
Enter password: 
Verify password: 
[JupyterPasswordApp] Wrote hashed password to /root/.jupyter/jupyter_server_config.json
(base) root@4c3a707e0f87:/# exit
``` 

`docker restart <ContainerName`
If you logged in with default password. Restart Web browser before logging in again.

### Docker-compose.yml 
```
version: '3.7'
services:
  application:
    image: m400/jupyterlab
    
    environment:                 #Comment out to enable HTTP
    - CERT=                      #Comment out to enable HTTP
    ports:
    - 8888:8888
    volumes:
    - notebooks:/notebooks
    - config:/root/.jupyter
    - pkgs:/root/miniconda3/pkg
    - lib:/root/miniconda3/lib

    restart: unless-stopped
volumes:
  notebooks:
  config:
  pkgs:
  lib:
```

