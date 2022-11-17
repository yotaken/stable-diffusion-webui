FROM nvidia/cuda:11.3.1-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /sd-automatic1111

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y libglib2.0-0 libsm6 libxext6 wget libgl1 libxrender1 libgtk2.0-dev pkg-config unzip cmake nano ffmpeg git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda
RUN wget -O ~/miniconda.sh -q --show-progress --progress=bar:force https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    /bin/bash ~/miniconda.sh -b -p $CONDA_DIR && \
    rm ~/miniconda.sh
ENV PATH=$CONDA_DIR/bin:$PATH

ENV CUDAHOME /usr/local/cuda-11.3

# Install font for prompt matrix
COPY /DejaVuSans.ttf /usr/share/fonts/truetype/

EXPOSE 7860

COPY ./webui.sh /sd-automatic1111/
ENTRYPOINT /sd-automatic1111/webui.sh

