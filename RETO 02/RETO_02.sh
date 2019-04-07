# 2do Reto (SSC 2019) in Bash Shell

# Menu principal
menu_principal() {
    echo 'Bienvenido a tu biblioteca'
    valido=false
    while [ $valido == false ]
    do
        imprimir_menu_principal
        read opcion
        case $opcion in
            1)
                menu_libros
            ;;
            2)
                menu_usuarios
            ;;
            3)
                menu_prestamos
            ;;
            0)
                echo 'Saliendo del programa'
                valido=true
            ;;
            *)
                echo 'Perdona, no te he entendido'
            ;;
        esac
    done
}

# Menu libros
menu_libros(){
    imprimir_menu_libros
    read opcion
    case $opcion in
        1)
            echo 'Accediendo a nuevo libro'
        ;;
        2)
            echo 'Accedientdo a eliminar un libro'
        ;;
        3)
            echo 'Consultar libro (ID/Nombre)'
        ;;
    esac
}

# Menu usuarios
menu_usuarios(){
    imprimir_menu_usuarios
    read opcion
    case $opcion in
        1)
            echo 'Accediendo a nuevo usuario'
        ;;
        2)
            echo 'Accedientdo a eliminar un usuario'
        ;;
        3)
            echo 'Consultar usuario (ID/Nombre)'
        ;;
    esac
}

# Menu prestamos
menu_prestamos(){
    imprimir_menu_prestamos
    read opcion
    case $opcion in
        1)
            echo 'Accediendo a nuevo prestamo'
        ;;
        2)
            echo 'Accedientdo a eliminar un prestamo'
        ;;
        3)
            echo 'Consultar usuario (ID/Nombre)'
        ;;
    esac
}

# Comprueba que el valor introducido es válido
# $1 Valor mínimo
# $2 Valor máximo
# $3 Valor introducido
# Devuelve -1 para valor incorrecto
# Devuelve 1 para valor correcto
check_number() {
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
    echo 'Menu Libros'
    linea
    echo '1. Alta nuevo libro'
    echo '2. Baja de un libro'
    echo '3. Consultar un libro'
    echo '0. Cancelar'
}

# Imprime menu usuarios
imprimir_menu_usuarios() {
    linea
    echo 'Menu Usuarios'
    linea
    echo '1. Alta nuevo usuario'
    echo '2. Baja de un usuario'
    echo '3. Consultar un usuario'
    echo '0. Cancelar'
}

# Imprime menu prestamos
imprimir_menu_prestamos(){
    linea
    echo 'Menu Préstamos'
    linea
    echo '1. Alta nuevo prestamo'
    echo '2. Baja de un prestamo'
    echo '3. Listar prestamos'
    echo '4. Consultar un prestamo (ID Usuario/ID Libro)'
    echo '0. Cancelar'
}

# Guarda todas las variables


# Carga todas las variables
load_data(){
    # BBDD Libros
    while IFS='' read -r linea || [[ -n "$linea" ]]; do
        longitud_libros=${#LIBROS[@]}
        LIBROS[$longitud_libros+1]=$linea
        echo ">" ${LIBROS[@]}
    done < file.txt
}

# Quita elemento del array LIBROS y mueve el resto
# $1 Posicion del libro a quitar
shift_libros(){
    unset LIBROS[$1]
    LIBROS=( "${LIBROS[@]}" )
}

# Quita elemento del array LIBROS y mueve el resto
# $1 Posicion del libro a quitar
shift_usuarios(){
    unset USUARIOS[$1]
    USUARIOS=( "${USUARIOS[@]}" )
}

# Quita elemento del array PRESTAMOS y mueve el resto
# $1 Posicion del libro a quitar
shift_prestamos(){
    unset PRESTAMOS[$1]
    PRESTAMOS=( "${PRESTAMOS[@]}" )
}

# Imprime linea
linea(){
    echo '-------------------------------------'
}

# Base Script
LIBROS[0]=0
USUARIOS[0]=0
PRESTAMOS[0]=0
linea
menu_principal
linea
load_data