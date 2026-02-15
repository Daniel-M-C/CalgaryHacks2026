extends Node3D

const FIRE_AMBIANCE = preload("uid://bxrcwp0v7dp50")
const RUINED = preload("uid://cw06is6uol1un")


func switch():
	$AudioStreamPlayer.stream = RUINED
	$AudioStreamPlayer2.stream = FIRE_AMBIANCE
	$AudioStreamPlayer.playing = true
	$AudioStreamPlayer2.playing = true
	pass
