#!/bin/bash

# Función para detectar si estamos en la red local y activar o desactivar Tailscale automáticamente
detectar_red() {
    HOME_NETWORK="192.168.1.0/24"
    CURRENT_NETWORK=$(ip route | grep default | awk '{print $3}')

    if [[ "$CURRENT_NETWORK" == "192.168.1.1" ]]; then
        echo "Estás en la red local. Desactivando Tailscale..."
        sudo tailscale down
    else
        echo "Fuera de la red local. Activando Tailscale..."
        sudo tailscale up
    fi
}

# Función para activar Tailscale manualmente
activar_manual() {
    echo "Activando Tailscale manualmente..."
    sudo tailscale up
}

# Función para desactivar Tailscale manualmente
desactivar_manual() {
    echo "Desactivando Tailscale manualmente..."
    sudo tailscale down
}

# Menú interactivo
while true; do
    clear
    echo "Seleccione una opción:"
    echo "1) Detectar automáticamente"
    echo "2) Activar manualmente"
    echo "3) Desactivar manualmente"
    echo "4) Salir"
    read -p "Ingrese el número de la opción: " opcion

    case $opcion in
        1)
            detectar_red
            ;;
        2)
            activar_manual
            ;;
        3)
            desactivar_manual
            ;;
        4)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción inválida. Intenta nuevamente."
            ;;
    esac

    # Esperar que el usuario presione una tecla antes de volver al menú
    read -p "Presiona Enter para continuar..."
done

