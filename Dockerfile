FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    build-essential \
    libfftw3-dev    \
    g++ gfortran    \
    libopenmpi-dev  \
    openmpi-bin     \
    git             \
    cmake           \
    wget            \
    python3         \
    libxcursor1     \
    libgl1          \
    libxt6          \
    libx11-6        \
    libosmesa6      \
    libosmesa6-dev  \
    ffmpeg          \
 && rm -rf /var/lib/apt/lists/* \
 && update-ca-certificates 

RUN wget https://www.paraview.org/files/v6.0/ParaView-6.0.1-MPI-Linux-Python3.12-x86_64.tar.gz \
 && tar -xzf ParaView-6.0.1-MPI-Linux-Python3.12-x86_64.tar.gz -C /opt \
 && rm ParaView-6.0.1-MPI-Linux-Python3.12-x86_64.tar.gz

# Add ParaView binaries to PATH

RUN echo "alias pvpython='/opt/ParaView-6.0.1-MPI-Linux-Python3.12-x86_64/bin/pvpython'" >> /root/.bashrc

RUN git clone --branch 25.12 --depth 1 https://github.com/AMReX-Codes/amrex.git
RUN git clone https://github.com/WeiqunZhang/amrex-101.git

RUN cd amrex-101/Amr/Exec && git pull \
 && make -j`nproc`

ENV OMPI_ALLOW_RUN_AS_ROOT=1 \
    OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1 \
    VTK_DEFAULT_OPENGL_WINDOW=vtkOSOpenGLRenderWindow
WORKDIR /amrex-101/Amr/Exec
CMD ["/bin/bash"]
