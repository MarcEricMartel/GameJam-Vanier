extends CharacterBody2D

@export var MAX_SPEED = 400.0;
@export var ACCELERATION = 2000.0;
@export var FRICTION = 3000.0;
@export var HP = 100;
@export var STARTING_WEAPON : PackedScene;

@onready var raycast = $RayCast2D;
var current_weapon = null;
var weapons = [null,null,null];

func _ready():
	call_deferred("call_set_player");
	weapons[0] = STARTING_WEAPON.instantiate();
	weapons[1] = load("res://Weapons/shotgun.tscn").instantiate();
	current_weapon = weapons[0];
	raycast.add_child(current_weapon);

func _physics_process(delta):
	var input_vector = get_input_vector();
	apply_movement(input_vector, delta);
	apply_friction(input_vector, delta);
	move_and_slide();
	
	var look_vec = get_global_mouse_position() - global_position;
	raycast.rotation = atan2(look_vec.y,look_vec.x);
	
	if Input.is_action_pressed("shoot"):
		attack();
	
	if Input.is_action_just_pressed("weapon_01"):change_weapon(0);
	if Input.is_action_just_pressed("weapon_02"):change_weapon(1);
	if Input.is_action_just_pressed("weapon_03"):change_weapon(2);
	

func change_weapon(position):
	if weapons[position]:
		raycast.remove_child(current_weapon);
		current_weapon = weapons[position];
		raycast.add_child(current_weapon);

func attack():
	if current_weapon: current_weapon.fire(velocity);

func take_damage(damage):
	HP = HP - damage;
	if HP <= 0:
		kill();

func kill():
	get_tree().reload_current_scene();

func get_input_vector():
	var input_vector = Vector2.ZERO;
	input_vector.x = Input.get_action_strength("move_east") - Input.get_action_strength("move_west");
	input_vector.y = Input.get_action_strength("move_south") - Input.get_action_strength("move_north");
	return input_vector.normalized();

func apply_movement(input_vector, delta):
	if(input_vector != Vector2.ZERO):
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta);
	

func apply_friction(input_vector,delta):
	if(input_vector == Vector2.ZERO):
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta);

func call_set_player():
	get_tree().call_group("enemies", "set_player",self);

func _on_area_2d_area_entered(area):
	$"../School_Snare".volume_db(-6);
	$"../School_BDClave".volume_db(-6);
	$"../School_Bass".volume_db(-6);
	$"../School_Flute".volume_db(-6);
	$"../School_Brass".volume_db(-6);


func _on_area_2d_area_exited(area):
	$"../School_Snare".volume_db(-80);
	$"../School_BDClave".volume_db(-80);
	$"../School_Bass".volume_db(-80);
	$"../School_Flute".volume_db(-80);
	$"../School_Brass".volume_db(-80);
