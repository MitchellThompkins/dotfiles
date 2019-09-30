# This will set-up dotfiles directory and soft-links

# This takes arguments -e for an email and -n for the name
while getopts e:n: option
do
case "${option}"
in
e) EMAIL=${OPTARG};;
n) NAME=${OPTARG};;
esac
done

echo "This will delete the current vim and git configurations"
read -r -p "Are you sure you want to do this? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
				echo ""
        ;;
    *)
				exit 1
        ;;
esac

echo "\n"
# This portion setups the .gitconfigemail directory which the .gitconfig directory uses
DIR_GIT_EMAIL="$HOME/.gitconfigemail"
if [ -d "${DIR_GIT_EMAIL}" ]; then
  rm ${DIR_GIT_EMAIL}
  echo "Removing .gitconfig file ${DIR_GIT_EMAIL}..."
else
  echo "${DIR_GIT_EMAIL} doesn't exist"
fi

cat <<EOF >.gitconfigemail
[user]
  2   email = ${EMAIL}
  3   name = ${NAME}
EOF

echo "\n"
# This portion deletes the .vim/ directory and links a new one  
DIR_VIM="$HOME/.vim"
if [ -d "${DIR_VIM}" ]; then
	rm -rf ${DIR_VIM}
  echo "Removing .vim directory ${DIR_VIM}..."
else
	echo "${DIR_VIM} doesn't exist"
fi

echo "\n"
# This portion deletes the .vimrc file and links a new one  
DIR_VIMRC="$HOME/.vimrc"
if [ -f "${DIR_VIMRC}" ]; then
	rm -rf ${DIR_VIMRC}
  echo "Removing .vimrc file ${DIR_VIMRC}..."
else
	echo "${DIR_VIMRC} doesn't exist"
fi

echo "\n"
# This portion deletes the .gitconfig file and links a new one  
DIR_GITCONFIG="$HOME/.gitconfig"
if [ -f "${DIR_GITCONFIG}" ]; then
	rm -rf ${DIR_GITCONFIG}
  echo "Removing .gitconfig directory ${DIR_GITCONFIG}..."
else
	echo "${DIR_GITCONFIG} doesn't exist"
fi

echo "\n"
# This portion creates the dotfiles/ directory
DIR_DOT="$HOME/dotfiles/"
if [ ! -d "$DIR_DOT" ]; then
	mkdir $HOME/dotfiles 
  echo "Creating ${DIR_DOT}..."
else
	echo "${DIR_DOT} already exists, do you want to remove it?"
	read -r -p "Are you sure? [y/N] " response
	case "$response" in
 	   [yY][eE][sS]|[yY]) 
					rm -rf ${DIR_DOT}
    	    ;;
   	 *)
					exit 1
      	  ;;
	esac
fi

echo "\n"
# This clones a fresh copy into the newly created dotfiles directory
git clone git@github.com:MitchellThompkins/dotfiles.git $HOME/dotfiles

echo "\n"
# This sets up the autoload/ directory
DIR_AUTOLOAD="$HOME/dotfiles/.vim/autoload/"
mkdir ${DIR_AUTOLOAD}

git clone https://github.com/junegunn/vim-plug.git ${DIR_AUTOLOAD}

echo "\n"
# This portion sets up the soft links
ln -s $HOME/dotfiles/.vim ${DIR_VIM}
ln -s $HOME/dotfiles/.git_configurations/.gitconfig ${DIR_GITCONFIG}

echo "\n"
# A nice reminder to delete these files
echo "A dotfiles directory has been setup and configured. You should delete this directory now."
