extends CharacterBody3D

var speed
const caminar_vel = 5.0
const sprint_vel = 8.0
const velocidad_salto = 4.5
const SENSIBILIDAD = 0.01
var sprint: bool = false

#variables de movimiento de camara
const bob_freq = 2.0
const bob_amp = 0.08
var t_bob = 0.0

#FOV
const fov_base = 75.0
const fov_cam = 1.5

var gravity = 9.8

@onready var cabeza = $cabeza
@onready var camara = $cabeza/Camera3D
@onready var anim_arma = $cabeza/Camera3D/pistola/AnimationPlayer
@onready var barril_arma = $cabeza/Camera3D/pistola/RayCast3D

var bala = load("res://bizo3ed/bala.gd")
var instance



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cabeza.rotate_y(-event.relative.x * SENSIBILIDAD)
		camara.rotate_x(-event.relative.y * SENSIBILIDAD)
		camara.rotation.x = clamp(camara.rotation.x, deg_to_rad(-40), deg_to_rad(60))
		
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	speed = caminar_vel

func _physics_process(delta: float) -> void:
	#agrega gravedad.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	#maneja salto (puede ser que lo quite a la mierda)
	if Input.is_action_just_pressed("Salto") and is_on_floor():
		velocity.y = velocidad_salto
		
	if Input.is_action_just_pressed("Dash") && sprint==false:
		speed = sprint_vel
		sprint=true
	elif Input.is_action_just_pressed("Dash") && sprint==true:
		speed = caminar_vel 
		sprint=false
	
	#consigue la direccion y maneja la aceleracion y desaceleracion.
	var input_dir = Input.get_vector("Izquierda", "Derecha", "Arriba", "Abajo")
	var direction = (cabeza.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		velocity.x = lerp(velocity.x,direction.x * speed, delta * 2.0)
		velocity.z = lerp(velocity.z,direction.z * speed, delta * 2.0)
		
	#movimiento cabeza
	t_bob += delta * velocity.length() * float(is_on_floor())
	camara.transform.origin = _headbob(t_bob)
	move_and_slide()

	# FOV
	var velo_clamped = clamp(velocity.length(), 0.5, sprint_vel * 2 )
	var fov_obj = fov_base + fov_cam * velo_clamped
	camara.fov = lerp(camara.fov, fov_obj, delta * 8.0)
	
	# Jugador disparo
	if Input.is_action_pressed("Disparo"):
		if !anim_arma.is_playing():
			anim_arma.play("3dgun_anim")
			instance = bala.instantiate()
			instance.position = barril_arma.global_position
			instance.transform.basis = barril_arma.global_transform.basis
			get_parent().add_child(instance)
	
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * bob_freq) * bob_amp
	pos.x = cos(time * bob_freq / 2) * bob_amp
	return pos
