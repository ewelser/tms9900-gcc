# TMS9900 Toolchain Build Infrastructure

This project automates as much of the TMS9900 toolchain build and install process as well as patch management. It is intended to be as easy to use as possible.

This repo uses GNU Binutils and the GNU Compiler Collection (GCC) to produce a toolchain which is capable of producing code for devices using the TMS9900 processor. The most common usage of this processor is for the TI-99/4A home computer.

The devellopment log for all my TI-99/4A related work can be found [here](http://insomnialabs.blogspot.com)

## Requirements

The host environment, in which the toolchain will be built and run, must be POSIX-compliant. any of the following should work:

- BASH Shell
- Windows Services for Linux
- Cygwin
- MacOS
- Any flavor of BSD

In addition to this, the following items must first be installed:

- GCC compiler
- GNU make
- libgmp-dev library
- libmpfr-dev library

Assuming that your environment uses `apt`, this software can me installed with this command:

> sudo apt install build-essential libgmp-dev libmpfr-dev

## How To Download 

To download the repo, issue this command:

> git clone github.com/ewelser/tms9900-toolchain.git

## How To Build and Install a Toolchain
One installed, use these commands to build a toolchain:

> cd tms9900-toolchain

> make

You will then be asked to specify the Binutils and GCC patch used to build the toolchain as well as the directory in which to install the toolchain.

By default, the latest patches and a new subdirectory `./install` will be suggested. Responding with a blank line at a prompt will select the default value. Otherwise, the user-provided value will be used.


## For Developers

The source trees under `./src` will be used to build the toolchain. These files may be freely modified. To build a toolchain with your motifications, use this command:

> make install_all

To make a new patch including your modification, use this command:

> make patch

For additional information, refer to [./doc/toolchain-builder.txt](https://github.com/ewelser/tms9900-toolchain/doc/toolchain-builder.txt)


## Acknowledgements

All patches are built on the source code for [Binutils](https://www.gnu.org/software/binutils) and [GCC](https://gcc.gnu.org). You can follow the links for more information on them.

Many thanks to the members of the members of the [AtariAge TI forums](https://forums.atariage.com/forum/119-ti-994a-development) for their tireless testing and generous feedback.

A special thank you goes out to [mburkley](https://github.com/mburkley) who has picked up management of the Binutils 2.19.1 and GCC 4.4.0 patches [here](https://github.com/mburkley/tms9900-gcc) after I dropped the ball on them.

