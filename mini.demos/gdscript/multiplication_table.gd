#!/usr/bin/env -S godot -s
extends SceneTree

func _init():
    var number = 3

    for i in range(1, 11):
        print(" %2d * %2d = %3d" % [i, number, i*number])
    quit()
