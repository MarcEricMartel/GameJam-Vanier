extends CharacterBody2D

@export var MAX_SPEED = 600.0;
@export var ACCELERATION = 2000.0;
@export var FRICTION = 3000.0;

func _physics_process(delta):
	var input_vector = get_input_vector();
	apply_movement(input_vector, delta);
	apply_friction(input_vector, delta);
	move_and_slide();

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
