
# Godot Rust

> Enlace de interés:
> * https://godot-rust.github.io/book/gdnative/intro/setup.html
> * https://github.com/godot-rust/gdnative

## Configuración

* Instalar [GodotEngine](https://godotengine.org/).
* Comprobamos la versión que tenemos de Godot.

```console
$ godot --version
3.5.stable.official.991bb6ac7
```

* Instalar Rust mediante [rustup](https://rustup.rs/)
* Comprobamos que tenemos Rust instalado:

```console
$ rustc --version
rustc 1.65.0 (897e37553 2022-11-02)

$ cargo --version
cargo 1.65.0 (4bc8f24d3 2022-10-20)
```
* Instalamos LLVM
LLVM

El `godot-rust binding` depende de `bindgen`, el cual a su vez depende de LLVM. De modo que tenemos que tener instalado [LLVM](https://releases.llvm.org/). Clang es el frontend del compilador y LLVM (Máquina virtual de bajo nivel) es el backend.

* Comprobamos que tenemos Clang/LLVM:

```console
$ clang -v
clang version 15.0.6
```

> `bindgen` puede quejarse de que falta el binario `llvm-config`, pero no es necesario para construir la caja `gdnative`. Si ve alguna advertencia sobre `llvm-config` y falla la compilación, ¡es probable que tenga otro problema diferente!

## ¡Hola Mundo!

Vamos a crear un proyecto de prueba que simplemente muestre el mensaje "¡Hola, mundo!"

> El código está disponible en https://github.com/godot-rust/godot-rust/tree/master/examples/hello-world.

* Primero creamos un proyecto vacío usando Godot GUI.
* A continuación creamos un `crate` vacío al lado de la carpeta del proyecto de Godot: `cargo init --lib my-gdnative-lib`.
