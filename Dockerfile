FROM nvidia/cuda:11.8.0-devel-ubuntu22.04

# Pre-reqs
RUN apt-get update && \
    apt-get install --no-install-recommends -y git build-essential cmake

# Install and build
RUN git clone https://github.com/ComputationalRadiationPhysics/cuda_memtest /app && \
    mkdir /app/build
ARG DCMAKE_CUDA_ARCHITECTURES="86"
WORKDIR /app/build
RUN cmake -DCMAKE_CUDA_ARCHITECTURES=${DCMAKE_CUDA_ARCHITECTURES} .. && \
    make && chmod +x /app/build/cuda_memtest

# Run
WORKDIR /app
COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/app/build/cuda_memtest", "--num_passes", "3", "--num_iterations", "100", "--exit_on_error"]
