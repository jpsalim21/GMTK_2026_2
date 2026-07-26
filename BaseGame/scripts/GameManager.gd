extends Node

signal time_scale_changed(scale : float)
var time_scale : float:
	set(value):
		time_scale = value
		Engine.time_scale = value
		time_scale_changed.emit(time_scale)
