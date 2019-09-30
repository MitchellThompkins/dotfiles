#Download vim-plug

#Set-up dotfiles directory and soft-links

echo "This will delete the current .gitconfig and .vim directory"
read -r -p "Are you sure? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
				echo ""
        ;;
    *)
				exit 1
        ;;
esac

DIR_VIM="$HOME/.vim"
if [ -d "${DIR_VIM}" ]; then
	rm ${DIR_VIM}
  echo "Removing .vim directory ${DIR_VIM}..."
else
	echo "${DIR_VIM} doesn't exist"
fi

DIR_GITCONFIG="$HOME/.gitconfig"
if [ -f "${DIR_GITCONFIG}" ]; then
	rm ${DIR_GITCONFIG}
  echo "Removing .gitconfig directory ${DIR_GITCONFIG}..."
else
	echo "${DIR_GITCONFIG} doesn't exist"
fi

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

git clone git@github.com:MitchellThompkins/dotfiles.git $HOME/dotfiles

ln -s $HOME/dotfiles/.vim $DIR_VIM
ln -s $HOME/dotfiles/.git_configurations/.gitconfig $DIR_GITCONFIG 
