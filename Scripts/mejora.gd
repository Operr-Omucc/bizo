extends RigidBody2D
var speed = 200
var tipo_mejora:int
var textura_mejora: String
@onready var button: Button = $Button


func _ready():
	self.add_to_group("mejora")
	if (tipo_mejora >=1 && tipo_mejora<=30):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/Mejora.png")
		
	elif (tipo_mejora >30 && tipo_mejora<=60):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_daño.png")
		
	elif (tipo_mejora >60 && tipo_mejora<=90):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_velocidad.png")
		
	elif (tipo_mejora>90 && tipo_mejora<=95):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_fire_rate.png")
		
	elif (tipo_mejora>95 && tipo_mejora<=92):
		$Sprite2D.texture=ResourceLoader.load("res://Sprites/mejora_armadura.png")

func _on_button_pressed() -> void:
		if (tipo_mejora >=1 && tipo_mejora<=30):
			mejora_vida()
			self.queue_free()
			
		elif (tipo_mejora >30 && tipo_mejora<=60):
			mejora_fuerza()
			self.queue_free()
			
		elif (tipo_mejora >60 && tipo_mejora<=90):
			mejora_velocidad()
			self.queue_free()
			
		elif (tipo_mejora>90 && tipo_mejora<=91):
			mejora_firerate()
			self.queue_free()
			
		elif (tipo_mejora>91 && tipo_mejora<=92):
			mejora_armadura()
			self.queue_free()
			
func mejora_fuerza():
	gamedata.damage += 2
	
func mejora_velocidad():
	gamedata.speed += 2
	
func mejora_armadura():
	gamedata.armor += 3
	self.queue_free()
	
func mejora_firerate():
	gamedata.fire_rate /= 1.01

func mejora_vida():
	gamedata.maxHealth += 4
	gamedata.health += 4
