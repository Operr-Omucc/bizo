extends RigidBody2D
var speed = 200
var tipo_mejora:int
var textura_mejora: String

func _ready():
	self.add_to_group("mejora")
	if tipo_mejora==1:
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/Mejora.png")
	if tipo_mejora==2:
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_daño.png")
	elif tipo_mejora==3:
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_velocidad.png")


func _on_button_pressed() -> void:
		if (tipo_mejora==1):
			gamedata.maxHealth += 10
			gamedata.health += 10
			self.queue_free()
		elif (tipo_mejora==2):
			gamedata.damage += 10
			self.queue_free()
		elif (tipo_mejora==3):
			gamedata.speed += 10
			self.queue_free()
