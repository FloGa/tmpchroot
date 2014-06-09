# Changes since latest release

-   Create /etc/debian_chroot for use with bash

    Most default bashrc show a special string like `(chroot-name)` with
    chroot-name being the content of /etc/debian_chroot. This way it's very
    easy to identify that you are inside a chroot.

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


-   Retry unmounts on error

    Try to unmount for 10 seconds, then give up and tell the user what they
    can do.

-   Show environment name on entering

# Changes in 0.1.0

Initial release
