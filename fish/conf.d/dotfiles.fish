if status is-interactive
    alias dotcode 'code $DOTFILES'
    alias dotvim 'cd $DOTFILES; and vim .'
    alias dotcd 'cd $DOTFILES'

    function reload! --description "Reload fish config and clear the screen"
      source ~/.config/fish/config.fish
      clear
    end
end
