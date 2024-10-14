#==============================================================================
#     Build Macros
#==============================================================================

# Change directory to the configured Binutils version under "src"
BINUTILS_VER=`grep BIN_PATCH settings.cfg | sed -e 's/.*=//' -e 's/-tms9900.*//'`

# Change directory to the configured GCC version under "src"
GCC_VER=`grep GCC_PATCH settings.cfg | sed -e 's/.*=//' -e 's/-tms9900.*//'`

# Print the full path to the configured install directory 
INSTALL_DIR=$$(echo $$(A=`pwd`; cd $$(grep INSTALL_DIR settings.cfg | sed -e 's/.*=//'); pwd; cd $$A))


#==============================================================================
#     Build Recipies
#==============================================================================

# Configure, build and install everything
.PHONY: all
all: install_all
	@echo
	@echo "Build complete!"

# Erase all files which are created by the build
.PHONY: distclean
distclean:
	rm -f settings.cfg
	rm -rf archives install modified_files src

# Initialize the build environment. To do this, select the Binutils and GCC
# patches to use as well as the install directory. Then, find and expand needed
# source trees
.PHONY: init
init: settings.cfg
settings.cfg:
	./utils/initialize

# Create new patches for current source trees
.PHONY: patch
patch: init
	./utils/make_patch $(BINUTILS_VER)
	./utils/make_patch $(GCC_VER)

# Run configure in binutils directory. There is a quirk we must handle where
# the target name has changed in GCC-12.1.0 from "tms9900" to "tms9900-unknown"
.PHONY: configure_binutils
configure_binutils: init
	TARGET=tms9900-unknown; \
	if [ -z "`grep GCC settings.cfg | sed 's/.*4.4.0.*//'`" ]; then \
	  TARGET=tms9900; \
	fi; \
	PREFIX=$(INSTALL_DIR); \
	cd src/$(BINUTILS_VER); \
	if [ ! -f config.log ]; then \
	  ./configure --target $$TARGET --prefix=$$PREFIX --disable-build-warnings target_alias=tms9900; \
	fi

# Build the configured Binutils source tree
.PHONY: build_binutils
build_binutils: configure_binutils
	cd src/$(BINUTILS_VER); \
	make all

# Install the configured Binutils source tree
.PHONY: install_binutils
install_binutils: build_binutils
	cd src/$(BINUTILS_VER); \
	make install

# Confiure the GCC source tree and prepare for build
.PHONY: configure_gcc
configure_gcc: init
	PREFIX=$(INSTALL_DIR); \
	cd src/$(GCC_VER); \
	if [ ! -d build ]; then \
	  mkdir build; \
	  cd build; \
	  ../configure --target=tms9900 --prefix=$$PREFIX --enable-languages=c,c++ --enable-checking --disable-gcov; \
	fi

# Build the configured GCC source tree
.PHONY: build_gcc
build_gcc: configure_gcc
	cd src/$(GCC_VER)/build; \
	make all-gcc && \
	make all-target-libgcc

# Build the configured GCC source tree
.PHONY: install_gcc
install_gcc: build_gcc
	cd src/$(GCC_VER)/build; \
	make install-gcc && \
	make install-target-libgcc


# Configure the Binutils and GCC source trees
.PHONY: configure_all
configure_all: configure_binutils configure_gcc

# Build the Binutils and GCC source trees
.PHONY: build_all
build_all: build_binutils build_gcc

# Install the Binutils and GCC source trees
.PHONY: install_all
install_all: install_binutils install_gcc

# Display valid make targets
help:
	@echo Valid make targets:
	@grep ^.PHONY Makefile | sed 's/.*: */    /'

