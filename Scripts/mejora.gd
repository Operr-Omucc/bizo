extends RigidBody2D
var speed = 200
var tipo_mejora:int
var textura_mejora: String
@onready var button: Button = $Button

func _ready():
	self.add_to_group("mejora")
	if (tipo_mejora >=1 && tipo_mejora<=30):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/Mejora.png")
	if (tipo_mejora >30 && tipo_mejora<=60):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_daño.png")
	elif (tipo_mejora >60 && tipo_mejora<=90):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_velocidad.png")
	elif (tipo_mejora>90 && tipo_mejora<=95):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_fire_rate.png")
	elif (tipo_mejora>95 && tipo_mejora<=100):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_armadura.png")

func _on_button_pressed() -> void:
		if (tipo_mejora >=1 && tipo_mejora<=30):
			gamedata.maxHealth += 4
			gamedata.health += 4
			self.queue_free()
		elif (tipo_mejora >30 && tipo_mejora<=60):
			gamedata.damage += 2
			self.queue_free()
		elif (tipo_mejora >60 && tipo_mejora<=90):
			gamedata.speed += 2
			self.queue_free()
		elif (tipo_mejora>90 && tipo_mejora<=91):
			gamedata.fire_rate /= 1.01
			self.queue_free()
		elif (tipo_mejora>91 && tipo_mejora<=100):
			gamedata.armor += 3
			self.queue_free()
