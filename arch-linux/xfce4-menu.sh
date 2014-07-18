#!/bin/bash

# customze the xfce4 menu
#========================

# create the ~/.config/menus directory
mkdir -p ~/.config/menus

# change directory into new directory
cd !$

# ~/.config/menus/xfce-applications.menu
vim xfce-applications.menu

# paste in the following


<!DOCTYPE Menu PUBLIC "-//freedesktop//DTD Menu 1.0//EN"
  "http://www.freedesktop.org/standards/menu-spec/1.0/menu.dtd">

<Menu>
    <Name>Xfce</Name>
    <MergeFile type="parent">/etc/xdg/menus/xfce-applications.menu</MergeFile>

    <Exclude>
        <Filename>xfce4-run.desktop</Filename>
        <Filename>exo-mail-reader.desktop</Filename>
        <Filename>xfce4-about.desktop</Filename>
        <Filename>xfhelp4.desktop</Filename>
    </Exclude>

    <Layout>
        <Merge type="all"/>
        <Separator/>

        <Menuname>Settings</Menuname>
        <Separator/>

        <Filename>xfce4-session-logout.desktop</Filename>
    </Layout>

</Menu>
