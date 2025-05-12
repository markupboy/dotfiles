#!/bin/zsh

# Load colors if available
autoload -U colors && colors

# Define colors
GREEN=$fg[green]
RED=$fg[red]
YELLOW=$fg[yellow]
CYAN=$fg[cyan]
RESET=$reset_color

# Logging Functions
dotlog() {
    local type=$1
    shift
    local message="$@"
    case $type in
        info)
            echo -e "${CYAN}[INFO]    ${RESET} $message"
            ;;
        install)
            echo -e "${GREEN}[INSTALL]${RESET} $message"
            ;;
        skip)
            echo -e "${YELLOW}[SKIPPING]${RESET} $message"
            ;;
        error)
            echo -e "${RED}[ERROR]   ${RESET} $message"
            ;;
        divider)
            echo -e "${CYAN}----------------------------------------${RESET}"
            ;;
        *)
            echo -e "${CYAN}[INFO]${RESET} $message"
            ;;
    esac
}

spinner() {
    local pid=$1
    local delay=0.1
    local spin=('|' '/' '-' '\')
    while kill -0 $pid 2>/dev/null; do
        for i in "${spin[@]}"; do
            printf "\r%s" "$i"
            sleep $delay
        done
    done
    printf "\r"  # Clear spinner
}