<a href="https://gitlocalize.com/repo/4341"> <img src="https://gitlocalize.com/repo/4341/whole_project/badge.svg" /> </a>
<img src="https://travis-ci.org/bartzaalberg/snaptastic.svg?branch=master" />

# Archived
This repository is not maintained anymore and will not be updated to Elementary OS 6.0. You have my blessing to create a fork and update the application to post publish it in Elementary 6.0 under your own name. 

# Snaptastic
A snap manager for Elementary OS

<p align="center">
    <a href="https://appcenter.elementary.io/com.github.bartzaalberg.snaptastic">
        <img src="https://appcenter.elementary.io/badge.svg" alt="Get it on AppCenter">
    </a>
</p>

<p align="center">
    <img
    src="https://raw.githubusercontent.com/bartzaalberg/snaptastic/master/screenshot.png" />
</p>

Install, update, remove, and view information about your installed snaps.

## Installation

First you will need to install elementary SDK

 `sudo apt install elementary-sdk`

### Dependencies

These dependencies must be present before building
 - `valac`
 - `gtk+-3.0`
 - `granite`
 - `libsnapd-glib-dev`

 You can install these on a Ubuntu-based system by executing this command:

 `sudo apt install valac libgtk-3-dev libgranite-dev libsnapd-glib-dev`

### Building
```
meson build --prefix=/usr
cd build
ninja
```

### Installing
`sudo ninja install`

### Use snaps from browser
Run the following command to use snaps from browsers
`sudo update-desktop-database /usr/share/applications`

### Recompile the schema after installation
`sudo glib-compile-schemas /usr/share/glib-2.0/schemas`

### Update .pot file
Call the following command from the build folder:

`ninja com.github.bartzaalberg.snaptastic-pot`

## FAQ

### Snaptastic wont handle snap URLS

On Firefox you sometimes have to set the Application manually.

* Go to about:preferences#general
* Under applications search for snap and set the dropdown to 'Use Snaptastic'
