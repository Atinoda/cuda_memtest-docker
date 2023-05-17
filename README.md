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
Clone this repository

```git clone https://github.com/Atinoda/cuda_memtest-docker```

### Find your DCMAKE_CUDA_ARCHITECTURES version
This software uses CUDA functions to test the memory in your GPU. You must set the version number to match your card. The default is `8.6`, which is suitable for 3000 series Nvidia GPUs. You can find the CUDA compute version of your card at: [https://developer.nvidia.com/cuda-gpus](https://developer.nvidia.com/cuda-gpus).

Note that the version number should have the full-stop removed, i.e., Compute version 8.6 results in `DCMAKE_CUDA_ARCHITECTURES="86"`. Further information on available versions codes is available by running the command  `nvcc --list-gpu-arch` in the container's environment. The instructions for setting this argument are given in Compose and Standalone Container sections.

---

# Docker Compose

docker-compose is the recommended and easiest way to build and run this image:

- Edit `docker-compose.yml` build arg `DCMAKE_CUDA_ARCHITECTURES` to match your card.
- Build: `docker-compose build`
- Run: `docker-compose up`
- Destroy: `docker-compose down -v`
- *Optional: specify custom test arguments by editing `command:` in `docker-compose.yml`*

---

# Standalone Container

### Build
Go the repository directory and issue the build command:

```docker build --build-arg DCMAKE_CUDA_ARCHITECTURES="YOUR_CUDA_VERSION_CODE" -t cuda_memtest:local .```

This will create a local image tagged as `cuda_memtest:local`

### Run the container

Run (then destroy) a container for this image:

```docker run -it --rm --gpus all cuda_memtest:local```

Run with a custom command (e.g., `--stress`):

```docker run -it --rm --gpus all cuda_memtest:local --stress```

Press `ctrl+c` to exit the test early.


