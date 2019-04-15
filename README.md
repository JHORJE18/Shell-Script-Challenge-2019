# Shell Script Challenge 2019
Shell Script Challenge es una competición destinada a alumnos de DAM, DAW, ASIR y TSMR.
Durante tres fines de semana, los participantes reciben 3 retos que han de ser resueltos utilizando Shell Scripts.

# Reto 01 | Juego de cartas "A Pescar" 🃏
Este Script es el juego de cartas "A Pescar" donde podrás jugar contra la máquina varias partidas con la Baraja Española.
Las principales funciones:
+ Las cartas son barajeadas al inicio de una nueva partida
+ El juego entre el Usuario contra la máquina
+ Se reparten 7 cartas aleatorias al inicio de una nueva partida
+ Las cartas sobrantes son guardadas para robar en caso de ser necesario
+ El juego se desarrolla por turnos, empezando por el usuario
+ En cada turno, el jugador solicita una carta al otro
+ Si el jugador tiene una carta con el número solicitado se la dara al otro jugador, en caso de no contar con una carta del número solicitado dira "A Pescar" y robara una carta de la baraja y finalizara el turno
+ Cuando un jugador consigue reunir las 4 cartas del mismo número gana un "SET" de puntos

# Reto 02 | La Biblioteca 📚
Este Script es un gestor de Biblioteca que permite realizar las siguientes operaciones:
1. Gestión de libros:
    + Alta
    + Baja (a través del id)
    + Consulta (a través del id o nombre)
2. Gestión de usuarios:
    + Alta
    + Baja (a través del id)
    + Consulta (a través del id o nombre)
3. Gestión de préstamos:
    + Alta
    + Baja (a través del id)
    + Listado
    + Consulta (a través del id de usuario o del id de libro)
+ Salir

La información se guarda en los siguientes ficheros con la siguiente estructura de datos:
+ libros_bd
    + id_libro,título,autor,genero,año,estanteria,prestado
+ usuarios_bd
    + id_usuario,nombre,apellido1,apellido2,curso,num_prestamos
+ prestamos_bd
    + id_prestamo,id_libro,id_usuario

> # Funciones que se ha tenido en cuenta
> - Un libro no puede eliminarse ni prestarse a otro usuario si esta siendo prestado.
> - Un usuario no puede eliminarse mientras tenga libros prestados.
> - Los usuarios no pueden tener más de 3 libros prestados.
> - Cuando se realiza cualquier cambio se guarda la información en los archivos para evitar la perdida de datos.
> - Al Iniciar el Script automaticamente carga la información de los archivos, si no existen se empieza de 0, cuando se guarda la información (Automatico) se generara los correspondientes ficheros.
> - Mucho más...

# Reto 03 | La grieta del invocador 🕹
En este Shell Script se calcula cuales son las 10 parejas de personajes más frecuentemente empleadas en las partidas de ranking gandas en las últimas temporadas de League of Legends.

## Ficheros
- ```champions.csv```
    - Base de datos con los campeones de League of Legends.
    - Cada linea tiene el Identificador del campeon y su numbre
    > 1,Annie
- ```games.csv```
    - Estadisticas de más de 50.000 partidas de ranking de League of Legends en los últimos años.
    - En cada partida se enfrentan 2 equipos (1 vs 2) formados por 5 componentes cada uno.
    - La información del fichero esta organizada en filas y columnas.
    - Cada fila tiene el registro de una partida, mientras que cada columnacontiene uno de los campos:
### Columnas
- gameId: Identificador de la partida de ranking
- creationTime: Marca de tiempo de creación de la partida
- gameDuration: Duración en segundos de la partida
- seasonId: Identificador de la temporada de juego
- winner: Equipo ganador de la partida (1 si ha ganado el primer equipo, 2 si ha ganado el segundo)
- firstBlood/Tower/Inhibitor/Baron/Dragon/RiftHerald : Equipo que realizó la primera sangre, torre, inhibido, barón, dragón, o heraldo (0: ninguno, 1: primer equipo, 2: segundo equipo)
- t1_champXid: Identificadores de los 5 componentes del primer equipo.
- t2_champXid: Identificadores de los 5 componentes del segundo equipo.
- t1_champX_sumY: Identificador del Y-ésimo hechizo seleccionado por el X-ésimo componente del primer equipo.
- t2_champX_sumY: Identificador del Y-ésimo hechizo seleccionado por el X-ésimo componente del segundo equipo.
- t1_ELEMKills: Número de elementos destruidos por el primer equipo durante la partida, donde ELEMpuede ser tower, inhibitor, baron, dragon, riftHerald.
- t2_ELEMKills: Número de elementos destruidos por el segundo equipo durante la partida, donde ELEMpuede ser tower, inhibitor, baron, dragon, riftHerald.
- t1_banX: El identificador del X-ésimo personaje prohibido por el equipo 1 para la partida.
- t2_banX: El identificador del X-ésimo personaje prohibido por el equipo 2 para la partida.

- En total, cada registro tiene 61 columnas o campos y no todos son necesarios para realizar el calculo final.

## Objetivo
El objetivo es realizar los calculos necesarios para finalmente generar un fichero llamado ```result.csv``` en el que se encuentren 10 filas con las 10 parejas que han coincidido más veces en equipos ganadores.
En cada fila se enncuentra el nombre de la pareja y el número de veces que dicha pareja ha coincidido en equipos ganadores.

> Dado el poco tiempo y no comprender los datos que se requerian se ha abandonado esta actividad y se ha dejado con la idea base sin poder finalizarlo.