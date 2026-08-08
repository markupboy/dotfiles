set -l krew_root $HOME/.krew
if set -q KREW_ROOT
    set krew_root $KREW_ROOT
end

fish_add_path -g $krew_root/bin
