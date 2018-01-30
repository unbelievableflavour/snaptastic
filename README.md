# Snaptastic
Manage your snap applications

<p align="center">
    <img 
    src="https://raw.githubusercontent.com/bartzaalberg/snaptastic/master/screenshot.png" />
</p>

### Simple App for elementary OS

A Vala application to get manage your snaps in a way everybody can understand

## Installation

As first you need elementary SDK

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

### Testing

You can run the tests by going to the test dir:

`/src/Tests/tests.sh`

And then running the test script.

`./tests.sh`
