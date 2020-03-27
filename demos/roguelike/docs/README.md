
* Instalar Godot 3
* Descargar Assets de la web de Kenney

---
# Actor Player

Estructura de directorios:
```
> tree -d
.
├── actor
│   └── player
├── assets
│   └── tiles
├── docs
└── level
```

* Crear scena/nodos de actor/player
    * player(knimatic)
    * sprite imagen
    * shape círculo
* Crear mapa entrada de teclado
* Crear script
* F6 probar escena
* F5 probar juego

---
# Level 1 mapa 1

Scene tiles:
* Crear una escena con todos los tiles del mapa.
* Cada tile será: sprite -> body -> shape.
Scene map1:
* Escena que representa el primer nivel o mapa.
* Node2D con:
    * tilemap de (tiles)
    * actor/player
