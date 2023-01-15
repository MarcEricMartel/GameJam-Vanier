extends Area2D

@export var Type : String;
@export var Item : PackedScene;

func _on_body_entered(body):
	if body.name == "Player":
		pickup_routine(body);

func pickup_routine(player):
	player.pickup(self);
	queue_free();
