extends Node2D

@export var PROJECTILE : PackedScene;
@export var COOLDOWN = .5;
@export var SPREAD = 10;

@onready var raycast = $RayCast2D;
@onready var cooldown_timer = $CooldownTimer;

var is_on_cooldown = false;

func fire():
	if !is_on_cooldown:
		is_on_cooldown = true;
		cooldown_timer.start(COOLDOWN);
		var current_projectile : Area2D = PROJECTILE.instantiate();
		get_node("/root").add_child(current_projectile);
		
		current_projectile.transform = raycast.get_global_transform()
		current_projectile.launch((get_global_mouse_position() - global_position).normalized());


func _on_cooldown_timer_timeout():
	is_on_cooldown = false;
