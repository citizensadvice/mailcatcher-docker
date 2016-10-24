# About this Repo

This is the Citizens Advice [Mailcatcher](http://mailcatcher.me/) docker image
It uses the official docker ruby image as it's base

## Using this image

```console
$ docker run -d --name mailcatcher -p 1025 -p 1000 citizensadvice/docker-mailcatcher
```

Now you can access to the mailcatcher smtp via port `1025` and the web interface via port `1080`
