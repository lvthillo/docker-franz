# docker-franz
Franz is a free messaging app / former Emperor of Austria and combines chat & messaging services into one application.
http://meetfranz.com/


#### Build the image
```
$ docker build -t lorenzvth7/franz .
```

### Start Franz Container
```
$ docker run -d \
--net host \
--cpuset-cpus 0 \
--memory 512mb \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY=unix:0 \
--device /dev/snd \
-v /dev/shm:/dev/shm \
-v path-on-host:/home/franz/.config/Franz \ #keep your franz configuration persistent
lorenzvth7/franz

```

If you close your Franz you can restart it by restarting the container.
