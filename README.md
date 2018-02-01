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

Install, update, remove, and view information about your installed snaps. z

## Installation

first you will need to install elementary SDK

 `sudo apt install elementary-sdk`

### Dependencies

These dependencies must be present before building
 - `valac`
 - `gtk+-3.0`
 - `granite`

 You can install these on a Ubuntu-based system by executing this command:
 
 `sudo apt install valac libgtk-3-dev libgranite-dev`


### Building
```
mkdir build
cd build
sudo cmake -DCMAKE_INSTALL_PREFIX=/usr ../
make pot
sudo make
```


### Installing
`sudo make install`

