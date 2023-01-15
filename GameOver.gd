extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	$Restart.visible = true;
	$Quit.visible = true;
	
func _on_restart_pressed():
	get_tree().change_scene_to_file("res://Levels/level.tscn");


func _on_quit_pressed():
	get_tree().quit();

func _on_itwasalladream_timeout():
	$IWAaD.visible = true;
