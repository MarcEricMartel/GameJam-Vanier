extends CharacterBody2D

@export var MAX_SPEED = 300.0;
@export var ACCELERATION = 1000.0;
@export var FRICTION = 1500.0;
@export var HP = 20;
@export var DAMAGE = 34;
@export var COOLDOWN = 2;

@onready var raycast = $RayCast2D;
@onready var cooldown_timer = $CooldownTimer;

var player = null;
var is_on_cooldown = false;

func _ready():
	add_to_group("enemies");

func _physics_process(delta):
	if player == null:
		return
	
	var vec_to_player = player.global_position - global_position;
	vec_to_player = vec_to_player.normalized();
	raycast.rotation = atan2(vec_to_player.y,vec_to_player.x);
	velocity = velocity.move_toward(vec_to_player * MAX_SPEED,ACCELERATION*delta);
	move_and_slide();
	
	if raycast.is_colliding():
		var coll = raycast.get_collider();
		if coll.name == "Player":
			attack(coll);

func attack(collider):
	if !is_on_cooldown:
		is_on_cooldown = true;
		cooldown_timer.start(COOLDOWN);
		collider.take_damage(DAMAGE);

func take_damage(damage):
	HP = HP - damage;
	if HP <= 0:
		kill();

func kill():
	queue_free();

func set_player(p):
	player = p;

func _on_cooldown_timer_timeout():
	is_on_cooldown = false;
