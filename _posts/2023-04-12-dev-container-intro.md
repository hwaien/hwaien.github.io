---
layout: post
title: Introduction to Dev Containers
---

Dev Containers help software developers effortlessly maintain consistent environments for software development.

## Setting up development environments is painful

To begin working on a software project, a developer must first create a suitable development environment by installing and configuring many necessary tools. These can include version control systems, compilers, linkers, transpilers, bundlers, minifiers, analyzers, debuggers, package managers, task automation tools, software development kits, etc.

Some software projects rely on tribal knowledge and word of mouth to preserve guidance on development environment setup, while other projects keep written documentation of the step-by-step procedures to create a proper environment for project development.

Even with best efforts to maintain documentation, it is not uncommon for new development environments to take a long time to create. Documentation often cannot account for every developer's scenario, nor can it keep up with unceasing updates and changes of development tools.

After painstaking development environment setup, teams often still end up with subtle inconsistencies among team members' development environments, causing inconsistent experiences that distract, frustrate, and hinder the team to build software efficiently.

Such efficiency loss is especially hard to ignore for projects involving many developers (such as open-source projects) and for developers working on many projects (such as software consultants).

## Development environment snapshots reduce setup pains

Solutions to the development environment setup problem revolve around the idea of saving and restoring snapshots.

### Disk Images

Snapshotting devices as [disk images](https://en.wikipedia.org/wiki/Disk_image) is a time-honored computer management practice dating back to the 1960s. Though mainly used to [back up](https://en.wikipedia.org/wiki/Backup) data and mitigate data loss events, disk images are also widely used to rapidly deploy identical configurations across computers.

In the context of development environment setup: once a team member successfully creates a proper development environment, a system administrator can create a disk image of that system, and use [disk cloning](https://en.wikipedia.org/wiki/Disk_cloning) to rapidly recreate the same environment on other team members' machines. Not only does this approach speed up the setup process, it also eliminates the possibility of inconsistencies.

### Virtual Machines

Teams can take this idea further by doing software development on virtual machines and use virtual disk images to create development environments even more rapidly. Virtual machine is a mature technology supported by trusted vendors and products such as VMware, Microsoft Hyper-V nad Oracle VirtualBox. For more productivity gains, one can use [Vagrant](https://www.vagrantup.com/) to help manage the lifecycle of virtual machines, and [Packer](https://www.packer.io/) to help track the way the disk images are built.

### Containers

Further efficiency can be gained by using [containers]({% post_url 2023-04-08-containerization-intro %}) instead of virtual machines, as container images are more compact and portable than virtual disk images. Moreover, containerization tools such as [Docker](<https://en.wikipedia.org/wiki/Docker_(software)>) make lifecycle management and image tracking a breeze.

## Dev Containers are foolproof development environment snapshots

As more software developers recognize the benefits of running development environment in containers, the idea culminates in the specification of [Development Containers](https://containers.dev/) (or Dev Containers for short). Dev Containers capture common development-specific settings, tools, and configurations in a straightforward `devcontainer.json` metadata format. The metadata file is kept within your project source code repository. When you work on the source code repository using a service or tool that supports Dev Containers, your containerized development environment is managed automatically, giving a most painless experience.

A notable service that supports Dev Containers is [GitHub Codespaces](https://docs.github.com/en/codespaces/overview); a notable tool that supports Dev Containers is [Visual Studio Code](https://en.wikipedia.org/wiki/Visual_Studio_Code) (or VS Code for short). VS Code is a free code editor available for Mac, Windows, and Linux. If you are new to containerized development environments and eager to explore the concept, I recommend following the VS Code [Dev Containers tutorial](http://aka.ms/vscode-remote/containers/tutorial) to quickly get started.

## Further Reading

- [Dev Container Overview](https://containers.dev/overview)
- [Discover DevContainers: Revolutionize Your Development Workflow with Reproducible Environments!](https://mihaibojin.medium.com/discover-devcontainers-revolutionize-your-development-workflow-with-reproducible-environments-e0e7b62495e3)
- [The Power of Docker Images: A Comprehensive Guide to Building From Scratch](https://dzone.com/articles/the-power-of-docker-images-a-comprehensive-guide-t)
