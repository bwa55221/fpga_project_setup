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

touch $WORKDIR/$1/$2/scripts/parameters.sh
FILE=$WORKDIR/$1/$2/scripts/parameters.sh
/bin/cat << EOF >$FILE
#!/bin/bash
echo "Sourcing params.sh to environment"
rootdir=$WORKDIR/$1
echo -e "rootdir:\t $rootdir"
quartus_dir="/home/brandon/intelFPGA_pro/24.1/quartus/bin"
echo -e "quartus_dir:\t $quartus_dir"
qsys_dir="/home/brandon/intelFPGA_pro/24.1/qsys/bin"
echo -e "qsys_dir:\t $qsys_dir"
syscon_dir="/home/brandon/intelFPGA_pro/24.1/syscon/bin"
echo -e "system console binary path:\t $syscon_dir"

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
EOF


cp run_project_setup.sh $WORKDIR/$1/$2/scripts/.
cp project_setup.tcl $WORKDIR/$1/$2/scripts/.