# 1er Reto (SSC 2019) in Bash Shell

# Menu principal
menu_principal(){
    echo 'Bienvenido al 1º Script del reto, donde jugaras al famoso juego de cartas "A Pescar"'
    valido=false
    while [ $valido == false ]
    do
        linea
        echo '1. Comenzar partida'
        echo '2. Explicar instrucciones'
        echo '3. Salir'
        read opcion
        case $opcion in
            1)
                echo "Comenzando partida..."
                linea
                nueva_partida
            ;;
            2)
                linea
                echo "# Instrucciones"
                linea
                mostrar_instrucciones
            ;;
            3)
                echo "Finalizando Script, gracias por jugar!"
                linea
                valido=true
                break
            ;;
            *)
                echo "Perdona, no he entendido la respuesta"
            ;;
        esac
    done
    return $opcion
}

# Mostrar instrucciones
mostrar_instrucciones(){
    say_machine 'Juego de cartas "A Pescar"' 1
    say_machine 'Jugaras contra la maquina, el juego consiste en intentar conseguir el mayor número de sets de 4 cartas con el mismo número.' 3
    say_machine 'Para ello al principio se repartiran 7 cartas a cada jugador.' 2
    say_machine 'Posteriormente podras solicitar un número y si la maquina no tiene ese número dentro de su baraja te dira "A Pescar".' 3
    say_machine 'En ese momento robaras una carta de la baraja y continuara el siguiente turno.' 2
    echo ''
    say_machine 'El juego finaliza cuando ambos jugadores se quedan sin más cartas.' 2
    say_machine 'El jugador que más puntos (Por cada 4 cartas del mismo número) ganara.' 2
}

nueva_partida(){
    # Limpiamos variables
    say_machine 'Antes de empezar voy primero a limpiar la mesa...' 2
    unset USER[*]
    unset COMP[*]
    unset USER_SET
    unset COMP_SET
    all_cards
    
    say_machine 'Vale, Vamos a comenzar una nueva partida' 2
    say_machine 'Primero voy a barajear las cartas de forma aleatoria...' 2
    barajar_cartas
    
    finGame=false
    while [ $finGame == false ]
    do
        linea
        mostrar_cartas
        read seleccion
        check_number 0 11 $seleccion
        result=$?
        if [ $result -eq 1 ]
        then
            # Desarrollo de la partida
            unset posicion_encontrado
            buscar_en_maquina $seleccion
            posicion_encontrado=$?
            
            if [ $posicion_encontrado -ne 255 ]
            then
                # Coloca carta de Machine a User
                longiutd_user_cards=${#USER[@]}
                USER[$longiutd_user_cards+1]=${COMP[$posicion_encontrado]}
                shift_comp $posicion_encontrado
            else
                # Obtiene una carta del Oceano
                longiutd_user_cards=${#USER[@]}
                say_machine 'A pescar!!!' 3
                number_random ${#CARDS[@]}
                numberRandom=$?
                USER[$longiutd_user_cards+1]=${CARDS[$numberRandom]}
                echo '# '${CARDS[$numberRandom]}
                shift_card $numberRandom
            fi
        elif [ $seleccion -eq -1 ]
        then
            say_machine 'Te has rendido' 1
            for i in 1 2 3 4
            do
                say_machine 'HA' .1
            done
            say_machine 'HA' 2
            say_machine 'Nos vemos en la próxima!' 1
            finGame=true
        else
            say_machine 'Recuerda que solo puedes poner numeros comprendidos del 1 al 10' 1
            say_machine 'Teclea el número que buscas, si quieres dejar la partida a medias y rendirte teclea -1' 1.5
        fi

        # Comprobaciones finales

        # Comprueba si ha conseguido el User un SET
        need_check=1
        while [ $need_check -eq 1 ]
        do
            check_cards_set 0
            result_checked=$?
            if [ $result_checked -eq 0 ]
            then
                need_check=0
                break
            fi
        done

        # Comprueba que no se han terminado las cartas
        check_cards_finish
        if [ $? -eq 1 ]
        then
            say_machine 'Juego terminado, ha sido un placer jugar contigo.' 1.4
            finGame=true
        fi

        # Desarrollo de la partida para Maquina
        unset posicion_encontrado
        number_random 10
        seleccion=$?
        buscar_en_user $seleccion
        posicion_encontrado=$?
            
            if [ $posicion_encontrado -ne 255 ]
            then
                # Coloca carta de User a Machine
                longitud_machine_cards=${#COMP[@]}
                COMP[$longitud_machine_cards+1]=${USER[$posicion_encontrado]}
                shift_user $posicion_encontrado
                say_machine 'Gracias por tu carta' 1.5
            else
                # Obtiene una carta del Oceano
                longitud_machine_cards=${#COMP[@]}
                say_machine 'Voy a pescar' 3
                number_random ${#CARDS[@]}
                numberRandom=$?
                COMP[$longitud_machine_cards+1]=${CARDS[$numberRandom]}
                shift_card $numberRandom
            fi

        # Comprueba si ha conseguido el Machine un SET
        need_check=1
        while [ $need_check -eq 1 ]
        do
            check_cards_set 1
            result_checked=$?
            if [ $result_checked -eq 0 ]
            then
                need_check=0
                break
            fi
        done

    done
}

# Metodo mueve elemento carta de maquina a usuario
# $1 Valor a buscar en el array de la maquina
# Return posición donde se encuentra el elemento o -1 si no se encuentra
buscar_en_maquina(){
    array_numerico_COMP=${COMP[*]}
    
    encontrado=false
    posicion=0
    for i in ${COMP[*]}
    do
        obtener_numero_carta $i
        numeroCarta=$?
        if [ $numeroCarta -eq $1 ]
        then
            say_machine 'Tengo una carta del número que buscas' 1.2
            say_machine 'Machine te ha dado su carta' 1
            echo '# '$i
            return $posicion
        fi
        posicion=$((posicion+1))
    done
    
    return -1
}

# Metodo mueve elemento carta de usuario a maquina
# $1 Valor a buscar en el array del usuario
# Return posición donde se encuentra el elemento o -1 si no se encuentra
buscar_en_user(){
    array_numerico_USER=${USER[*]}
    
    encontrado=false
    posicion=0
    for i in ${USER[*]}
    do
        obtener_numero_carta $i
        numeroCarta=$?
        if [ $numeroCarta -eq $1 ]
        then
            say_machine 'Tienes una carta para mi' 1.2
            say_machine 'Le has dado una carta a Machine' 1
            echo '# '$i
            return $posicion
        fi
        posicion=$((posicion+1))
    done
    
    return -1
}

# Comprueba si ha conseguido realizar un SET
# $1 Numero del participante 0 => USER ; 1 => COMP
# Returns 0 => Nada que hacer ; 1 => Se ha encontrado set, reComprobar
check_cards_set(){
    player=$1

    if [ $player -eq 0 ]
    then
        # User
        for i in ${USER[@]}
        do
            obtener_numero_carta $i
            numero_busqueda=$?
            acumulando_valor=0
            for o in ${USER[@]}
            do
                obtener_numero_carta $o
                numero_consultando=$?
                if [ $numero_busqueda = $numero_consultando ]
                then
                    # Contabilizar para en caso de detectar 4 saltar un SET
                    acumulando_valor=$((acumulando_valor+1))
                fi
            done

            if [ $acumulando_valor -eq 4 ]
            then
                say_machine 'Has conseguido reunir las cartas del $((numero_busqueda))' 2
                USER_SET=$((USER_SET+1))
                echo 'Puntos USER =>    '$USER_SET
                echo 'Puntos Machine => '$COMP_SET

                remove_cards_number 0 $numero_busqueda
                return 1
            fi
        done
    else
        # Comp
        for i in ${COMP[@]}
        do
            obtener_numero_carta $i
            numero_busqueda=$?
            acumulando_valor=0
            for o in ${COMP[@]}
            do
                obtener_numero_carta $o
                numero_consultando=$?
                if [ $numero_busqueda = $numero_consultando ]
                then
                    # Contabilizar para en caso de detectar 4 saltar un SET
                    acumulando_valor=$((acumulando_valor+1))
                fi
            done

            if [ $acumulando_valor -eq 4 ]
            then
                say_machine 'He conseguido reunir las 4 cartas del $((numero_busqueda))' 2
                COMP_SET=$((COMP_SET+1))
                echo 'Puntos USER =>    '$USER_SET
                echo 'Puntos Machine => '$COMP_SET

                remove_cards_number 1 $numero_busqueda
                return 1
            fi
        done
    fi

    return 0
}

# Comprueba que el juego ha finalizado al no contar con más cartas
# Returns 1 => Sin más cartas (Fin) ; 0 => Aún hay cartas
check_cards_finish(){
    # Sin más cartas en el mazo
    if [ ${#CARDS[@]} -eq 0 ]
    then 
        # Usuario sin más cartas
        if [ ${#USER[@]} -eq 0 ]
        then
            # Machine sin más cartas
            if [ ${#COMP[@]} -eq 0 ]
            then
                return 1
            fi
        fi
    fi

    return 0
}

# Quita las cartas del jugador / maquina con el número indicado
# $1 Especifica de quien va a quitar 0 => User ; 1 => Machine
# $2 Número a quitar
remove_cards_number(){
    posicion=0

    if [ $1 -eq 0 ]
    then
        # Cartas User
        for i in ${USER[@]}
        do
            numero_carta $i
            numero_actual=$?

            if [ $2 -eq $numero_actual ]
            then
                unset USER[$posicion]
            fi

            posicion=$((posicion+1))
        done
        USER=( "${USER[@]}")
    else
        # Cartas Machine
        for i in ${COMP[@]}
        do
            numero_carta $i
            numero_actual=$?

            if [ $2 -eq $numero_actual ]
            then
                unset COMP[$posicion]
            fi

            posicion=$((posicion+1))
        done
        COMP=( "${COMP[@]}")
    fi
}

# Baraja cartas
barajar_cartas(){
    # Cartas usuario
    for i in 0 1 2 3 4 5 6
    do
        number_random ${#CARDS[*]}
        numberRandom=$?
        USER[$i]=${CARDS[$numberRandom]}
        shift_card $numberRandom
        say_machine 'Pluf' .3
        # echo 'User saved ==> ' ${USER[$i]} ' When number selected is ' $numberRandom
        unset numberRandom
    done
    say_machine 'Ahora repartire mis cartas de forma aleatoria' 2
    
    # Cartas Maquina
    for i in 0 1 2 3 4 5 6
    do
        number_random ${#CARDS[*]}
        numberRandom=$?
        COMP[$i]=${CARDS[$numberRandom]}
        shift_card $numberRandom
        say_machine 'Pluf' .3
        # echo 'COMP saved ==> ' ${COMP[$i]} ' When number selected is ' $numberRandom
        unset numberRandom
    done
    
    say_machine 'Ya esta, ahora te muestro tus cartas y cuando quieras empezamos' 2
}

# Muestra las cartas al usuario
mostrar_cartas(){
    for i in ${USER[@]}
    do
        obtener_numero_carta $i
        numero_carta=$?
        palo_carta=$(echo $i | cut -d'_' -f 2)
        echo '# '$numero_carta  '| '$palo_carta
    done
}

# Metodo devuelve número de la carta
# $1 Carta
obtener_numero_carta(){
    unset numero_carta
    numero_carta=$(echo $1 | cut -d'_' -f 1)
    return $numero_carta
}

# Genera un número aleatorio entre el 0 y el máximo $1
# $1 Valor máximo
number_random(){
    DIV=$(($1+1))
    R=$(($RANDOM%$DIV))
    return $R
}

# Quita un elemento de las cartas de la baraja
# y mueve los otros elementos
shift_card(){
    unset CARDS[$1]
    CARDS=( "${CARDS[@]}" )     # Genera nuevo array con los nuevos valores
}

# Quita un elemento de las cartas del usuario
# y mueve los otros elementos
# $1 Elemento a quitar
shift_user(){
    unset USER[$1]
    USER=( "${USER[@]}")
}

# Quita un elemento de las cartas del usuario
# y mueve los otros elementos
# $1 Elemento a quitar
shift_comp(){
    unset COMP[$1]
    COMP=( "${COMP[@]}")
}

# Mensaje que la maquina va a decir
# $1 Mensaje
# $2 Tiempo de espera
say_machine(){
    echo -e $machine': ' $1
    sleep $2
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

# Imprime linea
linea(){
    echo '---------------------------------------------------------------------'
}

# Prepara todas las cartas de la partida
all_cards(){
    # Elimina cualquier rastro
    unset CARD[*]
    
    # Oros
    CARDS[0]=1_Oros
    CARDS[1]=2_Oros
    CARDS[2]=3_Oros
    CARDS[3]=4_Oros
    CARDS[4]=5_Oros
    CARDS[5]=6_Oros
    CARDS[6]=7_Oros
    CARDS[7]=8_Oros
    CARDS[8]=9_Oros
    CARDS[9]=10_Oros
    # Copas
    CARDS[10]=1_Copas
    CARDS[11]=2_Copas
    CARDS[12]=3_Copas
    CARDS[13]=4_Copas
    CARDS[14]=5_Copas
    CARDS[15]=6_Copas
    CARDS[16]=7_Copas
    CARDS[17]=8_Copas
    CARDS[18]=9_Copas
    CARDS[19]=10_Copas
    # Espadas
    CARDS[20]=1_Espadas
    CARDS[21]=2_Espadas
    CARDS[22]=3_Espadas
    CARDS[23]=4_Espadas
    CARDS[24]=5_Espadas
    CARDS[25]=6_Espadas
    CARDS[26]=7_Espadas
    CARDS[27]=8_Espadas
    CARDS[28]=9_Espadas
    CARDS[29]=10_Espadas
    # Bastos
    CARDS[30]=1_Bastos
    CARDS[31]=2_Bastos
    CARDS[32]=3_Bastos
    CARDS[33]=4_Bastos
    CARDS[34]=5_Bastos
    CARDS[35]=6_Bastos
    CARDS[36]=7_Bastos
    CARDS[37]=8_Bastos
    CARDS[38]=9_Bastos
    CARDS[39]=10_Bastos
}

## Programa base ##
USER[0]=0
COMP[0]=0
machine="Machine o_o"
linea
linea
menu_principal
# Longitud array ==> echo "${#CARDS[*]} Cartas"
# Elimina del array ==> unset CARDS[4]