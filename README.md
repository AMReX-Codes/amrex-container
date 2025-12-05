
Follow the commands below to pull the amrex container, run the amrex101 test,
and make a movie.
```
$ docker pull weiqunzhang/amrex:latest
$ docker run -it weiqunzhang/amrex:latest
# mpiexec -n 4 ./main3d.gnu.MPI.ex inputs
# pvpython paraview_amr101.py
```

To get the movie files to the host, run this from a terminal on the *host*
while the container is still running.
```
$ docker cp $(docker ps -q | head -n1)://amrex-101/Amr/Exec/amr101_3D.avi .
$ docker cp $(docker ps -q | head -n1)://amrex-101/Amr/Exec/amr101_3D.gif .
```
