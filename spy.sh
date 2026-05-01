#!/bin/bash

# ==========================================================
# Project : NetHunter System (Root & Non-Root)
# Author : 123Tool - SPY-E Developer
# Version : 2.0.26
# Description : Pure NetHunter Installer
# ==========================================================

# --- Colors ---
RED='\033[0,31m'
GREEN='\033[0,32m'
CYAN='\033[0,36m'
YELLOW='\033[1,33m'
NC='\033[0m' # No Color

display_banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
  ____  ______     __     _____ 
 / ___||  _ \ \   / /    | ____|
 \___ \| |_) \ \ / /_____|  _|  
  ___) |  __/ \ V /|_____| |___ 
 |____/|_|     |_|       |_____|
       NETHUNTER ARCHITECTURE
EOF
    echo -e "${YELLOW}Developed by 123Tool | Branding: SPY-E${NC}"
    echo -e "${NC}------------------------------------------------------"
}

check_mode() {
    if [ "$EUID" -ne 0 ]; then
        MODE="NON-ROOT"
        COLOR_MODE=$GREEN
    else
        MODE="ROOT / PRIVILEGED"
        COLOR_MODE=$RED
    fi
}

main() {
    display_banner
    check_mode

    echo -e "Status: Running in [ ${COLOR_MODE}${MODE}${NC} ] Mode"
    echo -e "Target: Preparing SPY-E NetHunter Environment...\n"

    # Install paket NetHunter
    commands=(
        "apt update && apt upgrade -y"
        "apt install wget curl git -y"
        "termux-setup-storage"
    )

    for cmd in "${commands[@]}"; do
        echo -e "${CYAN}[EXEC]${NC} Running: $cmd"
        eval "$cmd"
    done

    # --- Integrasi NetHunter ---
    echo -e "\n${GREEN}[+] Fetching Official NetHunter Script via SPY-E Engine...${NC}"
    
    # Download NetHunter
    wget -O install-nethunter-termux https://offs.ec/2MceZWr
    
    if [ -f "install-nethunter-termux" ]; then
        chmod +x install-nethunter-termux
        echo -e "${YELLOW}[!] Launching NetHunter Installer. Please wait...${NC}"
        ./install-nethunter-termux
    else
        echo -e "${RED}[!] Error: Download failed. Check your connection.${NC}"
        exit 1
    fi

    echo -e "\n${GREEN}[SUCCESS] SPY-E NetHunter System has been initialized.${NC}"
}

main "$@"
