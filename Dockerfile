FROM urm.nvidia.com/docker/tensorflow/build:latest-python3.9
WORKDIR /xla
ADD . /xla 
ENV TF_NEED_CUDA=1 
ENV TF_CUDA_COMPUTE_CAPABILITIES=compute_70
RUN ./configure
