# One Dark Pro (Night Flat) prompt colors, matching nvim/colors/onedark_pro_night_flat.lua
# and ghostty/themes/one-dark.conf.
function bobthefish_colors -S -d 'One Dark Pro color scheme for bobthefish'
    set -l bg0 16191d # editor background
    set -l bg2 2c313c # cursor line
    set -l bg3 3e4452 # visual selection
    set -l fg0 abb2bf # editor foreground
    set -l fg1 d7dae0 # bright foreground

    set -l red e06c75
    set -l green 98c379
    set -l yellow e5c07b
    set -l orange d19a66
    set -l blue 61afef
    set -l purple c678dd
    set -l cyan 56b6c2

    # Leading segment: light background, colored text.
    set -x color_initial_segment_exit $fg1 $red --bold
    set -x color_initial_segment_private $fg1 $bg3
    set -x color_initial_segment_su $fg1 $green --bold
    set -x color_initial_segment_jobs $fg1 $blue --bold

    set -x color_path $bg2 $fg0
    set -x color_path_basename $bg2 $fg1 --bold
    set -x color_path_nowrite $bg3 $red
    set -x color_path_nowrite_basename $bg3 $red --bold

    set -x color_repo $green $bg0
    set -x color_repo_work_tree $bg2 $fg1 --bold
    set -x color_repo_dirty $red $bg0
    set -x color_repo_staged $yellow $bg0

    set -x color_vi_mode_default $blue $bg0 --bold
    set -x color_vi_mode_insert $green $bg0 --bold
    set -x color_vi_mode_visual $yellow $bg0 --bold

    set -x color_username $bg2 $blue --bold
    set -x color_hostname $bg2 $blue
    set -x color_screen $bg2 $fg1 --bold

    set -x color_vagrant $cyan $bg0 --bold
    set -x color_k8s $purple $bg0 --bold
    set -x color_aws_vault $bg3 $yellow --bold
    set -x color_aws_vault_expired $bg3 $red --bold

    set -x color_rvm $red $bg0 --bold
    set -x color_node $green $bg0 --bold
    set -x color_nvm $green $bg0 --bold
    set -x color_virtualfish $blue $bg0 --bold
    set -x color_virtualgo $cyan $bg0 --bold
    set -x color_desk $orange $bg0 --bold
    set -x color_nix $blue $bg0 --bold
end
