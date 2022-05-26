#!/bin/sh
##----------------------------------------------
# This Script is used to build the BSP and 
# the O-RU Software, If Software is not 
# Linked to Build Environment then this 
# Script helps in downloading the Software 
# and linking to the Build Environment
# and starts its compilation
##---------------------------------------------

if [ -d ${PWD}/ZCU48DR_BSP ];then
	echo "BSP is Available in current directory"
else
	echo "Downloading the BSP"
	git clone https://github.com/anilkogilathotha/ZCU48DR_BSP.git
fi

if [ -d ${PWD}/ZCU48DR_BSP/project-spec/meta-user/recipes-apps ];then
       	echo "Software is available... Started Building the Software"
       	cd ${PWD}/ZCU48DR_BSP
	echo "$PWD"
       	source ~/Petalinux_2021_2/settings.sh	
       	sleep 2
	petalinux-build  
else
	echo "Software is not available"
       	if [ -d ${PWD}/stl-oru-sw ];then
		echo "Software Downloaded Successfully... Started linking to Xilinx Build setup"
		ln -s ${PWD}/stl-oru-sw ${PWD}/ZCU48DR_BSP/project-spec/meta-user/recipes-apps
		RET_VAL=$?
		if [ $RET_VAL ];then
			echo "Successfully linked software with Xilinx Build Environment"
		else
			echo "Failed to link software with Xilinx Build Environment"
		fi
       else
	       	echo "Downloading the Software"
	       	git clone https://github.com/anilkogilathotha/stl-oru-sw.git
       	fi
	cd ${PWD}/ZCU48DR_BSP
	echo "$PWD"
	source ~/Petalinux_2021_2/settings.sh	
	sleep 2
	petalinux-build
       	cd -	
fi       
