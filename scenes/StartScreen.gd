# warning-ignore-all:RETURN_VALUE_DISCARDED
extends Node2D

signal change_scene(scene)

func _ready():
	connect("change_scene", get_node("/root/GlobalSignalRouter"), "_on_change_scene")

func _on_NewGameBtn_button_up():
	var dir = Directory.new()
	dir.remove("res://data/saved_deck.json")
	
	var file = File.new()
	if file.open("res://data/default_deck.json", File.READ) != OK:
		return
	var text = file.get_as_text()
	file.close()
	var save_file = File.new()
	if save_file.open("res://data/saved_deck.json", File.WRITE) != OK:
		return
	save_file.store_line(text)
	save_file.close()
	emit_signal("change_scene", "deck")

func _on_ContinueBtn_button_up():
	emit_signal("change_scene", "deck")
