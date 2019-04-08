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