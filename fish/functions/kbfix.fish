function kbfix --description 'clear a stuck kitty keyboard protocol mode'
    # a TUI that died without popping leaves ctrl+c encoded as ^[[99;5u
    printf '\033[<16u\033[=0;1u'
end
