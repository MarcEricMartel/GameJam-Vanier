extends Node2D

@onready var doors = $Doors;

func _ready():
	pass 

func _process(delta):
	pass

func _on_pickable_t_shirt_picked():
	doors.remove_child($Doors/FrontDoor_Left);
	doors.remove_child($Doors/FrontDoor_Right);


func _on_outside_enemy_is_killed():
	doors.remove_child($Doors/ClassDoor);


func _on_shoes_picked():
	doors.remove_child($Doors/Bathroom_Top);
