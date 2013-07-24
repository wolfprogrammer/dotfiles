#--------------------- .bashrc -----------------------------#



# ----------  B A S I C   F E A T U R E S ------------------#

#Ten years of bash history 
HISTFILESIZE=1000000000
HISTSIZE=1000000         

#Autocorrection in shell
shopt -s cdspell

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ]; then
. /etc/bash_completion
fi
                          


# ========== V A R I A B L E S   &  S E T I N G S =============#


#--------------- S E T T I N G S -----------------#

# Add vim as default editor
export EDITOR=vim

# Set default web browser
if [ -n "$DISPLAY" ]; then
    BROWSER=firefox   # In x server
else 
    BROWSER=w3m	     # No x server
fi


# PATH variable
PATH=$PATH:$HOME/bin:$HOME/usr/bin:$HOME/.apps
PATH=$PATH:/opt/CodeSourcery/Sourcery_CodeBench_Lite_for_ARM_EABI/bin/

GPGKEY=4E4F15B4
alias pubkey='gpg --export -a $GPGKEY'

#--------------- A L I A S -----------------------#


#------- Quick Actions -------#

# Quick reload .bashrc
alias rl=' ~/.bash_profile'    

# Clear screen
alias c='clear'    

 #Back to old directory
alias b='cd $OLDPWD'
                          
#Go to parent directory
alias u='cd ..'
alias ..='cd ..'

alias h='history'


#------ Fast access ---------#
alias bashrc='gvim ~/.bashrc'
alias guidex='gvim ~/bin/guide.txt' # Edit guide.txt
alias home='cd ~/'
alias desk='cd ~/Desktop'
alias downl='cd ~/Downloads'
alias docs='cd ~/Documents'
alias box='cd ~/Dropbox'


# become root #
alias root='sudo -i'
alias su='sudo -i'   


# List files
#alias ls='ls --color=auto'    	   # List files collored
alias ls='ls -F --color --group-directories-first'    
alias l='ls' 			   # Quick listing
alias ll='ls -l'              	   # List files in details
alias la='ls -la'             	   # List hidden files
alias lsd='ls -ad */'         	   # List directories
alias lt='ls -ltr'            	   # List most recent files
alias l.='ls -d .* --color=auto'   # Show hidden files ## 
alias trls='tree -C | less -R'    

## set some other defaults ##
alias df='df -H'
alias du='du -ch'    

# Set color grep
#
alias grep='grep --color=auto'      
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'   
alias diff='colordiff'             # Needs to install collordiff package

# Make mount command output pretty and human readable format    
alias mount='mount |column -t'    

# Show help
alias guide='less ~/bin/guide.txt'
echo "Type:  guide  to see a command line guide"
echo "Type:  guidex edit the command line guide"

#  Print path variable
alias path='printf ${PATH//:/\\n}'   

# Print all bash variables
alias vars='env'


# Best SSH options for X11 forwarding    
alias ssh-x='ssh -c arcfour,blowfish-cbc -XC'    





#----- Network -----------#
#
alias myps='ps -fHu $USER'     # if not $USER, try $LOGIN
alias myports="netstat -lntp 2>/dev/null | grep -v ' - *$'"  # Linux only?    
alias ports='netstat -tulanp'    
alias lsock='sudo lsof -i -P'
alias ip='IP'

#----- Archive ----------#
# Creates an archive from given directory
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }    
mkzip() { zip -1 -9 -r "${1%%/}.zip" "${1%%/}/"; }

#---------------------------------
#  UBUNTU SPECIFIC COMMANDS
#
#---------------------------------
# Install package
alias install='sudo apt-get install'
# Search package
alias search='apt-cache search'
# Update repository database
alias update='sudo apt-get update'

alias rm='rm --interactive'

# Open file
alias open='xdg-open > /dev/null 2>&1'

# Launch dosbox  
# Usage: dosbox <file.com/file.exe>
alias dosbox='dosbox -c  "mount c `pwd`" -c  "KEYB br" -c "C:" -c "/mouse"'

 

# Create a simple http server to share folder
alias  https='hostname -I && python -m SimpleHTTPServer &'

alias today='date +"%A, %B %-d, %Y"'

# Set w3m browser home page
export HTTP_HOME="www.google.co.uk"    
alias browser='w3m -graph -cookie http://www.google.co.uk'



#-------------- F U N C T I O N S ----------------#


#-----------------------------------------#
#  capes
#
#  Open brazilian capes portal
#-----------------------------------------#
capes(){
echo "Portal da Capes com proxy:   user: Capes pass: Poli@Capes"	
chromium-browser --proxy-server=proxy.poli.br:3128 \
	"http://www.periodicos.capes.gov.br"
}



#------------------------------------------#
#  Custom prompt: 			   #
#					   #
#  user-name@host-name  ~/directory	   #
#  or					   #
#  ssh user-name@host-name ~/directory	   #
#------------------------------------------#

if [ -n "$SSH_CLIENT" ]; then text="ssh "

fi


function prompt
{
local WHITE="\[\033[1;37m\]"
local GREEN="\[\033[0;32m\]"
local CYAN="\[\033[0;36m\]"
local GRAY="\[\033[0;37m\]"
local BLUE="\[\033[0;34m\]"
local RED="\[\033[0;31m\]"
export PS1="
${text}${RED}\u${CYAN}@${BLUE}\h ${GREEN}\A ${CYAN}\w${GRAY}
$ "
}
prompt



#------------------------------------#
# Matrix()			     # 
#  				     #
# Matrix movie effects		     #
#------------------------------------#
matrix(){
(set -o noglob;while sleep 0.05;do for r in `grep -ao '[[:print:]]' /dev/urandom|head -$((COLUMNS/3))`;do [ $((RANDOM%6)) -le 1 ] && r=\ ;echo -ne "\e[$((RANDOM%7/-6+2));32m $r ";done;echo;done)    
}

#--------------------------------#
#  webcam()		 	 #
#				 #
#  Access computer webcam.	 #
#--------------------------------#
function webcam(){
mplayer tv:// -tv driver=v4l2:width=640:height=480:device=/dev/video0:fps=30:outfmt=yuy2
}






search_web() {
	search=""
	echo "Googling: $@"
	sleep 0.5
	ss1=$@" -ehow -wikihow"
	for term in $ss1; do
		search="$search%20$term"
	done

		w3m -graph -cookie "http://www.google.co.uk/search?q=$search"
}






 compact() {
     if [ "$#" -ge "1" ]; then
        case "$1" in
          *.[tT][aA][rR].[bB][zZ]|*.[tT][bB][zZ])
                  local file="$1"; shift; tar jcvf "$file" "$@" ;;
          *.[tT][aA][rR].[bB][zZ]2|*.[tT][bB][zZ]2)
                   local file="$1"; shift; tar jcvf "$file" "$@" ;;
          *.[tT][aA][rR].[gG][zZ]|*.[tT][gG][zZ]) 
                   local file="$1"; shift; tar zcvf "$file" "$@" ;;
          *.[gG][tT][gG][zZ]) 
                   local file="$1"; shift; tar zcvf "$file" "$@" ;;
          *[bB][zZ]2)                           
                   shift; bzip2 -z -k "$@"  ;;
          *.[rR][aA][rR])
                    local file="$1"; shift; rar a -r "$file"  "$@" ;;
          *[gG][zZ])                           
                     shift; gzip -r "$@"  ;;
          *.[tT][aA][rR]) 
                     local file="$1"; shift; tar cvf "$file" "$@" ;;
          *.[zZ][iI][pP])
                     local file="$1"; shift; zip -r "$file" "$@" ;;
          *.7[zZ])
                     local file="$1"; shift; 7z a -r "$file" "$@" ;;
          *.[xX][zZ]) 
                     local file="$1"; shift; tar Jcvf "$file" "$@" ;;
          *)    echo "don't know how to compact '$i' ..." ;;
        esac
      else
        echo "Insufficient arguments."
 fi ; }





extract () {
   if [ -f $1 ] ; then
       case $1 in
	*.tar.bz2)	tar xvjf $1 && cd $(basename "$1" .tar.bz2) ;;
	*.tar.gz)	tar xvzf $1 && cd $(basename "$1" .tar.gz) ;;
	*.tar.xz)	tar Jxvf $1 && cd $(basename "$1" .tar.xz) ;;
	*.bz2)		bunzip2 $1 && cd $(basename "$1" /bz2) ;;
	*.rar)		unrar x $1 && cd $(basename "$1" .rar) ;;
	*.gz)		gunzip $1 && cd $(basename "$1" .gz) ;;
	*.tar)		tar xvf $1 && cd $(basename "$1" .tar) ;;
	*.tbz2)		tar xvjf $1 && cd $(basename "$1" .tbz2) ;;
	*.tgz)		tar xvzf $1 && cd $(basename "$1" .tgz) ;;
	*.zip)		unzip $1 && cd $(basename "$1" .zip) ;;
	*.Z)		uncompress $1 && cd $(basename "$1" .Z) ;;
	*.7z)		7z x $1 && cd $(basename "$1" .7z) ;;
	*)		echo "don't know how to extract '$1'..." ;;
       esac
   else
       echo "'$1' is not a valid file!"
   fi
 }



# Monta imagem iso em /tmp com um nome iso-xxx
#
#	Uso:  argumento nome da image
#
function mntiso (){

mkdir -p /tmp/iso1
sudo mount -o loop $1 /tmp/iso1
cd /tmp/iso1
}
                    

#----------------------------------------#
#		Calculadora no bash
#
#
calc(){ awk "BEGIN{ print $* }" ;}   


 
#--------------------------------------#
#		Gera password/senha aleatório  #
alias genpass="< /dev/urandom tr -dc A-Za-z0-9_ | head -c21"      


#-----------------------------------#
#				    #
#	Get external IP address     #
#-----------------------------------#
function IP(){
echo "Hostname     :  "$(hostname -s) 
echo "Internal IP  :  "$(hostname -I)
echo "MAC address  :  "$(ifconfig wlan0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'  )
echo "Net Interface:  "$(/sbin/route -n | grep "^0.0.0.0" | rev | cut -d' ' -f1 | rev)
echo "Gateway  IP  :  "$(/sbin/ip route | awk '/default/ { print $3 }')
echo "External IP  :  "$(curl -s 'http://checkip.dyndns.org' | sed 's/.*Current IP Address: \([0-9\.]*\).*/\1/g'      )
echo "To see open ports enter : myports or ports"
echo "More info see: lsock "
}



## Send files to pastebin
function pastebin(){
	
	cat $1 | curl -F "sprunge=<-" http://sprunge.us | xclip
	xclip -o
}

#    xdg-open "http://www.google.com/search?q=$search"
google() {
    search=""
    echo "$1"
    for term in $*; do
        search="$search%20$term"
    done
#    xdg-open "http://www.google.com/search?q=$search"
    w3m  "http://www.google.co.uk/search?q=$search"
}                       


# Show the last 30 commands in graphical bar
alias zh='cmd= $(history 30 |cut -c 8-| zenity  --list --column History & )' 



 
# Copy file to make backup
# mneumonic file to backup
#
function f2b (){

	echo "Backup name $1-old"
	cp "$1" "$1-old"
}      

# Restore file backup
# mneumonic  backup to file
function b2f (){
	echo "Restored file $1"
	mv "$1-old" "$1"
}




#############################################################
#	Encripta arquivo com openssl
#
#	Uso:    $encrypt arquivo
#	saída:  arquivo.enc
#
encrypt(){
	openssl aes-256-cbc -a -salt -in $1 -out $1.enc
	echo "Remova o  arquivo original"
	echo "Mude o nome para algo menos sujestivo, nome atual  "
        #rm -rf $1
}


###########################################################
#      Desencript arquivo com o openssl
#      Uso:    $encrypt
#      Saída   arquivo.out
#
#

decrypt(){ 
	openssl aes-256-cbc -d -a -in $1 -out $1.out
	"Desencriptado, nome do arquivo "$1.out
}


##############################################
#        Edita banco de senhas de mdo seguro
# copia o arquivo ~/.bin/lepassmot.enc
# para /tmp e desencripta
#
editpass(){
	addrs=~/Dropbox/lepassmot.enc
	cp $addrs /tmp
	cd /tmp
	openssl aes-256-cbc -d -a -in lepassmot.enc  -out lepassmot.out
 	echo "Editando passwords em /tmp"
	leafpad lepassmot.out  & 

}


##################################
#	Faz update do banco de password
#  e encripta o arquivo
#
#
updatepass(){
	cd /tmp
	rm lepassmot.enc
	openssl aes-256-cbc -a -salt -in lepassmot.out -out lepassmot.enc
        cp lepassmot.enc ~/Dropbox
	echo "Operação finalizada disco encriptado movido para Dropbox"

}






#xhost local:caio > /dev/null
