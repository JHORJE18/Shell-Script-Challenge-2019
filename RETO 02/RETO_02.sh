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
                echo 'El valor introducido no es válido, selecciona una opción del menú válida'
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
            nuevo_libro
        ;;
        2)
            eliminar_libro
        ;;
        3)
            consultar_libro
        ;;
    esac
}

# Nuevo libro
nuevo_libro(){
    linea
    echo -e 'Añadir nuevo libro\n'
    echo 'Introduce el titulo del libro'
    read name
    echo 'Introduce el autor del libro '$name
    read autor
    echo 'Introduce el genero del libro '$name
    read genero
    echo 'Introduce el año del libro '$name
    read year
    echo 'Introduce la estanteria del libro '$name
    read estanteria

    get_max_id 1
    id=$?
    id_new=$(($id + 1))
    
    libro="$id_new,$name,$autor,$genero,$year,$estanteria,0"
    longitud_libros=${#LIBROS[@]}
    LIBROS[$longitud_libros+1]=$libro
    save_data
}

# Eliminar libro
eliminar_libro(){
    linea
    echo -e 'Eliminar libro\n'

}

# Listar libros
listar_libros(){
    for i in ${LIBROS[@]}
    do
        id=$(echo $i| cut -d',' -f 1)
        titulo=$(echo $i| cut -d',' -f 2)
        autor=$(echo $i| cut -d',' -f 3)
        genero=$(echo $i| cut -d',' -f 4)
        year=$(echo $i| cut -d',' -f 5)
        estanteria=$(echo $i| cut -d',' -f 6)
        prestado=$(echo $i| cut -d',' -f 7)

        linea
        echo 'ID: '$id
        echo 'Titulo: '$titulo
        echo 'Autor: '$autor
        echo 'Genero: '$genero
        echo 'Año: '$year
        echo 'Estanteria: '$estanteria
        if [ $prestado -eq 0 ]
        then
            echo 'Prestado: No'
        else 
            echo 'Prestado: Sí'
        fi
        linea
    done
}

# Menu usuarios
menu_usuarios(){
    imprimir_menu_usuarios
    read opcion
    case $opcion in
        1)
            nuevo_usuario
        ;;
        2)
            echo 'Accedientdo a eliminar un usuario'
        ;;
        3)
            echo 'Consultar usuario (ID/Nombre)'
        ;;
    esac
}

# Nuevo usuario
nuevo_usuario(){
    linea
    echo -e 'Añadir nuevo usuario\n'
    echo 'Introduce el nombre del usuario'
    read nombre
    echo 'Introduce el primer apellido del usuario '$nombre
    read apellido1
    echo 'Introduce el segundo apellido del usuario '$nombre
    read apellido2
    echo 'Introduce el curso en el que se encuentra el usuario '$usuario
    read curso

    get_max_id 2
    id=$?
    id_new=$(($id + 1))
    
    usuario="$id_new,$nombre,$apellido1,$apellido2,$curso,0"
    longitud_usuarios=${#USUARIOS[@]}
    USUARIOS[$longitud_usuarios+1]=$usuario
    save_data
}

# Listar usuarios
listar_usuarios(){
    for i in ${USUARIOS[@]}
    do
        id=$(echo $i| cut -d',' -f 1)
        nombre=$(echo $i| cut -d',' -f 2)
        apellido1=$(echo $i| cut -d',' -f 3)
        apellido2=$(echo $i| cut -d',' -f 4)
        curso=$(echo $i| cut -d',' -f 5)
        num_prest=$(echo $i| cut -d',' -f 6)

        linea
        echo 'ID: '$id
        echo 'Nombre: '$nombre
        echo 'Apellidos: '$apellido1 $apellido2
        echo 'Curso: '$curso
        echo 'Libros prestados: '$num_prest
        linea
    done
}

# Menu prestamos
menu_prestamos(){
    imprimir_menu_prestamos
    read opcion
    case $opcion in
        1)
            nuevo_prestamo
        ;;
        2)
            echo 'Accedientdo a eliminar un prestamo'
        ;;
        3)
            echo 'Consultar usuario (ID/Nombre)'
        ;;
    esac
}

# Nuevo prestamo
nuevo_prestamo(){
    linea
    echo -e 'Añadir nuevo prestamo\n'
    echo 'Selecciona el ID del Libro'
    read libro_id
    echo 'Selecciona el ID del Usuario'
    read usuario_id

    # TODO: Comprobar que el libro no ha sido prestado
    # TODO: Comprobar que el usuario no tiene más de 3 prestamos

    get_max_id 3
    id=$?
    id_new=$(($id + 1))
    
    prestamo="$id_new,$libro_id,$usuario_id"
    longitud_prestamos=${#PRESTAMOS[@]}
    PRESTAMOS[$longitud_prestamos+1]=$prestamo
    save_data
}

# Listar prestamos
listar_prestamos(){
    for i in ${PRESTAMOS[@]}
    do
        id=$(echo $i| cut -d',' -f 1)
        id_libro=$(echo $i| cut -d',' -f 2)
        id_usuario=$(echo $i| cut -d',' -f 3)

        linea
        echo 'ID: '$id
        echo 'ID Libro: '$id_libro
        echo 'ID Usuario: '$id_usuario
        linea
    done
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
    echo 'Menú principal'
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

# Consultar libro (ID/Nombre)
# $1 ID / Nombre
# Return -1 No se encuentra
search_libro(){
    localizado=-1
    
    if echo $1 | egrep -q '^[0-9]+$';
    then
        # Search by ID
        for linea in "${LIBROS[@]}"; do
            localizado=$((localizado+1))
            id_linea=$(echo $linea| cut -d',' -f 1)
            if [ $1 -eq $id_linea ]
            then
                return $localizado
            fi
        done
    else
        # Search by Name
        for linea in "${LIBROS[@]}"; do
            localizado=$((localizado+1))
            nombre_linea=$(echo $linea| cut -d',' -f 2)
            if test "${nombre_linea#*$1}" != "$nombre_linea"
            then
                return $localizado
            fi
        done
    fi
    
    return $localizado
}

# Consultar Usuario (ID/Nombre)
# $1 ID / Nombre
# Return -1 No se encuentra
search_usuario(){
    localizado=-1
    
    if echo $1 | egrep -q '^[0-9]+$';
    then
        # Search by ID
        for linea in "${USUARIOS[@]}"; do
            localizado=$((localizado+1))
            id_linea=$(echo $linea| cut -d',' -f 1)
            if [ $1 -eq $id_linea ]
            then
                return $localizado
            fi
        done
    else
        # Search by Name
        for linea in "${USUARIOS[@]}"; do
            localizado=$((localizado+1))
            nombre_linea=$(echo $linea| cut -d',' -f 2)
            if test "${nombre_linea#*$1}" != "$nombre_linea"
            then
                return $localizado
            fi
        done
    fi
    
    return $localizado
}

# Consultar Prestamo (ID Usuario / ID Libro)
# $1 ID Libro | -1 No buscar libro
# $2 ID Usuario | -1 No buscar usuario
# Return -1 No se encuentra
search_prestamo(){
    localizado=-1
    
    if echo $1 | egrep -q '^[0-9]+$';
    then
        # Search by ID
        if [ $1 -eq -1 ]
        then
            # Search by Usuario
            for linea in "${PRESTAMOS[@]}"; do
                localizado=$((localizado+1))
                id_linea=$(echo $linea| cut -d',' -f 2)
                if [ $1 -eq $id_linea ]
                then
                    return $localizado
                fi
            done
        else
            # Search by Libro
            for linea in "${PRESTAMOS[@]}"; do
                localizado=$((localizado+1))
                id_linea=$(echo $linea| cut -d',' -f 3)
                if [ $1 -eq $id_linea ]
                then
                    return $localizado
                fi
            done
        fi
    fi
    
    return $localizado
}

# Guarda todas las variables
save_data(){
    linea
    
    # BBDD Libros
    echo '' > libros.bd
    for val in "${LIBROS[@]}"; do
        echo $val >> libros.bd
    done
    echo '> La Base de datos de libros ha sido guardada correctamente'
    
    # BBDD Usuarios
    echo '' > usuarios.bd
    for val in "${USUARIOS[@]}"; do
        echo $val >> usuarios.bd
    done
    echo '> La Base de datos de usuarios ha sido guardada correctamente'
    
    # BBDD Prestamos
    echo '' > prestamos.bd
    for val in "${PRESTAMOS[@]}"; do
        echo $val >> prestamos.bd
    done
    echo '> La Base de datos de prestamos ha sido guardada correctamente'
    
    linea
}

# Carga todas las variables
load_data(){
    linea
    
    # BBDD Libros
    unset LIBROS[*]
    longitud_libros=-1
    while IFS='' read -r linea || [[ -n "$linea" ]]; do
        if [ ! -z "$linea" ]
        then
            LIBROS[$longitud_libros+1]=$linea
            longitud_libros=${#LIBROS[@]}
        fi
    done < libros.bd
    echo '> La Base de datos de libros ha sido cargada correctamente'
    
    # BBDD Usuarios
    unset USUARIOS[*]
    longitud_usuarios=-1
    while IFS='' read -r linea || [[ -n "$linea" ]]; do
        if [ ! -z "$linea" ]
        then
            USUARIOS[$longitud_usuarios+1]=$linea
            longitud_usuarios=${#USUARIOS[@]}
        fi
    done < usuarios.bd
    echo '> La Base de datos de usuarios ha sido cargada correctamente'
    
    # BBDD Libros
    unset PRESTAMOS[*]
    longitud_prestamos=-1
    while IFS='' read -r linea || [[ -n "$linea" ]]; do
        if [ ! -z "$linea" ]
        then
            PRESTAMOS[$longitud_prestamos+1]=$linea
            longitud_prestamos=${#PRESTAMOS[@]}
        fi
    done < prestamos.bd
    echo '> La Base de datos de prestamos ha sido cargada correctamente'
    linea
}

# Devuelve el ID más alto
# $1 Indica donde se consulta | 1 => Libros | 2 => Usuarios | 3 => Prestamos
get_max_id(){
    max_id=0
    case $1 in
        1)
            for i in "${LIBROS[@]}";
            do
                id=$(echo $i| cut -d',' -f 1)
                if [ $id -gt $max_id ]
                then
                    max_id=$id
                fi
            done
        ;;
        2)
            for i in "${USUARIOS[@]}";
            do
                id=$(echo $i| cut -d',' -f 1)
                if [ $id -gt $max_id ]
                then
                    max_id=$id
                fi
            done
        ;;
        3)
            for i in "${PRESTAMOS[@]}";
            do
                id=$(echo $i| cut -d',' -f 1)
                if [ $id -gt $max_id ]
                then
                    max_id=$id
                fi
            done
        ;;
    esac

    return $max_id
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
load_data
menu_principal
save_data
linea