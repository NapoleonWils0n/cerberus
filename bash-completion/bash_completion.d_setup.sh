#!/bin/bash

#|------------------------------------------------------------------------------
#|	bash_completion.d setup
#|------------------------------------------------------------------------------

# create /etc/bash_completion.d directory 
mkdir -p /etc/bash_completion.d

# place completion files in /etc/bash_completion.d/

# reload bash completion file
. /etc/bash_completion.d/filename

# example completion file

_VBoxManage() 
{
    local cur prev opts base
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    #
    #  The basic options we'll complete.
    #
    opts="startvm controlvm savestate"


    #
    #  Complete the arguments to some of the basic commands.
    #
    case "${prev}" in
	startvm)
        local vmlist=$(for x in `VBoxManage list vms | awk '{print $1}' | sed 's/\"//g'`; do echo ${x} ; done )
	    COMPREPLY=( $(compgen -W "${vmlist}" -- ${cur}) )
            return 0
            ;;
    controlvm)
        local runningvms=$(for x in `VBoxManage list runningvms | awk '{print $1}' | sed 's/\"//g'`; do echo ${x} ; done )
        COMPREPLY=( $(compgen -W "${runningvms}" -- ${cur}) )
            return 0
            ;;
    savestate)
        COMPREPLY=( $(compgen -f ${cur}) )
            return 0
            ;;
        *)
        ;;
    esac

   COMPREPLY=($(compgen -W "${opts}" -- ${cur}))  
   return 0
}
complete -F _VBoxManage VBoxManage