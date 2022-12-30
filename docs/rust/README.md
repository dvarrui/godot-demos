
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

## Rust

* Creamos un `crate` vacío: `cargo init --lib my-gdnative-lib`.
* Editar el fichero `Cargo.toml` del proyecto Rust para añadir el "crate" `cdylib` y la dependencia con `gdnative`:

```
[lib]
crate-type = ["cdylib"]

[dependencies]
gdnative = "0.10"
```

* Reemplazar el contenido de `src/lib.rs` con lo siguiente:

```rust
use gdnative::prelude::*;

#[derive(NativeClass)]
#[inherit(Node)]
struct HelloWorld;

#[methods]
impl HelloWorld {
    fn new(_owner: &Node) -> Self {
        HelloWorld
    }

    #[method]
    fn _ready(&self) {
        godot_print!("hello, world.")
    }
}

fn init(handle: InitHandle) {
    handle.add_class::<HelloWorld>();
}

godot_init!(init);
```

* `cd my-gdnative-lib`, `cargo build`. Con esto construimos la librería del proyecto Rust que tenemos en `my-gdnative-lib/target/debug/libmy_gdnative_lib...`.

## Godot

NOTA: _Es mejor tener el proyecto de Rust y el proyecto Godot en carpetas separadas_.

* Creamos un proyecto vacío usando Godot GUI (`my-godot-project`).
* Copiamos `my-gdnative-lib/target/debug/libmy_gdnative_lib.so` (o crear un enlace simbólico) del proyecto de Rust dentro de la carpeta del proyecto de Godot.
* En el editor de Godot, vamos al panel `Inspector -> Agregar Nuevo recurso -> GDNativeLibrary`.

----
REVISAR!!!
----

    * Para la plataforma `Linux`, seleccionar el fichero `res://libmy_gdnative_lib.so`.
* Lo grabamos como `gdnativelibrary.tres`
    * Entry: `res://libmy_gdnative_lib.so`
    * Path: `res://gdnativelibrary.tres`
    * En Name ponemos `HelloWorld`
    * Grabamos

Ahora, la clase HelloWorld se puede agregar a cualquier nodo:
* Clic en el botón "agregar script".
* Seleccione "NativeScript" como idioma y establezca el nombre de la clase en HelloWorld.
* Seleccione el recurso NativeScript en el Inspector
* Haga clic en el campo de la biblioteca y apunte al recurso GDNativeLibrary que creó anteriormente.
