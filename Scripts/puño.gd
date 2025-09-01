extends Area2D

@onready var brazo = get_parent().get_parent().get_parent()
@onready var damage: int

func _ready():
	self.add_to_group("brazo")
	
func _on_body_entered(body: Node2D) -> void:
	if brazo.puede_golpear and body.is_in_group("enemigo") :
		var knockback_direction = (body.global_position - global_position).normalized()
		AudioManager.play_golpe()
		body.apply_knockback(knockback_direction, 250.0, 0.2)
