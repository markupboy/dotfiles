###################
# prompt bar fill #
###################
function precmd {
	local TERMWIDTH
	(( TERMWIDTH = ${COLUMNS} - 1 ))
	PR_FILLBAR=""
	PR_PWDLEN=""
	local promptsize=${#${(%):---(%n@%m:%l)---()--}}
	local pwdsize=${#${(%):-%~}}
	if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
		((PR_PWDLEN=$TERMWIDTH - $promptsize))
	else
		PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
	fi
}

##############
# git prompt #
##############

git_prompt() {
  unset __CURRENT_GIT_BRANCH
  unset __CURRENT_GIT_BRANCH_STATUS
  unset __CURRENT_GIT_BRANCH_IS_DIRTY

  local st="$(git status 2>/dev/null)"
  if [[ -n "$st" ]]; then
    local -a arr
    arr=(${(f)st})

    if [[ $arr[1] =~ 'Not currently on any branch.' ]]; then
      __CURRENT_GIT_BRANCH='no-branch'
    else
      __CURRENT_GIT_BRANCH="${arr[1][(w)4]}";
    fi

    if [[ $arr[2] =~ 'Your branch is' ]]; then
      if [[ $arr[2] =~ 'ahead' ]]; then
        __CURRENT_GIT_BRANCH_STATUS='ahead'
      elif [[ $arr[2] =~ 'diverged' ]]; then
        __CURRENT_GIT_BRANCH_STATUS='diverged'
      else
        __CURRENT_GIT_BRANCH_STATUS='behind'
      fi
    fi

    if [[ ! $st =~ 'nothing to commit' ]]; then
      __CURRENT_GIT_BRANCH_IS_DIRTY='1'
    fi
  fi
    
  

  if [ -n "$__CURRENT_GIT_BRANCH" ]; then
    local s="$PR_CYAN("
    s+="$PR_GREEN$__CURRENT_GIT_BRANCH"
    case "$__CURRENT_GIT_BRANCH_STATUS" in
      ahead)
      s+="↑"
      ;;
      diverged)
      s+="↕"
      ;;
      behind)
      s+="↓"
      ;;
    esac
    if [ -n "$__CURRENT_GIT_BRANCH_IS_DIRTY" ]; then
      s+="⚡"
    fi
    s+="$PR_CYAN)"

  echo $s
  fi
}


setprompt () {
	setopt prompt_subst
	autoload colors zsh/terminfo
	if [[ "$terminfo[colors]" -ge 8 ]]; then
		colors
	fi
	for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
		eval PR_$color='%{$fg[${(L)color}]%}'
		eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
		(( count = $count + 1 ))
	done
	PR_NO_COLOUR="%{$terminfo[sgr0]%}"
	typeset -A altchar
	set -A altchar ${(s..)terminfo[acsc]}
	PR_SET_CHARSET="%{$terminfo[enacs]%}"
	PR_SHIFT_IN="%{$terminfo[smacs]%}"
	PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
	PR_HBAR=${altchar[q]:--}
	PR_ULCORNER=${altchar[l]:--}
	PR_LLCORNER=${altchar[m]:--}
	PR_LRCORNER=${altchar[j]:--}
	PR_URCORNER=${altchar[k]:--}
	case $TERM in
		xterm*)	PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}';;
		screen) PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}';;
		*) PR_TITLEBAR='';;
	esac

  PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_CYAN$PR_SHIFT_IN$PR_ULCORNER$PR_CYAN$PR_HBAR$PR_SHIFT_OUT(\
$PR_RED%m$PR_CYAN:$PR_GREEN%$PR_PWDLEN<...<%~%<<\
$PR_CYAN)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_HBAR${(e)PR_FILLBAR}$PR_CYAN$PR_HBAR$PR_SHIFT_OUT
$PR_CYAN$PR_SHIFT_IN$PR_LLCORNER$PR_CYAN$PR_HBAR$PR_SHIFT_OUT\
${(e)PR_APM}$PR_GREEN$(git_prompt)\
$PR_CYAN$PR_SHIFT_IN $PR_SHIFT_OUT>\
$PR_NO_COLOUR '

  PS2='$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_MAGENTA%_$PR_CYAN)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR '
}

setprompt

# Initial Display
echo "                       _                 _                  "
echo " Welcome back,        | |               | |                 "
echo "     ____   ____  ____| |  _ _   _ ____ | | _   ___  _   _  "
echo "    |    \ / _  |/ ___) | / ) | | |  _ \| || \ / _ \| | | | "
echo "    | | | ( ( | | |   | |< (| |_| | | | | |_) ) |_| | |_| | "
echo "    |_|_|_|\_||_|_|   |_| \_)\____| ||_/|____/ \___/ \__  | "
echo "                                  |_|               (____/  "
echo " "