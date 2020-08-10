# Sharing files between C:/... and containers in Docker Desktop

Thanks to the _Shared Drives_ option in Docker Desktop settings, one can share the C: disk in Windows.

To check the drive is properly shared, one can run the following command:

```
docker run --rm -v c:/Users:/data alpine ls /data
```

And this will list the contents inside c:/Users. Note that the format of the _-v_ flag is \<source>:\<target>

In order to run this example, you have to clone this repo in __C:/Users/docker_shared__

Then simply execute in the root of the project:

```
docker-compose up
```

Go to [localhost:5000](http://127.0.0.1:5000) and check that there is a simple html page. Now edit the index.html file inside the public folder and refresh the browser. The page should update immediately, thanks to the file sharing.

We can run the following command to check what type of mount is doing Docker:

```
docker container inspect nginx_volume_web-fe_1
```

And among the details, we can see the following:

```
"Mounts": [
    {
        "Type": "bind",
        "Source": "/host_mnt/c/docker_shared/nginx_volume/public",
        "Destination": "/public",
        "Mode": "rw",
        "RW": true,
        "Propagation": "rprivate"
    }
],
```

Apparently sharing the C: drive is a [bind mount](https://docs.docker.com/storage/bind-mounts/). Although docker recommends using [volumes](https://docs.docker.com/storage/volumes/) instead, when running on Docker Desktop and using Hyper-V one can not easily change the files of a volume, because the [volume is inside the VM of the Hyper-V and not in the Windows filesystem](https://stackoverflow.com/questions/43181654/locating-data-volumes-in-docker-desktop-windows). This is supposed to change when using WSL on Windows, but honestly I have not tried that approach.
