---
layout: post
title: Dev Container Time Zone
---

Use the Dev Container Feature `ghcr.io/hwaien/devcontainer-features/match-host-time-zone` to make a Dev Container's time zone match the host's time zone.

## Containers isolate time zone tracking

For those unfamiliar: [Dev Containers]({% post_url 2023-04-12-dev-container-intro %}) are a blissful way for software developers to maintain consistent development environments. Dev Containers are built on top of industry standard [container]({% post_url 2023-04-08-containerization-intro %}) formats and runtimes.

An essential feature of containers is file system isolation. A container's file system is virtually isolated from the host's file system. (This is done using the [`pivot_root`](https://man7.org/linux/man-pages/man2/pivot_root.2.html) system call to mount a separate root file system for the container, and using the [mount namespaces](https://www.man7.org/linux/man-pages/man7/mount_namespaces.7.html) feature to keep the container's directory hierarchy isolated.)

As a consequence of file system isolation, any file-based operation inside a container will behave independently of the host system. This includes keeping track of [time zone](https://en.wikipedia.org/wiki/Time_zone), which is done based on the file [`/etc/localtime`](https://www.freedesktop.org/software/systemd/man/localtime.html).

## Time zone matters in software development

A Dev Container's `/etc/localtime` is set to a fixed time zone when its image was built. For many Dev Containers, this time zone is UTC±00:00. This means that Dev Containers will usually have a time zone that is different from the developer's local time zone.

This is unfortunate, as time zone matters in software development. Computer software components typically log records of significant events during their operations. The logs include [timestamps](<https://en.wikipedia.org/wiki/Timestamping_(computing)>) to clarify the temporal order of events. Software developers use these logs to either confirm the correctness of software functions or troubleshoot software errors.

Troubleshooting software errors is not an easy task, sometimes involving lengthy log files, and sometimes involving accounting for events from multiple log files. Having the log files record timestamps in a time zone that is different from the developer's local time zone only makes the task more unwieldy and mistakes more likely.

## Match container time zone with host

Recognizing the significance of time zones, some container management tools provide direct support to match a container's time zone with its host's time zone. For example, the `run` command of [Podman](https://podman.io/) supports a [`--tz=local`](https://docs.podman.io/en/latest/markdown/podman-run.1.html#tz-timezone) configuration to set a container's time zone to match the host machine.

On the other hand, [Docker's `run` command](https://docs.docker.com/engine/reference/commandline/run/) does not provide the same support. However, since most developers run [VS Code](https://en.wikipedia.org/wiki/Visual_Studio_Code) Dev Containers on Docker Desktop and not Podman, we need a Docker solution, which can be achieved by using a [bind mount](https://docs.docker.com/get-started/06_bind_mounts/) to mount the host's `/etc/localtime` at the same location in the container. The `devcontainer.json` Dev Container metadata syntax to specify this bind mount is as follows.

```
{
  ...
  "mounts": [
    ...
    {
      "source": "/etc/localtime",
      "target": "/etc/localtime",
      "type": "bind"
    }
  ]
}
```

## Use Dev Container Feature to share configuration

Because I work with many source code repositories, duplicating the bind mount metadata quickly became repetitive, violating the [DRY](https://en.wikipedia.org/wiki/Don't_repeat_yourself) principle of software development. Therefore, I created the [`match-host-time-zone` Dev Container Feature](https://github.com/hwaien/devcontainer-features/tree/main/src/match-host-time-zone) to maintain the mount configuration in a central location. [Dev Container Features](https://containers.dev/implementors/features/) are self-contained, shareable units of configuration for Dev Containers. There are at least two different ways to use the `match-host-time-zone` Feature.

Firstly, if you would like all developers working on your repository to share the time zone matching behavior, reference the `match-host-time-zone` Feature in the repository's `devcontainer.json` file like this:

```
{
  ...
  "features": {
    ...
    "ghcr.io/hwaien/devcontainer-features/match-host-time-zone": {}
  }
}
```

Otherwise, if you do not want to force the Feature onto others, but want all your own Dev Containers to match host time zone, edit your VS Code `settings.json` like this:

```
{
  ...
  "dev.containers.defaultFeatures": {
    ...
    "ghcr.io/hwaien/devcontainer-features/match-host-time-zone": {}
  }
}
```

## Further Reading

- [Principles of container technology (5): file system isolation and sharing](https://www.sobyte.net/post/2022-04/container-fundamentals-filesystem-isolation-and-sharing/)
- [Custom Dev Container Features](https://code.visualstudio.com/blogs/2022/09/15/dev-container-features)
- [Tick-tock. Does your container know what time it is?](https://www.redhat.com/sysadmin/tick-tock-container-time)
- [How to Handle Timezones in Docker Containers](https://www.howtogeek.com/devops/how-to-handle-timezones-in-docker-containers/)
- [Set timezone in your docker image](https://dev.to/0xbf/set-timezone-in-your-docker-image-d22)
- [How to change timezone in a Linux Alpine container](https://cduser.com/pique-22-how-to-change-timezone-in-a-linux-alpine-container/)
- [Support setting container time zone to host time zone](https://github.com/microsoft/vscode-dev-containers/issues/307#issuecomment-1355599660)
