extends Node2D

@export var PROJECTILE : PackedScene;
@export var PROJECTILE_AMOUNT = 1;
@export var COOLDOWN = .5;
@export var SPREAD = .2;
@export var RANGE_MOD = 0;

@onready var raycast = $RayCast2D;
@onready var cooldown_timer = $CooldownTimer;

var is_on_cooldown = false;
var rng = RandomNumberGenerator.new();

func _ready():
	rng.randomize();

func fire(wielder_velocity):
	if !is_on_cooldown:
		is_on_cooldown = true;
		cooldown_timer.start(COOLDOWN);
		
		for i in PROJECTILE_AMOUNT:
			var current_projectile : Area2D = PROJECTILE.instantiate();
			get_node("/root").add_child(current_projectile);
		
			current_projectile.transform = raycast.get_global_transform() ;
			current_projectile.transform.origin += (get_global_mouse_position() - global_position).normalized() * (rng.randf() * RANGE_MOD);
			current_projectile.launch((get_global_mouse_position() - global_position).rotated(rng.randf_range(SPREAD,-SPREAD)).normalized(), wielder_velocity);


func _on_cooldown_timer_timeout():
	is_on_cooldown = false;
