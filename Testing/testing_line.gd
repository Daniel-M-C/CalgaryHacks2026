@tool
extends Line2D

@export var glyph : GlyphArr  :
	set(val) :
		glyph = val
		#if Engine.is_editor_hint():
		reset()
@export var part := 0 :
	set(val) :
		part = val
		#if Engine.is_editor_hint():
		reset()

@onready var counter_max := .2
@onready var counter := .2 
func _ready() -> void:
	reset()

func reset() :
	print('aaa')
	points = glyph.arrs[part]
	
func _process(delta: float) -> void:
	#counter -= delta
	#if counter <= 0 :
		#reset()
		#counter = counter_max
	pass
