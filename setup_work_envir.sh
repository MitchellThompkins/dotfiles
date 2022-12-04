############### VIM & GIT CONFIGURATIONS ###############

# This takes arguments -e for an email and -n for the name
while getopts e:n: option
do
    case "${option}"
        in
        e) EMAIL=${OPTARG};;
        n) NAME=${OPTARG};;
    esac
done

DIR_DOT="$HOME/dotfiles/"
echo "This will delete the current vim and git configurations"
echo "This will delete any existing ${DIR_DOT}"
read -r -p "Are you sure you want to do this? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
        rm -rf ${DIR_DOT}
        mkdir -p ${DIR_DOT}
        echo ""
        ;;
    *)
        echo "Did nothing."
        exit 1
        ;;
esac

echo ""
# This portion setups the .gitconfigemail directory which the .gitconfig directory uses
DIR_GIT_EMAIL="$HOME/.gitconfigemail"
if [ -f "${DIR_GIT_EMAIL}" ]; then
    rm ${DIR_GIT_EMAIL}
    echo "Removing .gitconfig file ${DIR_GIT_EMAIL}..."
else
    echo "${DIR_GIT_EMAIL} doesn't exist"
fi

cat <<EOF >$HOME/.gitconfigemail
[user]
  email = ${EMAIL}
  name = ${NAME}
EOF

echo ""
# This portion deletes the .vim/ directory and links a new one
DIR_VIM="$HOME/.vim"
if [ -d "${DIR_VIM}" ]; then
    rm -rf ${DIR_VIM}
    echo "Removing .vim directory ${DIR_VIM}..."
else
    echo "${DIR_VIM} doesn't exist"
fi

echo ""
# This portion deletes the .vimrc file and links a new one
DIR_VIMRC="$HOME/.vimrc"
if [ -f "${DIR_VIMRC}" ]; then
    rm -rf ${DIR_VIMRC}
    echo "Removing .vimrc file ${DIR_VIMRC}..."
else
    echo "${DIR_VIMRC} doesn't exist"
fi

echo ""
# This portion deletes the .gitconfig file and links a new one
DIR_GITCONFIG="$HOME/.gitconfig"
if [ -f "${DIR_GITCONFIG}" ]; then
    rm -rf ${DIR_GITCONFIG}
    echo "Removing .gitconfig directory ${DIR_GITCONFIG}..."
else
    echo "${DIR_GITCONFIG} doesn't exist"
fi

############### CUSTROM RC ###############
echo ""
echo "Adding custom .rc"

rm -rf ${DIR_RC}
DIR_RC="$HOME/.dotfile_rc"
cmd_to_add_to_bashrc="\nif [ -f $HOME/.bashrc ]; then\n    . $HOME/.dotfile_rc\nfi\n"

# This is a simple check looking for the text dotfile_rc. Not very elegant but
# trying to search for the whole expanded string is harder
if grep -q "dotfile_rc" $HOME/.bashrc
then
    echo "./dotfile_rc already in .bashrc"
else
    echo "adding ./dotfile_rc to .bashrc"
    echo -e "${cmd_to_add_to_bashrc}" | tee -a $HOME/.bashrc > /dev/null
fi

echo ""
# This puts a fresh copy of all the contents we care about into the dotfiles dir
cp -r .bash_configurations/ $HOME/dotfiles/
cp -r .git_configurations/ $HOME/dotfiles/
cp -r .vim/ $HOME/dotfiles/

############### Set-up symlinks ###############
echo ""
ln -s $HOME/dotfiles/.vim ${DIR_VIM}
ln -s $HOME/dotfiles/.git_configurations/.gitconfig ${DIR_GITCONFIG}
ln -s $HOME/dotfiles/.bash_configurations/.rc ${DIR_RC}

############### PLUGIN SECTION ###############

echo ""
# This sets up the autoload/ directory
DIR_AUTOLOAD="$HOME/dotfiles/.vim/autoload/"
mkdir ${DIR_AUTOLOAD}
git clone https://github.com/junegunn/vim-plug.git ${DIR_AUTOLOAD}

# This creates all the plugins

DIR_PLUGIN="$HOME/dotfiles/.vim/plugged/"
mkdir ${DIR_PLUGIN}

echo ""
# A nice reminder to delete these files
echo "A dotfiles directory has been setup and configured. You should delete this directory now."
