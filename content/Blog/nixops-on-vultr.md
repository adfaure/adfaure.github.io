+++
title = "Nixops on Vultr"
date = 2018-10-23
description = """This post describes how to set up a NixOS on vultr, and manage the instance
with nixops."""
tags = ["nixOS", "nixops"]
categories = ["nixOS", "nixops"]
featured = false
+++

## Summary

**Requirements:**

- A machine Linux with root access.
- A vultr account (with money to spend <i class="fas fa-credit-card" aria-hidden="true"></i>)
- Basic knowledge with linux administration tools (ssh, bash)

## Introduction

[**NixOS**](https://nixOS.org) is a Linux distribution based on the functional
package manager Nix. It benefits from the full  potential of
[**Nix**](https://nixOS.org/nix/) and allows to statically describe your OS and
its packages, configuring services and rolling back to previous configurations.
**Nixops** is a tool that allows to describe, configure and manage a set of
NixOS machines using the nix language. Nixops benefits from nix and NixOS
properties and extends it to a network management.

This post describe how to start using nixops on a virtual machine. I choose
vultr as cloud provider because it proposes to boot a VM with an ISO. And NixOS
is one of the ISO available, which facilitate the installation.  Most of this
post should, however, be compatible with other cloud provider.

At the end of this article, one have a running virtual machine with NixOS
installed and configured by nixops. The virtual machine can be deployed and
configured with nixops. The final installation is the article is directly taken
from the official [documentation](https://nixOS.org/nixops/manual/). At the end
you should have unleashed the power of **nix{,os,ops}**, and be able to
configure and deploy your own nixops instance to fit your needs

## Deploy a Virtual Machine and Install NixOS

The first step, straightforward, is to create an account on Vultr, and to run
your first VM instance.  Note that the this post uses a VM of a minimum of 1GB
of memory, and I had issues to do the installation with less than 1GB of ram.

Once the VM is running, we can just access to the running instance in order to
install NixOS.  Vultr proposes from its dashboard to access to the instance with
a web console.  For my part I found it more convenient to change ---
**temporarily** --- the root password and access to the machine with ssh.  you
may also need to run the ssh server on the VM: `systemctl start sshd`.

In this post, I will not describe how to install NixOS.  The official
[manual](https://nixOS.org/nixOS/manual/) of NixOS is complete and I could not
add any additional useful information. In addition the
[documentation](https://www.vultr.com/docs/install-nixOS-on-vultr) of Vultr also
describes the full procedure.

When the installation is finished, I **recommend** to create a snapshot of your
installation.  It will allow to restore NixOS and prevent from reiterate the
whole installation in case of failure.

## Nix{os,ops}

Now that we a running virtual machine with a NixOS installation, we can start
working with nix.  Nix is very easy to install, to install it on your local
computer: `curl https://nixOS.org/nix/install | sh`.  Don't forget to read the
end of the installation, you may have to source a file ;)

Then using the fresh installation, we can directly install Nixops: `nix-env -iA
nixpkgs.nixops`

Nixops is a tool that allows you to statically describe the services running on a
machine, or a set of machine, and connect them together.
The strong point of using Nixops is that we can benefits from all the good
properties of the Nix package manager and NixOS.

Using Nixops is simple, start by creating a file called
`configuration-vultr.nix`, and add the following content.

```nix

int main() {}

{
  network.description = "Web server";

  webserver =
    { config, pkgs, ... }:
    {
      imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
      ];

      services.httpd.enable = true;
      services.httpd.adminAddr = "alice@example.org";
      services.httpd.documentRoot = "${pkgs.valgrind.doc}/share/doc/valgrind/html";
      networking.firewall.allowedTCPPorts = [ 80 ];
    };
}
```

This is example is directly taken from the official Nixops documentation. It
defines a machines that enable the httpd service to serve the content of the
valgrind documentation.  If you are familiar with nix, you can notice that
`documentRoot` is pointing on a derivation.  The derivation will be built and
translated to the path of the output `doc` of the derivation on the store.  This
example remains simple as it only deploy a service. However we can already see
that we can reference nix packages in the source code of the network, which is a
powerful feature.

The next file nixops will require to deploy your virtual machine is the hardware
definition of the VM. The easiest way to obtain this file is to take it directly
from the VM. Normally, if you already installed nixOS, you had to use the
command `nixOS-generate-config --root /mnt`, which generate two files. The first
one is the `/etc/nixOS/configuration.nix`, which is not required because nixops
will overwrite it with our previous file. The second file, however is the file
`/etc/nixOS/hardware-configuration.nix`, which describe the device that contains
your installation. We can download it, and put it next to the previous one.
Now, your folder should have the following files:

```bash
$cd nixops-kodama/
ls -l

configuration.nix
hardware-configuration.nix
```

At this point, the machine is configured to run a http service, however we need
to tell to NixOS where to find our virtual machine. We just need to add the
following line to the file `configuration.nix`.

```nix
deployement.targetHost = "1.2.3.4";
```

The next modification we need to apply, is to enable the ssh server on our
configuration. Otherwise, the virtual machine will be inaccessible after the
first deployment. Luckily, we are using Nix, nothing is more simple than adding
a new service. Adding the following line will do the trick:

```nix
services.openssh.enable = "yes";
```
At this point, the configuration file should look like:

```nix
{
  network.description = "Web server";

  webserver =
    { config, pkgs, ... }:
    {
      imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
      ];

      deployement.targetHost = "1.2.3.4";
      services.openssh.enable = "yes";

      services.httpd.enable = true;
      services.httpd.adminAddr = "alice@example.org";
      services.httpd.documentRoot = "${pkgs.valgrind.doc}/share/doc/valgrind/html";
      networking.firewall.allowedTCPPorts = [ 80 ];
    };
}
```

Now, that we configured our server, we can start to create a Nixops state.
We need to run the command:
```
nixops create /path/to/configuration.nix -d vmv
```

This command will create the new state for our vm, but it will not trigger the
installation yet.  Note that the argument `-d vmv` creates an alias for your
state.

We can directly check if Nixops created our instance state.
```
$nixops list
+-------------+--------+-----------------+------------+------------+
| UUID        | Name   | Description     | # Machines |    Type    |
+-------------+--------+-----------------+------------+------------+
| 7d7f8859-d8 | vmv    | Web server      |          1 |    none    |
+-------------+--------+-----------------+------------+------------+
```

Finally, to deploy the instance we need to run the command:
```
nixops deploy -d vmv
```

### Running Out of Space

It seems that the version of nixops delivered by the channel 18.09, has memory
management issues with machines with a small amount of memory.  In my case, for
a VM with 1024M of memory I had trouble deploying the virtual machine with
nixops.  The error was:
```
vps.......> error: out of memory
vps.......> error: unexpected end-of-file
```

A simple workaround is to create a swapfile for your virtual machine.  The
following article describe this procedures:
[linux-add-a-swap-file-howto](https://www.cyberciti.biz/faq/linux-add-a-swap-file-howto/).
One can access to the virtaul machine for creating and activating the swap
file..

And you are ready to go: `nixops deploy -d vmv`.

However note that if you restart the machine, the swap file will not be
activated. To make it activated, one can add the following lines to your `hardware-configuration.nix`.

```nix
swapDevices =
  [ { device = "/swapfile1"; size = 1024; }
];
```

Tada, you should be able to access to the valgrind documentation,
at the address http://1.2.3.4/.

## Refs

- How to install nixOS on a vultr vm instance: https://www.vultr.com/docs/install-nixOS-on-vultr
- Create a swapfile: https://www.cyberciti.biz/faq/linux-add-a-swap-file-howto/
- The official nixOS documentation: https://nixOS.org/nixOS/manual/
- The official nixops documentation: https://nixOS.org/nixops/manual/
