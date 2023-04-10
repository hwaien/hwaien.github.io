---
layout: post
title: Dev Container Time Zone
---

Use the Dev Container feature `ghcr.io/hwaien/devcontainer-features/match-host-time-zone` to make a Dev Container's time zone match the host's time zone.

This Dev Container feature is tested on Mac hosts. It should also work on Linux hosts. I doubt it will work on Windows hosts.

## What Are Containers?

## Dev Containers

## Time Zones

I recently changed my Alpine-based dev container's time zone to Los Angeles by adding `RUN cp /usr/share/zoneinfo/America/Los_Angeles /etc/localtime` to the dev container's docker file.[^1]

[^1]: Ignacio Van Droogenbroeck, [How to change timezone in a Linux Alpine container](https://cduser.com/pique-22-how-to-change-timezone-in-a-linux-alpine-container/)

The issue of timezones in containers is discussed in this article: https://www.howtogeek.com/devops/how-to-handle-timezones-in-docker-containers/

Some solutions are offered in this article: https://dev.to/0xbf/set-timezone-in-your-docker-image-d22

An elegant solution is described here: https://github.com/microsoft/vscode-dev-containers/issues/307#issuecomment-1355599660

What is Alpine?

- https://alpinelinux.org/
- https://github.com/alpinelinux/docker-alpine
