
cp ./emacs/.emacs $HOME/.emacs
cp ./kglobalshortcutsrc  ~/.kde4/share/config/kglobalshortcutsrc 
cp ./Xdefaults ~/.Xdefaults

mkdir -p $HOME/.emacs.d

# Cask install
cp ./emacs/Cask $HOME/.emacs.d/
yaourt -S cask
$(cd $HOME/.emacs.d; cask install)

