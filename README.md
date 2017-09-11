# robotics_ws

sudo docker stop $(sudo docker ps -aq); sudo docker rm $(sudo docker ps -aq); sudo docker build . -t robotics_ws && sudo nvidia-docker run -it --env="DISPLAY" --env="QT_X11_NO_MITSHM=1" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -v $(pwd)/src:/workspace --privileged --net=host --name robotics_ws robotics_ws

