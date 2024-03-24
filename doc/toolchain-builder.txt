TMS9900 toolchain build infrastructure

1) PURPOSE

  The purpose of this infrastructure is to automate as much of the toolchain
  build and installation process as is possible. The user is asked only three
  questions, and the rest of the process is handled automatically.

2) USAGE
  All commands are issued from the "tms9900-toolchain" directory.

  2.1) $ make distclean
    This command will delete all files and directories returning the
    environment to its state when initially downloaded. Only the items listed
    below will be preserved:

      - Makefile
      - patchfiles
      - utils
      - README.TXT
      - All files under "patchfiles"
      - All files under "utils"

  2.2) $ make
    This command will start a build of the toolchain executables. Three
    questions will be asked of the user as part of this action, after which the
    build and install process will take place. The questions asked are listed
    below.

    2.2.1) "Specify Binutils patch (default: ...)"
      The user is asked to specify a file in the "patchfiles" directory to
      apply to the Binutils source tree. If this question is left blank, the
      default file will be used. The default is chosen to be the latest patch
      for the latest version of Binutils.

    2.2.1) "Specify GCC patch (default: ...)"
      The user is asked to specify a file in the "patchfiles" directory to
      apply to the GCC source tree. If this question is left blank, the default
      file will be used. The default is chosen to be the latest patch for the
      latest version of Binutils.

    2.2.1) "Specify installation directory (default: ./install)"
      The user is asked to specify a directory into which all toolchain
      executables will be installed. If this question is left blank, the
      default directory will be used. The default is chosen to be the "install"
      subdirectory.

  2.3) $ make patch
    This command will compare all files under "src" with their unmodified
    counterparts and create a patchfile for the changes. These patchfile
    will be placed in the "patchfile" directory. The minor patch number will be
    automatically incremented from the most recent patch for the apropriate
    source trees.

    For example, if the latest patch number is 1.2, the incremented value
    will be 1.3

3) DIRECTORY TREE LAYOUT

  |-- archives
  |-- install
  |-- Makefile
  |-- modified_files
  |   |-- binutils-*
  |   '-- gcc-*
  |-- patchfiles
  |-- src
  |   |-- binutils-*
  |   '-- gcc-*
  '-- utils

  3.1) archives
    This directory holds copies of the unmodified source code downloaded from
    the internet. It is created as part of a build.

  3.2) install
    This is the default installation directory for toolchain executables made
    by the build. It is only created if needed.

  3.3) modified_files
    This directory holds complete copies of all files modified by the selected
    patchfiles. There are seperate directories for the Binutils and GCC source
    trees. It is created as part of a build.

  3.4) patchfiles
    This directory holds all valid patchfiles which can be used to build a
    working toolchain for a TMS9900 target. Any created patchfiles will be
    placed here. It is always present.

  3.5) src
    This directory holds the patched source files needed to build a toolchain.
    There are seperate directories for the Binutils and GCC source trees. It
    is created as part of a build.

  3.6) utils
    This directory holds scripts used as part of the build process. It is
    always present.

4) SPECIAL FILES

  4.1) Makefile
    This file drives the build process and facilitates many commands. It is
    always present.

  4.2) README.TXT
    This file. It is always present.

  4.2) settings.cfg
    This file holds name-value pairs to record the patches and install
    directory selected during initialization. It is created as part of a build.

  4.3) src/applied_patches.txt
    This file lists all patches which are applied to source trees in the "src"
    directory. It is created as part of a build.

