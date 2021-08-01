mkdir -p ~/.config/nvim

# Install vim-plug
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Symlink config files
ln -s init.vim ~/.config/nvim/init.vim
ln -s plugins.vim ~/.config/nvim/plugins.vim
ln -s mappings.vim ~/.config/nvim/mappings.vim
ln -s config.vim ~/.config/nvim/config.vim
ln -s coc.vim ~/.config/nvim/coc.vim
ln -s coc-settings.json ~/.config/nvim/coc-settings.json
ln -s UltiSnips ~/.config/nvim/UltiSnips
ln -s colors ~/.config/nvim/colors
