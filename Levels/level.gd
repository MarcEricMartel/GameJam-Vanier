extends Node2D

@onready var doors = $Doors;

var mimic_count = 0;

func _ready():
	pass 

func _process(delta):
	if mimic_count >= 4 : 
		doors.remove_child($Doors/Bathroom_Bottom);
		doors.remove_child($Doors/Cafeteria);

func _on_pickable_t_shirt_picked():
	doors.remove_child($Doors/FrontDoor_Left);
	doors.remove_child($Doors/FrontDoor_Right);


func _on_outside_enemy_is_killed():
	doors.remove_child($Doors/ClassDoor);


func _on_shoes_picked():
	doors.remove_child($Doors/Locker);


func _on_mimic_01_is_killed():
	mimic_count += 1;


func _on_mimic_03_is_killed():
	mimic_count += 1;


func _on_mimic_04_is_killed():
	mimic_count += 1;


func _on_mimic_02_is_killed():
	mimic_count += 1;

func _on_pants_picked():
	doors.remove_child($Doors/Bathroom_Top);


func _on_gym_enemy_05_is_killed():
	doors.remove_child($Doors/Gym);
	doors.remove_child($Doors/BackDoor_Left);
	doors.remove_child($Doors/BackDoor_Right);
	


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		win();
		
func win():
	get_tree().change_scene_to_file("res://YouWin.tscn");
