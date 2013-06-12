#!/bin/bash

# VirtualBox command line

#|------------------------------------------------------------------------------
#|	start virtual machine from the command line
#|------------------------------------------------------------------------------

VBoxManage startvm virtualMachineName

# eg
VBoxManage startvm debian

#|------------------------------------------------------------------------------
#|	list virtual machnes
#|------------------------------------------------------------------------------

VBoxManage list vms

#|------------------------------------------------------------------------------
#| Pause and resume the virtual machine
#|------------------------------------------------------------------------------

# pause the virtual machine
VBoxManage controlvm virtualMachineName pause

#eg
VBoxManage controlvm debian pause

# resume the virtual machine
VBoxManage controlvm virtualMachineName resume

# eg
VBoxManage controlvm debian pause


#|------------------------------------------------------------------------------
#| Save the virtual machine
#|------------------------------------------------------------------------------

VBoxManage controlvm virtualMachineName savestate

# eg
VBoxManage controlvm debian savestate