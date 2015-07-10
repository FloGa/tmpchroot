#!/bin/bash

_tmpchroot() {
    local cur prev words cword
    _init_completion || return

    local cmds opts
    cmds="list create continue delete test"
    opts="-y -n --subvol-root --subvol-home --nspawn --nohome"

    if [[ "${words[*]}" = *" -- "* ]]; then
        local i
        for (( i=1; i <= COMP_CWORD; i++ )); do
            if [ "${words[$i]}" = "--" ]; then
                _command_offset $(($i + 1))
                return
            fi
        done
    fi

    local c=$(($cword - 1)) completions="=^)"
    while [ $c -gt 0 ]; do
        case "${words[$c]}" in
            list | create | test)
                return 0
                ;;
            continue)
                if [ $(($cword - $c)) = 1 ]; then
                    completions="$(ls /mnt/btrfs/chroot)"
                else
                    return 0
                fi
                ;;
            delete)
                completions="$(ls /mnt/btrfs/chroot)"
                ;;
            --subvol-*)
                if [ $(($cword - $c)) = 1 ]; then
                    _cd
                    return 0
                fi
                ;;
        esac

        [ "$completions" != "=^)" ] && break

        ((c--))
    done

    [ "$completions" = "=^)" ] && completions="$cmds $opts"

    COMPREPLY=( $( compgen -W "$completions" -- $cur ) )

    return 0
}
complete -F _tmpchroot tmpchroot
