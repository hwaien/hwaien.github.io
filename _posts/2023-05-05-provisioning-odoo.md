---
layout: post
title: "Odoo Terraforming"
excerpt: "An example of how to use modern automation tools to provision ready-to-use business management software in no time."
---

In this article, I will show how easy it is to set up Odoo for a single computer, and how easy it is to then scale it up when the business grows.

You can find the [full example on GitHub](https://github.com/hwaien/odoo-provisioning-example).

## Odoo is an all-in-one business management software

When starting a business, I learned that I am responsible for managing all aspects of business including [accounting](https://en.wikipedia.org/wiki/Accounting), [sales](https://en.wikipedia.org/wiki/Sales), [customer retention](https://en.wikipedia.org/wiki/Customer_retention), [projects](https://en.wikipedia.org/wiki/Project_management), and more. To meet these needs, an intuitive practice is to keep records on paper. Though paper-based methods are simple, familiar, and inexpensive, they are more time-consuming and error-prone than computer-based methods of business management.

Computer-based methods can be adopted as easy as signing up for [Google Sheets](https://en.wikipedia.org/wiki/Google_Sheets) and creating some spreadsheets to manage business operations. However, as businesses grow, their process and data needs become more complex, and spreadsheets become increasingly difficult to maintain. This is where something like [Odoo](https://en.wikipedia.org/wiki/Odoo) can be more effective.

Odoo is an all-in-one business management software that offers a suite of integrated applications for business processes such as accounting, sales, CRM, inventory management, project management, etc. It is an open-source software that can be customized to fit specific business needs.

Moreover, Odoo is scalable and easy to use. It is designed to scale up as businesses expand. Its user-friendly and automation-friendly interfaces make it ideal for businesses with limited IT resources.

Next, I will show how easy it is to set up Odoo for a single computer, and how easy it is to scale it up when the business grows.

## How to set up Odoo for a single computer

To get started, download the [example code](https://github.com/hwaien/odoo-provisioning-example) and [open it in a container](https://code.visualstudio.com/docs/devcontainers/containers#_quick-start-open-an-existing-folder-in-a-container) with Visual Studio Code. Make sure [Kubernetes is enabled](https://docs.docker.com/desktop/kubernetes/#enable-kubernetes) in Docker.

- If you don't already have Docker, install [Docker Desktop](https://www.docker.com/products/docker-desktop/).
- If you don't already have Visual Studio Code, download it [here](https://code.visualstudio.com/Download).
- If you don't know how to download code from GitHub, install [GitHub Desktop](https://desktop.github.com/) and follow the instructions on [cloning a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository?tool=desktop).
- If you are on a Mac, consider using [Homebrew](https://brew.sh/) to simplify installation of [GitHub Desktop](https://formulae.brew.sh/cask/github), [Docker Desktop](https://formulae.brew.sh/cask/docker), and [Visual Studio Code](https://formulae.brew.sh/cask/visual-studio-code).
  - On Windows, [GitHub Desktop](https://winget.run/pkg/GitHub/GitHubDesktop), [Docker Desktop](https://winget.run/pkg/Docker/DockerDesktop), and [Visual Studio Code](https://winget.run/pkg/Microsoft/VisualStudioCode) installations should be just as painless.

Before provisioning Odoo, you may want to customize some configurations to fit your situation. For example, in the file `deployments/config.yaml`, you may want to change the `odoo_email` value from `admin@example.com` to your own email address. This is the email address you will use to log in to Odoo.

Once satisfied with the configurations, you are ready to provision Odoo. In Visual Studio Code, open the [terminal](https://code.visualstudio.com/docs/terminal/basics) and run the following:

```
cd deployments/local/odoo/
terragrunt apply
```

When prompted, enter `yes` to start provisioning Odoo.

When provisioning completes, use your browser to navigate to `http://localhost/web` to confirm that Odoo is up and running.

The login email is the one you configured earlier. The login password is randomly generated during the provisioning process. To get the password, run the following command:

```
kubectl get pod
```

You will get a list of Kubernetes [pods](https://kubernetes.io/docs/concepts/workloads/pods/), including [Nginx](https://en.wikipedia.org/wiki/Nginx), [PostgreSQL](https://en.wikipedia.org/wiki/PostgreSQL), and Odoo itself. Make note of the name of the Odoo pod. It will look something like `odoo-d478495d6-tnxt4`.

Get the [environment variables](https://en.wikipedia.org/wiki/Environment_variable) in the Odoo pod by running the following command. (Replace `odoo-d478495d6-tnxt4` with the name of your Odoo pod.)

```
kubectl exec odoo-d478495d6-tnxt4 -- env
```

The value of the `ODOO_PASSWORD` variable is the password you need to log in to Odoo.

Once logged in, customize Odoo to fit your business needs. If you have questions, consult the [Odoo documentation](https://www.odoo.com/page/docs).

## How to scale up Odoo

Using an existing computer to run Odoo is a cost-effective business management solution. You get a suite of useful business software applications while only paying a little more on the electricity bill.

This arrangement may serve you well for a while. Eventually, the business will grow to have multiple computers needing to access Odoo. To meet the needs of your growing business, a natural evolution is to scale up Odoo by migrating it from your computer to the cloud.

Before the cloud migration, you will need a [cloud computing](https://en.wikipedia.org/wiki/Cloud_computing) platform onto which to provision Odoo, and a [DNS](https://en.wikipedia.org/wiki/Domain_Name_System) service to tell the rest of the Internet where you've provisioned Odoo.

There are many reputable cloud computing platforms in the market. One of the lower-cost options is [DigitalOcean](https://en.wikipedia.org/wiki/DigitalOcean). After [signing up](https://cloud.digitalocean.com/registrations/new) for a new account, follow [instructions to create an access token](https://docs.digitalocean.com/reference/api/create-personal-access-token/) with "Write" scope. In your Visual Studio Code terminal, run `export DIGITALOCEAN_TOKEN=abcdefg` to save the token (replacing `abcdefg` with your actual token).

There are also many reputable DNS service providers in the market. [Cloudflare](https://en.wikipedia.org/wiki/Cloudflare) is one such provider with unique capabilities to secure and speed up access to your cloud applications. After [signing up](https://dash.cloudflare.com/sign-up) for a new account, follow [instructions to create an API token](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/) with "Edit" permissions for Zone "DNS" and "SSL and Certificates." In your Visual Studio Code terminal, run `export CLOUDFLARE_API_TOKEN=abcdefg` to save the token (replacing `abcdefg` with your actual token).

In the file `deployments/config.yaml`, change the `odoo_domain` value from `example.com` to your Internet [domain](https://en.wikipedia.org/wiki/Domain_name). If you don't already have a domain, Cloudflare also [sells them](https://developers.cloudflare.com/registrar/get-started/register-domain/) at reasonable prices.

Once you've exported DigitalOcean and Cloudflare tokens and customized `config.yaml` files, you are ready to provision Odoo. Run the following in your Visual Studio Code terminal:

```
cd deployments/prod/odoo-cloud/
terragrunt apply
```

When prompted, enter `yes` to start provisioning Odoo.

When provisioning completes, use your browser to navigate to `https://tulip.example.com/web` to confirm that Odoo is up and running.

To migrate data from your computer's instance of Odoo to your cloud instance of Odoo, follow the [documentation here](https://subscription.packtpub.com/book/big-data-and-business-intelligence/9781785883644/1/ch01lvl1sec12/managing-odoo-server-databases) to back up your computer's Odoo database, saving it as a zip file. Follow the same documentation to delete your cloud Odoo's existing database, then restore the database with the zip file you previously saved. The backup, delete, and restore database operations all require a "Master Password." Use the value of the `ODOO_PASSWORD` environment variable. On your computer, use `kubectl` to look it up as you did before. On the cloud, use the [Kubernetes Dashboard](https://docs.digitalocean.com/products/kubernetes/quickstart/#kubernetes-dashboard) to look it up.

## References

- [Odoo Installation Preparation](https://www.odoo.com/documentation/16.0/administration/install/install.html#setup-install-source-prepare)
- Cloudflare
  - [What is DNS?](https://www.cloudflare.com/learning/dns/what-is-dns/)
  - [How Cloudflare Works](https://developers.cloudflare.com/fundamentals/get-started/concepts/how-cloudflare-works/)
  - [Encryption All the Way](https://blog.cloudflare.com/universal-ssl-encryption-all-the-way-to-the-origin-for-free/)
  - [Origin CA Certificates](https://developers.cloudflare.com/ssl/origin-configuration/origin-ca/)
  - [DNS Proxy Status](https://developers.cloudflare.com/dns/manage-dns-records/reference/proxied-dns-records/)
- DigitalOcean
  - [How to Configure Advanced Load Balancer Settings in Kubernetes Clusters](https://docs.digitalocean.com/products/kubernetes/how-to/configure-load-balancers/)
  - [How to Manage SSL Certificates](https://docs.digitalocean.com/products/teams/how-to/manage-certificates/)
- Kubernetes
  - [Service](https://kubernetes.io/docs/concepts/services-networking/service/)
  - [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/)
  - [The Bitnami Library](https://github.com/bitnami/charts)
  - [Ingress annotation to customize max body size](https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/nginx-configuration/annotations.md#custom-max-body-size)
    - [nginx `client_max_body_size`](https://nginx.org/en/docs/http/ngx_http_core_module.html#client_max_body_size)
- Terraform
  - [TLS Provider](https://registry.terraform.io/providers/hashicorp/tls/latest/docs)
  - [Cloudflare Provider](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs)
  - [DigitalOcean Provider](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs)
  - [Helm Provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)
  - [Deploy Applications with the Helm Provider](https://developer.hashicorp.com/terraform/tutorials/use-case/helm-provider)
