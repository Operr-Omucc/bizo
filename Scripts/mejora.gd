extends RigidBody2D
var speed = 200
var tipo_mejora:int
var textura_mejora: String


func _ready():
	self.add_to_group("mejora")
	if (tipo_mejora >=1 && tipo_mejora<=30):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/Mejora.png")
	if (tipo_mejora >30 && tipo_mejora<=60):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_daño.png")
	elif (tipo_mejora >60 && tipo_mejora<=90):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_velocidad.png")
	elif (tipo_mejora>90):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_fire_rate.png")


func _on_button_pressed() -> void:
		if (tipo_mejora >=1 && tipo_mejora<=30):
			gamedata.maxHealth += 10
			gamedata.health += 10
			self.queue_free()
		elif (tipo_mejora >30 && tipo_mejora<=60):
			gamedata.damage += 10
			self.queue_free()
		elif (tipo_mejora >60 && tipo_mejora<=90):
			gamedata.speed += 10
			self.queue_free()
		elif (tipo_mejora>90):
			gamedata.fire_rate /= 1.2
			self.queue_free()
