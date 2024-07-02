#!/bin/bash

WORKDIR=/home/brandon/work
BUILDDIR=/home/brandon/quartus_projects

echo "Creating new FPGA HDL Project directory: $WORKDIR/$1/$2"

if [ -d $WORKDIR/$1/$2 ]; then
    echo "Directory already exists."
else
    mkdir -p $WORKDIR/$1/$2
fi

echo "Creating subdirectories..."

mkdir -p $WORKDIR/$1/$2/hdl
mkdir -p $WORKDIR/$1/$2/scripts
mkdir -p $WORKDIR/$1/$2/ip
mkdir -p $WORKDIR/$1/$2/software

# generate the parameters script file
touch $WORKDIR/$1/$2/scripts/parameters.sh
FILE=$WORKDIR/$1/$2/scripts/parameters.sh
/bin/cat << EOF >$FILE
#!/bin/bash
echo "Sourcing params.sh to environment"
ROOTDIR=$WORKDIR/$1
echo -e "ROOTDIR:\t \$ROOTDIR"
QUARTUS_DIR="/home/brandon/intelFPGA_pro/24.1/quartus/bin"
echo -e "QUARTUS_DIR:\t \$QUARTUS_DIR"
QSYS_DIR="/home/brandon/intelFPGA_pro/24.1/qsys/bin"
echo -e "QSYS_DIR:\t \$QSYS_DIR"
SYSCON_DIR="/home/brandon/intelFPGA_pro/24.1/syscon/bin"
echo -e "system console binary path:\t \$SYSCON_DIR"

############ PROJECT PARAMETERS ############
# Quartus PROJECT name
PROJ_NAME=$2
echo -e "Quartus Project Name:\t \$PROJ_NAME"

# project setup script name
SETUP_SCRIPT=project_setup.tcl
echo -e "Quartus Project build setup script:\t \$SETUP_SCRIPT"

QUARTUS_BUILD_DIR=$BUILDDIR/$1/$2
echo -e "Quartus Build Directory:\t \$QUARTUS_BUILD_DIR"

# source code directory
SOURCE_CODE_DIR=$WORKDIR/$1/$2
echo -e "HDL Source code directory:\t \$SOURCE_CODE_DIR"


# My custom RTL lib
COMMON_RTL_LIB=/home/brandon/work/hdl_sandbox/rtl_lib
echo -e "Common RTL library location:\t \$COMMON_RTL_LIB"
COMMON_TCL_LIB=/home/brandon/work/hdl_sandbox/tcl_lib
echo -e "Common TCL library location:\t \$COMMON_TCL_LIB"

# Define hardare targets 
HARDWARE_TARGET=NONE
echo -e "HARDWARE_TARGET:\t \$HARDWARE_TARGET"

# Quartus PFG Variables
SOF_DIR=\$QUARTUS_BUILD_DIR/output_files
echo -e "SOF_DIR:\t \$SOF_DIR"
DTB_FILE=/home/brandon/PON/u-boot-spl-dtb.hex
echo -e "DTB_FILE:\t \$DTB_FILE
EOF


# copy over project build and tcl scripts 
cp files2copy/run_project_setup.sh $WORKDIR/$1/$2/scripts/.
cp files2copy/project_setup.tcl $WORKDIR/$1/$2/scripts/.
cp files2copy/create_hps_sof.sh $WORKDIR/$1/$2/scripts/.

# create a top level system verilog file
touch $WORKDIR/$1/$2/hdl/system_top_level.sv 
FILE=$WORKDIR/$1/$2/hdl/system_top_level.sv
/bin/cat << EOF >$FILE
\`default_nettype none

module system_top_level ();

endmodule
EOF

# generate an sdc file
touch $WORKDIR/$1/$2/$2.sdc
