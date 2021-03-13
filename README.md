![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/m400/jupyterlab?logo=docker&style=plastic)  ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/m400/jupyterlab?logo=docker&style=plastic)  ![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/m400/jupyterlab?logo=docker&style=plastic)  ![Docker Pulls](https://img.shields.io/docker/pulls/m400/jupyterlab?logo=docker&style=plastic)  

## Jupyter Notebook Docker Image - linux/AMD64

This container image is intended for a single user on private network.  

`docker run -d -p 8888:8888 -e CERT='' m400/jupyterlab`  
point browser to `127.0.0.1:8888` or `ipaddress:8888`  default password `admin` 

Any issues clear cache restart browser or user private window 


The container image uses ubuntu as base image with latest versions of miniconda3 and jupyterlab. Jupyterlab is the latest edition of Jupyter Notebook.
See https://jupyterlab.readthedocs.io/en/stable/

The container image has a preconfigured password and an ssl certificate that is generated on build. 
The password can easily be changed after starting the container and ssl can be disabled by passing empty variable `-e CERT=''`
Additional python packages can be installed with the `conda` command in the jupyterlab terminal.

```
VOLUME /notebooks            Volume is default folder required for saved work to persist (.ipynb files etc..)
VOLUME /root/miniconda3/pkgs Volume required to save user installed conda packages
VOLUME /root/miniconda3/lib  Volume also required to save user installed conda packages.
VOLUME /root/.jupyter        Volume required to save user password change.
```

### Docker run command without SSL.
##### Default password = admin

`docker run -d -p 8888:8888 --name jupyter -e CERT='' -v notebooks:/notebooks -v config:/root/.jupyter -v lib:/root/miniconda3/lib -v pkgs:/root/miniconda3/pkgs m400/jupyterlab`

Point web browser to `http://127.0.0.1:8888`  or `http://your_IP:8888`   Default password `admin`


### Docker run command with SSL (default).
##### Default password = admin

`docker run -d -p 8888:8888 --name jupyter -v notebooks:/notebooks -v config:/root/.jupyter -v lib:/root/miniconda3/lib -v pkgs:/root/miniconda3/pkgs m400/jupyterlab`

Point web browser to `https://127.0.0.1:8888`  or `https://your_IP:8888`   Default password `admin`

### To change default password

`docker exec -it jupyter bash`  
`docker exec -it <containerID or Name> bash`

```
(base) root@4c3a707e0f87:/# jupyter server password
Enter password: 
Verify password: 
[JupyterPasswordApp] Wrote hashed password to /root/.jupyter/jupyter_server_config.json
(base) root@4c3a707e0f87:/# exit
``` 

`docker restart jupyter`

Restart Web browser before logging in, if you logged in with default password.

### Docker-compose.yml 
```
version: '3.7'
services:
  application:
    image: m400/jupyterlab
    #environment:                   (uncomment to disable ssl)
    #- CERT=""
    ports:
    - 8888:8888
    volumes:
    - notebooks:/notebooks
    - config:/root/.jupyter
    - pkgs:/root/miniconda3/pkg
    - lib:/root/miniconda3/lib
    #- miniconda3:/root/miniconda3  (optional) maps entire installation to volume
    restart: unless-stopped
volumes:
  notebooks:
  config:
  pkgs:
  lib:
  #miniconda3                       (optional)
```
Point web browser to `https://127.0.0.1:8888`  or `https://your_IP:8888`   Default password `admin`

If ssl disabled Point web browser to `http://127.0.0.1:8888`  or `http://your_IP:8888`   Default password `admin`

![screenshot](https://raw.githubusercontent.com/hm400/assets/main/ksnip_20210105-182901.png)
![screenshot](https://raw.githubusercontent.com/hm400/assets/main/ksnip_20210105-183002.png)
![screenshot](https://raw.githubusercontent.com/hm400/assets/main/ksnip_20210105-183821.png)
