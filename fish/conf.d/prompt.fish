# use the vendored bobthefish theme, if not available, fallback to default
set -l bobthefish $HOME/.local/share/theme-bobthefish

if status is-interactive; and test -d $bobthefish/functions
    set -g fish_function_path $bobthefish/functions $fish_function_path

    function fish_greeting; end

    set -g theme_nerd_fonts yes
    set -g theme_color_scheme nord

    set -g theme_display_user ssh
    set -g theme_display_hostname ssh
    set -g theme_display_cmd_duration yes

    set -g theme_display_git_default_branch yes
    set -g theme_git_default_branches main master

    set -g theme_git_worktree_support yes

    set -g theme_display_node yes
    set -g theme_display_k8s_context yes
    set -g theme_display_ruby yes
end
