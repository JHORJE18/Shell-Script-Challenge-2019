# 2do Reto (SSC 2019) in Bash Shell

# Menu principal
menu_principal() {
    echo 'Bienvenido a tu biblioteca'
    valido=false
    while [!valido]
    do
        linea
        imprimir_menu_principal
        
    done
}

# Comprueba que el valor introducido es posible
# $1 Valor mínimo
# $2 Valor máximo
# $3 Valor introducido
# Devuelve -1 para valor incorrecto
# Devuelve 1 para valor correcto
check_number(){
    if [ "$3" -gt "$1" ]
    then
        if [ "$3" -lt "$2" ]
        then
            return 1
        else
            return -1
        fi
    else
        return -1
    fi
}

# Imprime menu princiapl
imprimir_menu_principal() {
    linea
    echo '1. Gestión de libros'
    echo '2. Gestión de usuarios'
    echo '3. Gestión de préstamos'
    echo '0. Salir'
}

# Imprime menu libros
imprimir_menu_libros() {
    linea
    echo '1. Alta nuevo libro'
    echo '2. Baja de un libro'
    echo '3. Consultar un libro'
    echo '0. Cancelar'
}

# Imprime menu usuarios
imprimir_menu_usuarios() {
    linea
    echo '1. Alta nuevo usuario'
    echo '2. Baja de un usuario'
    echo '3. Consultar un usuario'
    echo '0. Cancelar'
}

# Imprime menu prestamos
imprimir_menu_prestamos() {
    linea
    echo '1. Alta nuevo prestamo'
    echo '2. Baja de un prestamo'
    echo '3. Listar prestamos'
    echo '0. Cancelar'
}

# Imprime linea
linea(){
    echo '-------------------------------------'
}

# Base Script
linea
menu_principal
linea