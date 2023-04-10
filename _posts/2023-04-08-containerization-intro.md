---
layout: post
title: Introduction to Containerization
---

Containerization is an efficient way to run software applications in independent environments on the same system.

To skip the history lessons and get started playing around with containers, scroll [to the end](#getting-started-is-easy).

## Virtualization lowers the cost of computation

In today's Internet age, many software applications run on computer systems housed in dedicated [data centers](https://en.wikipedia.org/wiki/Data_center) equipped with infrastructure for power supply, networked communication, air conditioning, and security. Equipment installation and maintenance are not cheap, nor is the electricity bill to keep data centers running. It is costly to leave computer systems idle.

Cost is managed by keeping computer systems busy. Computer systems are kept busy by running more software applications on the same system. However, running too many software applications side-by-side directly on the same system can be problematic. Firstly, different applications may have [conflicting dependencies](https://en.wikipedia.org/wiki/Dependency_hell), preventing correct installation and setup. Even if setup can be done correctly, there is risk of one application's misbehavior—malicious or otherwise—causing other applications running on the same system to fail.

The solution to these problems is [virtualization](https://en.wikipedia.org/wiki/Virtualization), where software applications on the same computer system run in isolated virtual environments. This approach has been in use as far back as the IBM [CP/CMS](https://en.wikipedia.org/wiki/CP/CMS) in the 1960s, where the system provided each user with a virtual machine environment. Since then, [virtual machine](https://en.wikipedia.org/wiki/Virtual_machine) technology has matured and become widely adopted. Today, it is supported on all major cloud platforms, including [Amazon EC2](https://aws.amazon.com/ec2/), [Google Compute Engine](https://cloud.google.com/compute/), and [Microsoft Azure Virtual Machines](https://azure.microsoft.com/en-us/products/virtual-machines/).

## Containerization is a lightweight kind of virtualization

Virtual machines help to lower computational cost. However, virtualizing an entire computer system is a heavy task. This limits the speed and number of virtual machines running on the same computer system. Further cost savings can be achieved with the observation that only parts of a computer system need to be virtualized for an environment to seem sufficiently isolated. This observation leads to the development of [operating-system-level virtualization](https://en.wikipedia.org/wiki/OS-level_virtualization), or **containerization**.

Containerization mechanisms exist as early as the [FreeBSD jail](https://en.wikipedia.org/wiki/FreeBSD_jail) in 2000. On the [Linux](https://en.wikipedia.org/wiki/Linux) operating system, containerization is made possible by [namespaces](https://en.wikipedia.org/wiki/Linux_namespaces) and [control groups](https://en.wikipedia.org/wiki/Cgroups). Namespaces support resource isolation such as separate host names, user identification segregation, and network stack virtualization. Control groups account for and limit the usage of resources such as CPU, memory, disk, and network.

Using these resource management mechanisms, Linux containerization creates an illusion that software processes are running in independent virtual environments, without incurring the cost of running an intermediate virtual machine. The result is greater speed and number of software processes running on the same computer system.

## Docker is a useful containerization tool

One can directly configure Linux namespaces and control groups to containerize an isolated virtual environment. However, doing so can be tedious and error-prone. A more sustainable practice is to use a containerization tool, such as [Docker](<https://en.wikipedia.org/wiki/Docker_(software)>).

In addition to managing Linux namespaces and control groups, Docker also leverages [union mounting](https://en.wikipedia.org/wiki/Union_mount) to assemble a virtual environment's file system from incremental layers of file system states. Each layer is a read-only file system snapshot, and can therefore be reused among multiple virtual environments. This reduces file duplication and saves disk space.

To ensure the file system is assembled identically each time the same container is launched, Docker manages the container's template using an image file. An image file includes descriptions of filesystem changes and corresponding execution parameters for use within a container runtime. Image files are small enough to be easily passed around, giving rise to container registry servers such as [Docker Hub](https://hub.docker.com/), where you can upload and download images.

Due to Docker's popularity, many container images exist on registry servers today. Before building your own image, consider searching the online registries. It is likely that you will find what you need.

## Getting started is easy

To start playing around with containers, download and install [Docker Desktop](https://www.docker.com/get-started/). After launching Docker Desktop, you should see tutorials to guide you to set up and run your first container.

(You may be surprised to see that there are also versions of Docker Desktop for non-Linux operating systems, such as the Mac. The way it works is that Docker first runs a Linux virtual machine on macOS, then runs Linux containers on this virtual machine.)

## Further Reading

- [A Practical Introduction to Container Terminology](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction)
- [What is a container image?](https://opensource.com/article/21/8/container-image)
- [Docker Overview](https://docs.docker.com/get-started/overview/)
- [Docker internals: process isolation with namespaces and cgroups](https://leftasexercise.com/2018/04/12/docker-internals-process-isolation-with-namespaces-and-cgroups/)
- [Demystifying the OCI Specifications](https://www.docker.com/blog/demystifying-open-container-initiative-oci-specifications/)
- [OCI Image Format Specification](https://github.com/opencontainers/image-spec)
- [Frequently asked questions for Docker Desktop on Mac](https://docs.docker.com/desktop/faqs/macfaqs/)
- [Namespaces and Cgroups – the basis of Linux Containers](https://www.andrew.cmu.edu/course/14-712-s20/applications/ln/Namespaces_Cgroups_Conatiners.pdf)
- [Virtualization and Containerization of Application Infrastructure: A Comparison](https://thijs.ai/papers/scheepers-virtualization-containerization.pdf)
