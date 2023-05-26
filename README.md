# Introduction

This is a Linux docker wrapper for the GPU memory testing project:
[ComputationalRadiationPhysics/cuda_memtest](https://github.com/ComputationalRadiationPhysics/cuda_memtest)

Please refer to the project's documentation for available testing commands. This wrapper defaults to executing a 3-pass 100-iteration run of all available tests. 

A template `docker-compose.yml`, and standalone usage commands are provided.

---

# Installation and Set-up

### Pre-requisites
- `docker`
- CUDA-capable docker runtime
- `docker compose`, or `docker-compose` (optional, but recommended)

### Download repository
Clone this repository (or just grab the docker-compose.yml).

```git clone https://github.com/Atinoda/cuda_memtest-docker```

### Find your DCMAKE_CUDA_ARCHITECTURES version
This software uses CUDA functions to test the memory in your GPU. You must set the version number to match your card. The default is `8.6`, which is suitable for 3000 series Nvidia GPUs. You can find the CUDA compute version of your card at: [https://developer.nvidia.com/cuda-gpus](https://developer.nvidia.com/cuda-gpus).

Note that the version number should have the full-stop removed, i.e., Compute version 8.6 results in `DCMAKE_CUDA_ARCHITECTURES="86"`. Further information on available versions codes is available by running the command  `nvcc --list-gpu-arch` in the container's environment. The instructions for setting this argument are given in Compose and Standalone Container sections.

---

# Docker Compose

docker-compose is the recommended and easiest way to run this image:

## Run

- Run: `docker-compose up`
- Destroy: `docker-compose down -v`
- *Optional: specify custom test arguments by editing `command:` in `docker-compose.yml`*


## Build locally
If you need a different version of CUDA you can build the image locally:

- Uncomment the build directives in `docker-compose.yml`
- Comment out the `image: ` mapping in `docker-compose.yml`
- Edit the `docker-compose.yml` build arg `DCMAKE_CUDA_ARCHITECTURES` to match your card.
- Build: `docker-compose build`

---

# Standalone Container



### Run the container

Run (then destroy) a container for this image:

```docker run -it --rm --gpus all atinoda/cuda_memtest:latest```

Run with a custom command (e.g., `--stress`):

```docker run -it --rm --gpus all atinoda/cuda_memtest:latest --stress```

Press `ctrl+c` to exit the test early.

### Build locally
Go to the repository directory and issue the build command:

```docker build --build-arg DCMAKE_CUDA_ARCHITECTURES="YOUR_CUDA_VERSION_CODE" -t cuda_memtest:local .```

This will create a local image tagged as `cuda_memtest:local`


