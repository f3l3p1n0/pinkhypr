#!/bin/bash

# Pinkhypr By f3l3p1n0 --> https://www.youtube.com/@f3l3p1n0

# DEPENDENCIAS

depen=(
    qt5-wayland 
    qt6-wayland
    polkit 
    polkit-gnome 
    pipewire 
    jq
)

# PAQUETES YAY

install_packages_yay=(
    hyprland 
    wezterm 
    waybar 
    swaylock-effects 
    wl-clip-persist  
    xdg-desktop-portal-hyprland 
    swappy 
    grim 
    slurp 
    nemo 
    firefox
    pamixer 
    pavucontrol 
    brightnessctl  
    papirus-icon-theme
    zsh 
    lsd 
    bat 
    zsh-syntax-highlighting 
    zsh-autosuggestions 
    swayidle 
    xautolock 
    hyprpaper
    neofetch 
    megatools 
    wget 
    unzip
    rustup
)

# VARIABLE PARA GUARDAR LOS LOGS DE CADA INSTALACIÓN

INSTLOG="install.log"

# PRESENTACIÓN

function present() {
    array=(
        "\n"
        "\040\040\040\040\040\040#####\040\040\040#\040\040\040\040#\040\040\040#\040\040\040#\040\040\040#\040\040\040#\040\040\040#\040\040\040#\040\040\040#\040\040\040#####\040\040\040#####\n"
        "\040\040\040\040\040\040#\040\040\040#\040\040\040#\040\040\040\040##\040\040#\040\040\040#\040\040#\040\040\040\040#\040\040\040#\040\040\040\040#\040#\040\040\040\040#\040\040\040#\040\040\040#\040\040\040#\n"
        "\040\040\040\040\040\040#####\040\040\040#\040\040\040\040#\040#\040#\040\040\040#\040#\040\040\040\040\040#####\040\040\040\040\040#\040\040\040\040\040#####\040\040\040#####\n"
        "\040\040\040\040\040\040#\040\040\040\040\040\040\040#\040\040\040\040#\040\040##\040\040\040#\040\040#\040\040\040\040#\040\040\040#\040\040\040\040#\040\040\040\040\040\040#\040\040\040\040\040\040\040#\040\040#\040\n"
        "\040\040\040\040\040\040#\040\040\040\040\040\040\040#\040\040\040\040#\040\040\040#\040\040\040#\040\040\040#\040\040\040#\040\040\040#\040\040\040#\040\040\040\040\040\040\040#\040\040\040\040\040\040\040#\040\040\040#\n"
        "\n"
        "\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040\040b"
        "y\040"
        "f"
        "3"
        "l"
        "3"
        "p"
        "1"
        "n"
        "0\n"
    )

    for letter in ${array[@]}; do
    echo -en "\e[95m$letter\e[0m"
    sleep 0.2
    done
}

# PROGRESO DE BARRA MOSTRADO AL USUARIO

function show_progress() {
    while ps | grep $1 &> /dev/null;
    do
        echo -n "."
        sleep 2
    done
    echo -en "\e[32mOK\e[0m"
    sleep 2
}

# FUNCION ENCARGADA DE INSTALAR LOS PAQUETES Y DEPENDENCIAS

function install_software() {
    echo -en $1
    yay -S --noconfirm $1 &>> $INSTLOG &
    show_progress $!

    # comprobamos si se ha instalado correctamente
    if yay -Q $1 &>> /dev/null ; then
        echo -e ""
    else
        # si no se ha instalado correctamente se imprimirá un mensaje de error
        echo -e "$1 no ha sido instalado correctamente, porfavor comprueba install.log"
        exit 0
    fi
}

# ACTUALIZAR SISTEMA

function update() {
    echo -en "Actualizando el sistema."
    sudo pacman -Syu --noconfirm &>> $INSTLOG &
    show_progress $!
    echo -en "\n"
}

# INSTALACIÓN PACKAGE MANAGER YAY

function packagemanager() {
    if [ ! -f /sbin/yay ]; then  
        echo -en "Instalando yay."
        git clone https://aur.archlinux.org/yay-git &>> $INSTLOG
        cd yay-git
        makepkg -si --noconfirm &>> ../$INSTLOG &
        show_progress $!
        if [ -f /sbin/yay ]; then
            :
        else
            echo -e "La instalación de yay ha fallado, porfavor lee el archivo install.log"
            exit 0
        fi
    fi
}

# SETUP

function setup() {
    echo -e "\n"
    echo -en "\e[33m[x] Instalando dependencias necesarias...\e[0m\n"
    for SOFTWR in ${depen[@]}; do
        install_software $SOFTWR 
    done

    echo -en "\n"
    echo -en "\e[33m[x] Instalando paquetes Yay...\e[0m\n"
    for SOFTWR in ${install_packages_yay[@]}; do
        if [ "$SOFTWR" == 'rustup' ]; then
            sudo pacman -R --noconfirm rust > /dev/null 2>&1
            install_software $SOFTWR
        else
            install_software $SOFTWR 
        fi
    done

    echo -en "\n"
    echo -en "\e[33m[x] Instalando eww bar...\e[0m\n"
    echo -en "eww."
    cd "$HOME"
    git clone https://github.com/elkowar/eww &>> $INSTLOG
    cd eww
    cargo build --release --no-default-features --features=wayland &>> ../$INSTLOG &
    show_progress $!
    cd target/release
    sudo ln -s $1/eww/target/release/eww /usr/local/bin
}

# SE COPIAN LOS DOTFILES

function copia() {
    mkdir "$HOME/.config" > /dev/null 2>&1

    rm -rf "$HOME/.config/neofetch" > /dev/null 2>&1
    mkdir "$HOME/.config/neofetch"
    cp -r $1/dotfiles/neofetch/* "$HOME/.config/neofetch/"

    mkdir "$HOME/.config/wezterm"
    cp -r $1/dotfiles/wezterm/* "$HOME/.config/wezterm/"

    mkdir "$HOME/.config/hypr"
    cp -r $1/dotfiles/hypr/* "$HOME/.config/hypr/"

    mkdir "$HOME/Images"
    cp -r $1/dotfiles/wallpaper.png "$HOME/Images/"

    mkdir "$HOME/.config/waybar"
    cp -r $1/dotfiles/waybar/* "$HOME/.config/waybar/"
    chmod +x "$HOME/.config/waybar/scripts/mediaplayer.py" "$HOME/.config/waybar/scripts/wlrecord.sh"
    chmod +x "$HOME/.config/waybar/scripts/playerctl/playerctl.sh"

    sudo usermod --shell /usr/bin/zsh $USER > /dev/null 2>&1
    sudo usermod --shell /usr/bin/zsh root > /dev/null 2>&1
    cp -r "$1/dotfiles/.zshrc" "$HOME/"
    sudo ln -s -f "$HOME/.zshrc" "/root/.zshrc"

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k > /dev/null 2>&1
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k > /dev/null 2>&1
    cp -r $1/dotfiles/powerlevel10k/user/.p10k.zsh "$HOME/"
    sudo cp -r $1/dotfiles/powerlevel10k/root/.p10k.zsh "/root/"

    cd /usr/share
    sudo mkdir zsh-sudo
    sudo chown $USER:$USER zsh-sudo/
    cd zsh-sudo
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh > /dev/null 2>&1

    #mkdir "$1/dotfiles/fonts"
    #cd $1/dotfiles/fonts
    #megadl --print-names https://mega.nz/file/GxFVSLLY#etuNc6QRrEl6wgl_ZatvomojDhkBTFPqlKS7ELk7KAM > /dev/null 2>&1

    #sudo cp -r $1/dotfiles/fonts/* "/usr/share/fonts/"
    #cd /usr/share/fonts/
    #sudo unzip fonts.zip > /dev/null 2>&1
    #sudo rm -rf fonts.zip  > /dev/null 2>&1

    mkdir "$HOME/.config/scripts"
    cp -r $1/dotfiles/scripts/* "$HOME/.config/scripts"
    chmod +x -R $HOME/.config/scripts/

    mkdir "$HOME/.config/swappy"
    cp -r $1/dotfiles/swappy/* "$HOME/.config/swappy"

    mkdir "$HOME/.config/swaylock"
    cp -r $1/dotfiles/swaylock/* "$HOME/.config/swaylock"

    #sudo systemctl enable sddm > /dev/null 2>&1
    #sudo cp -r "$1/dotfiles/sddm/wallpaper.png" "/usr/share/sddm/themes/Sugar-Candy/Backgrounds/"
    #sudo cp -r "$1/dotfiles/sddm/theme.conf" "/usr/share/sddm/themes/Sugar-Candy/"
    #sudo cp -r "$1/dotfiles/sddm/sddm.conf" "/etc/"
    #echo -e "\e[32mOK\e[0m"
}

# FINALIZACION

function finalizacion() {
    echo ""
    echo "INSTALACIÓN FINALIZADA"
    echo ""
}

# SE LLAMA A TODAS LAS FUNCIONES PROGRESIVAMENTE

function call() {
    ruta=$(pwd)
    update
    packagemanager
    setup "$ruta"
    copia "$ruta"
    finalizacion
}

# SE COMPRUEBA SI EL INSTALADOR SE EJECUTA COMO ROOT

if [ $(whoami) != 'root' ]; then
    present
    # confirmación de proceder a instalar
    echo -en '\n'
    read -rep 'Atención!! En este momento se va a iniciar la instalación. ¿Desea continuar? (y,n) ' CONTINST
    if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
        echo -en "\n"
        echo -e "\e[33m[x] Iniciando Setup...\e[0m\n"
        sudo touch /tmp/hyprv.tmp
        call
    else
        echo -e "Saliendo del script, no se han realizado cambios en tu sistema."
        exit 0
    fi
else
    echo 'Error, el script no debe ser ejecutado como root.'
    exit 0
fi