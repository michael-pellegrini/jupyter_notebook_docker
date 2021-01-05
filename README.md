## Jupyterlab Docker Image - For AMD64(x86-64)

This container image is intended for a single user on private network.  

The container image uses debian as base image with latest versions of miniconda3 and jupyterlab.

The container image has a preconfigured password and an ssl certificate that is generated on build. 
The password can easily be changed after starting the container.
Additional python packages can be installed with the `conda` command in the jupyterlab terminal.


`VOLUME /notebooks`            Volume is default folder in jupyterlab and is required to save work (.ipynb files etc..)

`VOLUME /root/.jupyter`        Volume required to save user password change.

`VOLUME /root/miniconda3/pkgs` Volume required to save user installed conda packages

`VOLUME /root/miniconda3/lib`  Volume also required to save user installed conda packages. 

`VOLUME /root/miniconda3`      Volume for entire miniconda package (Optional)


### Docker run example.
#### Default password = admin

`docker run -d -p 8888:8888 --name jupyter -v notebooks:/notebooks -v config:/root/.jupyter -v lib:/root/miniconda3/lib -v pkgs:/root/miniconda3/pkgs m400/jupyter`

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

### Docker-compose example
```
version: '3.7'
services:
  application:
    image: m400/jupyterlab
    ports:
    - 8888:8888
    volumes:
    - notebooks:/notebooks
    - config:/root/.jupyter
    - pkgs:/root/miniconda3/pkg
    - lib:/root/miniconda3/lib
    #- miniconda3:/root/miniconda3  #optional
    restart: unless-stopped
volumes:
  notebooks:
  config:
  pkgs:
  lib:
```
Point web browser to `https://127.0.0.1:8888`  or `https://your_IP:8888`   Default password `admin`
