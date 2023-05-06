---
layout: post
title: "Odoo Terraforming"
excerpt: "An example of how to use modern automation tools to provision ready-to-use business management software in no time."
---

In this article, I will show how easy it is to set up Odoo for a one-person business, and how easy it is to then scale it up when the business grows.

You can find the [full example on GitHub](https://github.com/hwaien/odoo-provisioning-example).

## Odoo is an all-in-one business management software

When starting a business, I learned that I am responsible for managing all aspects of business including [accounting](https://en.wikipedia.org/wiki/Accounting), [sales](https://en.wikipedia.org/wiki/Sales), [customer retention](https://en.wikipedia.org/wiki/Customer_retention), [projects](https://en.wikipedia.org/wiki/Project_management), and more. To meet these needs, an intuitive practice is to keep records on paper. Though paper-based methods are simple, familiar, and inexpensive, they are more time-consuming and error-prone than computer-based methods of business management.

Computer-based methods can be adopted as easy as signing up for [Google Sheets](https://en.wikipedia.org/wiki/Google_Sheets) and creating some spreadsheets to manage business operations. However, as businesses grow, their process and data needs become more complex, and spreadsheets become increasingly difficult to maintain. This is where [Odoo](https://en.wikipedia.org/wiki/Odoo) can be more effective.

Odoo is an all-in-one business management software that offers a suite of integrated applications for various business processes such as accounting, sales, CRM, inventory management, project management, etc. It is an open-source software that can be customized to fit specific business needs.

Odoo is also scalable and easy to use. It is designed to scale up as businesses expand. Its user-friendly and automation-friendly interfaces make it ideal for businesses with limited IT resources.

Next, I will show how easy it is to set up Odoo for a one-person business, and how easy it is to scale it up when the business grows.

## Setting up Odoo for a one-person business

To get started, download the [example code](https://github.com/hwaien/odoo-provisioning-example) and [open it in a container](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container) with Visual Studio Code. Make sure [Kubernetes is enabled](https://docs.docker.com/desktop/kubernetes/#enable-kubernetes) on your container platform.

- If you don't have a container platform, install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
- If you don't have Visual Studio Code, download it [here](https://code.visualstudio.com/Download).
- If you don't know how to download code from GitHub, install [GitHub Desktop](https://desktop.github.com/) and follow the instructions on [cloning a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository?tool=desktop).
- If you are on a Mac, consider using [Homebrew](https://brew.sh/) to simplify installation of [GitHub Desktop](https://formulae.brew.sh/cask/github), [Docker Desktop](https://formulae.brew.sh/cask/docker), and [Visual Studio Code](https://formulae.brew.sh/cask/visual-studio-code).
  - On Windows, [GitHub Desktop](https://winget.run/pkg/GitHub/GitHubDesktop), [Docker Desktop](https://winget.run/pkg/Docker/DockerDesktop), and [Visual Studio Code](https://winget.run/pkg/Microsoft/VisualStudioCode) installations should be just as painless.

Before provisioning Odoo, you may want to customize some configurations to fit your situation. In the file `deployments/config.yaml`, change the `odoo_email` value from `admin@example.com` to your own email address. This is the email address you will use to log in to Odoo later.

Once satisfied with the configurations, you are ready to provision Odoo. In Visual Studio Code,open the [terminal](https://code.visualstudio.com/docs/terminal/basics) and run the following:

```
cd deployments/local/odoo/
terragrunt apply
```

When prompted, enter `yes` to confirm and start provisioning Odoo.

When provisioning completes, use your browser to navigate to `http://localhost/web` to confirm that Odoo is up and running.

The login email is the one you configured earlier. The login password is randomly generated during the provisioning process. To get the password, run the following command:

```
kubectl get pod
```

You will get a list of Kubernetes [pods](https://kubernetes.io/docs/concepts/workloads/pods/), including [Nginx](https://en.wikipedia.org/wiki/Nginx), [PostgreSQL](https://en.wikipedia.org/wiki/PostgreSQL), and Odoo itself. Make note of the name of the Odoo pod. It will look something like `odoo-d478495d6-tnxt4`.

Run the following command to get the [environment variables](https://en.wikipedia.org/wiki/Environment_variable) in the pod. (Replace `odoo-d478495d6-tnxt4` with your pod name.)

```
kubectl exec odoo-d478495d6-tnxt4 -- env
```

The value of the `ODOO_PASSWORD` variable is the password you need to log in to Odoo.

Once logged in, customize Odoo to fit your business needs. If you have questions, consult the [Odoo documentation](https://www.odoo.com/page/docs).

## Scaling up Odoo

Error message saying that "the origin web server does not have a valid SSL certificate."

## References

- [Odoo Installation Preparation](https://www.odoo.com/documentation/16.0/administration/install/install.html#setup-install-source-prepare)
- [The Bitnami Library for Kubernetes](https://github.com/bitnami/charts)
- [Terraform Tutorial: Deploy Applications with the Helm Provider](https://developer.hashicorp.com/terraform/tutorials/use-case/helm-provider)
- [Terraform Helm Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)
- [Terraform DigitalOcean Provider](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs)
- [Terraform Cloudflare Provider](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs)
- [Terraform TLS Provider](https://registry.terraform.io/providers/hashicorp/tls/latest/docs)
- [How to Configure Advanced Load Balancer Settings in Kubernetes Clusters](https://docs.digitalocean.com/products/kubernetes/how-to/configure-load-balancers/)
- [How to Manage SSL Certificates on DigitalOcean Teams](https://docs.digitalocean.com/products/teams/how-to/manage-certificates/)
- [How Cloudflare Works](https://developers.cloudflare.com/fundamentals/get-started/concepts/how-cloudflare-works/)
- [Cloudflare Encryption All the Way](https://blog.cloudflare.com/universal-ssl-encryption-all-the-way-to-the-origin-for-free/)
- [Cloudflare DNS Proxy Status](https://developers.cloudflare.com/dns/manage-dns-records/reference/proxied-dns-records/)
- [Cloudflare Origin CA Certificates](https://developers.cloudflare.com/ssl/origin-configuration/origin-ca/)
- [Kubernetes ingress annotation to customize max body size](https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/nginx-configuration/annotations.md#custom-max-body-size)
- [nginx `client_max_body_size`](https://nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size)
- [Kubernetes Service](https://kubernetes.io/docs/concepts/services-networking/service/)
- [Kubernetes Volumes](https://kubernetes.io/docs/concepts/storage/volumes/)
