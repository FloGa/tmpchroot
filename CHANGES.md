# Changes since latest release

# Changes in 0.3.3

-   Fix yet another bug with mounting home

    Instead of reading variables, that may or may not be correctly set, I now
    check whether the home snapshot is listed as a subvolume.

# Changes in 0.3.2

-   Restore umount retry feature

    I removed that feature with the last update, thinking I wouldn't need it
    anymore, but I was wrong. So, here it is again!

# Changes in 0.3.1

-   Fix wrong unmount behavior

    I accidently used a variable to decide whether to unmount the home
    partition. In some situations, this variable is not set but home was
    mounted anyway.

    Now a recursive unmount is used to unmount everything under the new root
    directory.

# Changes in 0.3.0

-   Create /etc/debian_chroot for use with bash

    Most default bashrc show a special string like `(chroot-name)` with
    chroot-name being the content of /etc/debian_chroot. This way it's very
    easy to identify that you are inside a chroot.

-   Reduce number of bind mounts

    Some of the mounts tear open holes to the actual system. To prevent that,
    I removed some of them.

-   Add -m flag to realpath

    The -m flag gets realpath to print out the canonical path, even if the
    directory does not exist.

-   Kill processes before unmounting

    Sometimes there are background processes wich prevent a clean unmount.
    Since the environment is a temporal playground in the first place, those
    processes can safely be killed.

-   Mount home partition again

    Due to a silly mistake the home partition was not mounted for some time
    now. Fixed that.

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
