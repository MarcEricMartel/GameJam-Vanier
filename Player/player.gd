extends CharacterBody2D

@export var MAX_SPEED = 400.0;
@export var ACCELERATION = 2000.0;
@export var FRICTION = 3000.0;
@export var HP = 100;

@onready var raycast = $RayCast2D;
@onready var sprite = $AnimatedSprite2D;
@onready var bladderUI = $Bladder;

var animation_count = 0;

var current_weapon = null;
var weapons = [null,null,null];

func _ready():
	call_deferred("call_set_player");

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
	if current_weapon: 
		current_weapon.fire(velocity);

func take_damage(damage):
	if sprite.animation != "damage":
		HP = HP - damage;
		sprite.play("damage");
		bladderUI.material.set("fill",clamp((100.0 - HP) / 100.0, 0.0, 1.0));
		if HP <= 0:
			kill();

func pickup(item):
	if item.Type == "weapon":
		for n in 3:
			if !weapons[n]:
				weapons[n] = item.Item.instantiate();
				change_weapon(n);
				
				if n == 0 :
					sprite.play("shirt");
				if n == 1 :
					sprite.play("pants");
				if n == 2 :
					sprite.play("shoes");
				
				return;

func kill():
	get_tree().change_scene_to_file("res://game_over.tscn");

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

func _on_animated_sprite_2d_animation_finished():
	if sprite.animation == "damage":
		animation_count+=1;
		if animation_count > 3:
			animation_count = 0;
			sprite.play("default");
