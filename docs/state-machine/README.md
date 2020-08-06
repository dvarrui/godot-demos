
[<< back](../README.md)

# Máquina de estados

_Traducción al español del artículo "Godot State Machine" (https://gdscript.com/godot-state-machine)_

En este tutorial exploraremos cómo controlar el estado de tu juego para que no se salga fuera de control.
La "Máquina de Estados Finitos" (FSM) es una excelente forma manera para lograrlo.

En cualquier punto de nuestro juego, los objetos del juego estarán en un estado concreto como: Waiting, Jumping, y Running.  
Cuando ocurra algún evento o se pulse una determinada tecla será cuando se podrá cambiar a otro estado.

Podríamos organizar nuestro juego con un diagrama de estados (Nodos), representando con flechas las transiciones entre estados. En cada transición indicaremos el evento que la dispara.

Veamos un ejemplo:

![](images/states-0.png)

Por lado tendremos un nodo por cada estado, y cada nodo estado tendrá un script (código) asociado con:
* una función de entrada (`enter`),
* una función de salida (`exit`), y una lógica interna (`update`) que envíe eventos y ejecute el código del Game Loop.

Para controlar la máquina de estados, tendremos un nodo raíz que contendrá a todos los nodos estado como sus hijos.
