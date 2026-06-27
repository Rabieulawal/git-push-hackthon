extends Area2D

var scene_path = "res://menu.tscn"

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		# Changed target_scene_path to scene_path to match your variable above
		get_tree().change_scene_to_file(scene_path)
