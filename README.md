# FPGA Project Setup

This project contatins setup script ```setup_new_project.sh``` that can be used to instantiate a new RTL project.

Usage: ``` ./setup_new_project.sh <top level directory> <project directory> ```
Example: ``` ./setup_new_project.sh /home/brandon/fpga_projects some_test_project_name```

The setup script copies TCL scripts that can be used to build a Quartus project for compilation and hardware synthesis. The setup script also creates a file called ```parameters.sh``` that is used to store 
defines and other build information. 