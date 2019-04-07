# Shell Script Challenge 2019
Shell Script Challenge es una competición destinada a alumnos de DAM, DAW, ASIR y TSMR.
Durante tres fines de semana, los participantes reciben 3 retos que han de ser resueltos utilizando Shell Scripts.

# Reto 01 | Juego de cartas "A Pescar"
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

# Reto 02 | La Biblioteca
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

## Algunas aclaraciones:

+ Los id de cada fichero serán autoincrementados y no se repetirán.
+ Puedes separar los campos como quieras, pero en un mismo campo, puede haber espacios en blanco, por lo que no puedes utilizar el espacio en blanco como separador de campos.
+ Las consultas se podrán hacer a través de los campos arriba indicados. Por ejemplo, para libros, se ofrecerán dos opciones: buscar por id buscar por nombre.
+ El listado de préstamos devolverá todos los préstamos realizados.
+ Los libros prestados, no se podrán volver a prestar.
+ Un mismo usuario, sólo podrá tener 3 pedidos al mismo tiempo.
+ No se podrán dar de baja usuarios o libros con préstamos pendientes.
+ Cuando se borra un libro, un usuario o un préstamo, sus ids (que quedan libres) no hace falta que se vuelvan a reutilizar en un futuro.