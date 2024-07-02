#!/bin/bash
echo "Sourcing params.sh"
source parameters.sh

if [ ! -d "$QUARTUS_BUILD_DIR" ]; then
    mkdir -p "$QUARTUS_BUILD_DIR"
    echo "Directory '$QUARTUS_BUILD_DIR' created."
else
  echo "Directory '$QUARTUS_BUILD_DIR' already exists."
fi

# echo "Creating specific project directory: $QUARTUS_BUILD_DIR/$PROJ_NAME"
# mkdir $QUARTUS_BUILD_DIR/$PROJ_NAME

echo "Copying params file to the new project directory"
cp parameters.sh $QUARTUS_BUILD_DIR/.

cd $QUARTUS_BUILD_DIR

echo "Executing setup script: $SETUP_SCRIPT"
$quartus_dir/quartus_sh -t $SOURCE_CODE_DIR/scripts/$SETUP_SCRIPT

# echo "Generating QSYS components..."
# $qsys_dir/qsys-generate --synthesis=VERILOG --quartus-project=$PROJ_NAME.qpf ${SOURCE_CODE_DIR}/synthesis/pcie_sys.qsys
# echo "QSYS component generation complete."

echo ""
echo ""
echo ""
echo ""

echo "Opening newly created Quartus Project"
$quartus_dir/quartus $PROJ_NAME.qpf