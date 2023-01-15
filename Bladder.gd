extends Sprite2D

var fill;
 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	material.set("fill",clamp(fill, 0.0, 1.0))
	
