# 3er Reto (SSC 2019) in Bash Shell

iniciar_calculos(){
    echo '> Contabilizando ganadores'
    clasificando_ganadores
}

clasificando_ganadores(){
    unset GANADORES[@]
    registro=-1
    for linea in "${GAMES[@]}"; do
        registro=$((registro+1))
        # Obtener equipo ganador
        winner=$(echo $linea| cut -d',' -f 5)
        if [ $winner -eq 1 ]
        then
            # Equipo 1 [ 12,15,18,21,24 ]
            player=$(echo $linea | cut -d',' -f 12)
            sumar_player $player
            player=$(echo $linea | cut -d',' -f 15)
            sumar_player $player
            player=$(echo $linea | cut -d',' -f 18)
            sumar_player $player
            player=$(echo $linea | cut -d',' -f 21)
            sumar_player $player
            player=$(echo $linea | cut -d',' -f 24)
            sumar_player $player
        else
            # Equipo 2 [ 37,40,43,46,49 ]
            player=$(echo $linea | cut -d',' -f 37)
            sumar_player $player
            player=$(echo $linea | cut -d',' -f 40)
            sumar_player $player
            player=$(echo $linea | cut -d',' -f 43)
            sumar_player $player
            player=$(echo $linea | cut -d',' -f 46)
            sumar_player $player
            player=$(echo $linea | cut -d',' -f 49)
            sumar_player $player
        fi
    done
    
    for linea_resultados in "${GANADORES[@]}"; do
        id_campeon=$(echo $linea_resultados | cut -d',' -f 1)
        veces_campeon=$(echo $linea_resultados | cut -d',' -f 2)
        
        get_championByID $id_campeon
        posicion_campeon=$?
        nombre_campeon=$(echo ${CAMPEONES[$posicion_campeon]} | cut -d',' -f 2)
        echo "$nombre_campeon,$veces_campeon"
    done
}

# Method to add count of winner
# $1 ID of player
sumar_player(){
    localizado_suma=0
    encontrado_suma=-1
    
    for linea_suma in "${GANADORES[@]}"; do
        localizado_suma=$((localizado_suma+1))
        id_linea=$(echo $linea_suma| cut -d',' -f 1)
        #echo "Comparando $1 vs $id_linea"
        if [ $1 -eq $id_linea ]
        then
            encontrado_suma=$localizado_suma
        fi
    done
    
    if [ $encontrado_suma -eq -1 ]
    then
        # Registro
        ultimo_elemento=${#GANADORES[@]}
        GANADORES[$ultimo_elemento+1]="$1,1"
    else
        # Añadir contador
        winner=$(echo ${GANADORES[$encontrado_suma]}| cut -d',' -f 1)
        contador=$(echo ${GANADORES[$encontrado_suma]}| cut -d',' -f 2)
        contador=$((contador+1))
        GANADORES[$encontrado_suma]="$winner,$contador"
    fi
}

# Method to get a champion by id
# $1 Get a champion
# Retrun position of Array "CAMPEONES"
get_championByID(){
    localizado=-1
    
    for linea in "${CAMPEONES[@]}"; do
        localizado=$((localizado+1))
        id_linea=$(echo $linea| cut -d',' -f 1)
        if [ $1 -eq $id_linea ]
        then
            return $localizado
        fi
    done
}

# Guarda los datos
save_data(){
    linea
    
    # BBDD Result
    echo '' > result.csv
    for val in "${GANADORES[@]}"; do
        id_campeon=$(echo $val | cut -d',' -f 1)
        veces_campeon=$(echo $val | cut -d',' -f 2)
        
        get_championByID $id_campeon
        posicion_campeon=$?
        nombre_campeon=$(echo ${CAMPEONES[$posicion_campeon]} | cut -d',' -f 2)
        echo $nombre_campeon','$veces_campeon >> result.csv
    done
    echo '> Los resultados han sido guardados correctamente en "result.csv"'
    
    linea
}

# Carga todas las variables
load_data(){
    linea
    
    echo '> Cargando las Bases de datos...'
    echo -ne '#                         (1%)\r'
    sleep 1
    
    # BBDD Campeones
    unset CAMPEONES[*]
    longitud_campeones=-1
    while IFS='' read -r linea || [[ -n "$linea" ]]; do
        if [ ! -z "$linea" ]
        then
            id_linea=$(echo $linea| cut -d',' -f 1)
            if [[ "$id_linea" =~ ^[0-9]+$ ]]
            then
                CAMPEONES[$longitud_campeones+1]=$linea
                longitud_campeones=${#CAMPEONES[@]}
            fi
        fi
    done < champions.csv
    echo -ne '##############            (50%)\r'
    
    # BBDD Games
    unset GAMES[*]
    longitud_games=-1
    while IFS='' read -r linea || [[ -n "$linea" ]]; do
        if [ ! -z "$linea" ]
        then
            id_linea=$(echo $linea| cut -d',' -f 1)
            if [[ "$id_linea" =~ ^[0-9]+$ ]]
            then
                GAMES[$longitud_games+1]=$linea
                longitud_games=${#GAMES[@]}
            fi
        fi
    done < games.csv
    echo -ne '##########################(100%)\r'
    sleep 1
    echo '> Las estadisticas han sido cargadas correctamente'
    sleep 0.5
    echo '> Los campeones han sido cargados correctamente'
    sleep 0.5
    
    limpiar_arrays
    echo "VALORES CARGADOS "${GAMES[@]}
    linea
}

# Limpia el Array para evitar elementos vacios
limpiar_arrays(){
    GAMES=( "${GAMES[@]}" )
    CAMPEONES=( "${CAMPEONES[@]}")
    GANADORES=( "${GANADORES[@]}")
}

# Imprime linea
linea(){
    echo '-------------------------------------'
}

# Base Script
GAMES[0]=0
CAMPEONES[0]=0
GANADORES[0]=0
linea
load_data
echo '> Se esta realizando los calculos...'
iniciar_calculos
save_data
linea