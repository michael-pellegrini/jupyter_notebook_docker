FROM debian:latest
LABEL maintainer="michaelpellegrinimail@gmail.com"
LABEL version="latest"
ENV PATH /root/miniconda3/bin:$PATH
RUN apt update; apt upgrade -y; apt install wget -y; mkdir /notebooks; \
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /root/miniconda.sh; \
bash /root/miniconda.sh -b; eval "$(/root/miniconda3/bin/conda shell.bash hook)"; conda init; . /root/.bashrc; \ 
conda update conda -y; conda install -c conda-forge jupyterlab -y; conda clean --all -f -y; \ 
rm /root/miniconda.sh; jupyter server --generate-config; cp /root/miniconda3/condabin/conda /usr/local/bin; \
wget https://raw.githubusercontent.com/hm400/jupyterlab-docker-build/main/jupyter_server_config.json -O /root/.jupyter/jupyter_server_config.json; \
openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout /etc/ssl/certs/mycert.pem -out /etc/ssl/certs/mycert.pem -subj \ 
"/C=US/ST=Self/L=Self/O=Self/CN=www.example.com"
VOLUME [ "/root/miniconda3/pkgs" ]
VOLUME [ "/root/miniconda3/lib" ]
VOLUME [ "/root/miniconda3" ]
VOLUME [ "/root/.jupyter" ]
VOLUME [ "/notebooks" ]
ENTRYPOINT [ "jupyter-lab", "--ip='*'", "--allow-root", "--no-browser", "--certfile=/etc/ssl/certs/mycert.pem", "--notebook-dir=/notebooks" ]
