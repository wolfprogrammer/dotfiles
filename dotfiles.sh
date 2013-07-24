#!/bin/bash
#
# ----------------  dotfile.sh ----------------------------
#  
#  Author: Caio Rodrigues
#  Short Descr: Backup system dotfiles
#
#  Description: This simple script copies all dotfiles (.something )
#               in the HOME directory to the folder where is this
#		script is being executed.
#
#  Usage example:  
#		cd directory
#		./dotfiles 
#
#
############################################################
# List of files to be tracked without the dot
#


files=" bashrc bash_profile vim vimrc gvimrc gEDA dia pcb w3m \
	gitconfig"


for FILE in $files ;
do
	cp -r -u -p -v "$HOME"/".$FILE"  "$FILE"
done	
 
