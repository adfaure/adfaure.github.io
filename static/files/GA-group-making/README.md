# Group making using Genetic Algorithm

This repositery contains all elements used to generate my 
[blog post](https://a-t-richard.github.io/blog/GA-group-making/)
on how to use a Genetic Algorithm to create homogeneous groups
of students.

## Quick-start

To easily reproduce the results of this experiment you must install 
[nix](https://nixos.org/nix/)

```bash
curl https://nixos.org/nix/install | sh
```

Nix will allow you to regenerate the results of my blog post,
with the extact same dependencies than I used, by entering the
following command:

```bash
nix-shell --command 'R -e "rmarkdown::render(\"GA-group-making.Rmd\")"'
```

If you simply want to plot our results, you can run the following command:

### Nix on Windows

Seriously?

Ok then, apparently nix can be used on windows by using the [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

But, seriously, use Linux.

### Running experiments without Nix

If Nix doesn't work, or you don't want to use it, you can use RStudio
instead.
But without the garanty to use the exact same dependencies than me.

## License

The source code of this experiment is under the
[Beerware License](https://people.freebsd.org/~phk/).

So, as long as you retain this notice you can do whatever you want
with this stuff.
If we meet some day, and you think this stuff is worth it, you can buy
me a beer in return.
