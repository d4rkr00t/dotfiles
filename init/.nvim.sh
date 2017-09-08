CONFIG=$( cd ~/.config/ && pwd )
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )

echo ""
echo "Setup neovim"

cd $CONFIG
mkdir nvim 2> /dev/null

ln -sfF $DIR/link/.nvimrc $CONFIG/nvim/init.vim
