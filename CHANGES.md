# Changes since latest release

# Changes in 0.9.0

-   Use subroutine to delete ROOT snapshot

    Avoids duplication of removal logic.

-   Use recursive snapshots

    This expects one of my other scripts, btrfs-recursive-snapshot to be in
    the PATH.

-   Introduce config file

    This is a quick fix for when the default values of $maint and $envdir
    are not correct on the current system. Therefore, those two variables
    can be pre-defined in a user config file, namely /etc/tmpchroot.conf.

# Changes in 0.8.0

-   Use login shell with proper quoting

    If a command with arguments is given, write those to a file, each
    argument surrounded by single quotes to ensure proper variable quoting.
    Then call this file with a login bash.

    The login bash is necessary to source ~/.profile and other rc-files that
    might define custom directories for the PATH variable.

-   Remove deprecated nspawn support

-   Add create-or-continue convenience command

    Sometimes there are situations, where one wants to create a container,
    maybe "pause" it for some time and then continue it. Now it is possible
    with the same command. "create-or-continue" creates a new container if
    not existent yet, and continues it otherwise.

-   Add layman folder to bind mounts

    Since the layman folder is quite as essential to the system as the
    portage tree, add it to the bind mounts.

# Changes in 0.7.0

-   Bind mount /usr/portage

    In some setups, /usr/portage is just a mount itself, means it won't be
    snapshot along with /. The bind mount assures it is there no matter
    what.

-   Re-factor conditional mount and delete

-   Add support for top level subvolumes

-   Add bash completion

# Changes in 0.6.2

-   Mount filesystems outside of chroot

    That is a lot faster than to do it inside the container.

-   Wait a bit after terminating before killing tasks

    Some tasks need their time to cleanly shut down after receiving SIGTERM.

# Changes in 0.6.1

-   Create /var/run/utmp

    This file keeps track of logins to the system and is needed by some
    programs, for example screen.

-   Improve random port allocation

    The delay between finding an unused port and starting the ssh server may
    cause multiple servers using the same port.

    Now, on each iteration a random port is picked and tested until a free
    one is found.

# Changes in 0.6.0

-   Force creation of symlink in case rm fails

    If mounting of /dev takes longer then execution of rm, then a warning
    like "symlink already exists" may appear. The -f flag of ln takes care
    of that and tries to delete the file once more.

-   Add deprecation comment for nspawn

-   Replace some bind mounts with real ones

    To provide more isolation, re-create some mounts inside the container
    instead of bind mounting from outside. Also, add some tmpfs mounts.

-   Move deblock call

    The deblock is only needed due to a bug in nspawn, so call it directly
    after nspawn. Since this is deprecated anyway, it should'nt make any
    difference, except for one less useless call when using chroot.

# Changes in 0.5.2

-   Sync after mounting /dev/pts

    If the processor is too slow, it may be that the mounting takes a bit
    longer than the mount command per se. So any commands afterwards may not
    see the mounted file systems.

    Sync forces to flush all cached operations such as mounting before going
    on.

# Changes in 0.5.1

-   Force tty allocation

    When running ssh with a command argument, then no TTY is allocated. This
    prevents certain programs to work properly. The ssh flag -t forces
    allocation of such a TTY.

# Changes in 0.5.0

-   Do not automount/-unmount btrfs-maint

    After several experiments, it seems like it is generally a bad idea to
    always mount and unmount the maint-volume for just a few seconds. So I
    just assume that it is mounted and leave the rest to the user.

-   Sync after unmounting

    Sometimes the unmounting happens not immediately, as in it is not
    written to disk but just in the memory. That leads to errors when trying
    to delete the unmounted directory, since it since not to be empty.

    Syncing ensures that the unmounting finished completely.

-   Nicer killing strategy

    As absurd as it sounds, there really is a nicer way of killing processes
    than just 9-ing them (SIGKILL). First, try to 15-ing them (SIGTERM) and
    afterwards slaughter the more resistant processes as usual with -9.

-   Use SSH to connect to container

    There are many problems with using terminals directly in the chroot
    shell. It is generally more flexible to start a local sshd server inside
    the container and connect with ssh client.

-   Create new mounts to kernel file systems

    The so-called "best practice" of bind mounting every kernel file system
    like /proc, /sys, /dev, and especially /dev/pts can hurt and even break
    the complete environment, not just one container.

    Creating new instances of those file systems inside the container solves
    this issue.

# Changes in 0.4.0

-   Remove home snapshot only if existent

-   Add option --nohome for not snapshotting home

    Naturally, home will not be mounted afterwards.

-   Re-write parameter parsing

    Do not use another array for that, but process them directly. The
    additional array yielded strange behaviors and errors.

-   Add support for -n flag

    With this option, tmpchroot will not remove snapshots and also will not
    ask for that.

# Changes in 0.3.3

-   Fix yet another bug with mounting home

    Instead of reading variables, that may or may not be correctly set, I
    now check whether the home snapshot is listed as a subvolume.

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

    Some of the mounts tear open holes to the actual system. To prevent
    that, I removed some of them.

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

    Due to a update, systemd-nspawn seems to have stopped working. Therefore
    I decided to not longer depend on systemd but instead optimize good old
    chroot.


-   Retry unmounts on error

    Try to unmount for 10 seconds, then give up and tell the user what they
    can do.

-   Show environment name on entering

# Changes in 0.1.0

Initial release
