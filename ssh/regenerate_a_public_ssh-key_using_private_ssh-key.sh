#!/bin/sh

# =====================================================
# = REGENERATE A PUBLIC SSH-KEY USING PRIVATE SSH-KEY =
# =====================================================


ssh-keygen -y -f id_rsa > id_rsa.pub