# Changes in 0.2.0

-   Simplify test command

-   Replace binary deblock with perl call

-   Process options first before running main routine

-   Add support for a command to run

-   Replace hardcoded device path with a searched one

-   Only mount /home if present

-   Move deblock to tearDown

-   Use chroot if nspawn not present

-   Use variables as subvolume names

-   Optimize unmount routine

    Check whether the directory in question is even mounted before trying to
    unmount it.

-   Ensure root user

-   Deprecate nspawn support

    Due to a update, systemd-nspawn seems to have stopped working. Therefore I
    decided to not longer depend on systemd but instead optimize good old
    chroot.

# Changes in 0.1.0

Initial release
