extends CharacterBody2D

#Funcion para eliminar personaje + deteccion de colision con bala
func _on_area_2d_body_entered(body):
	if body.name=="Personaje":
		body.queue_free()
	elif body.is_in_group("bala"):
		queue_free()
		body.queue_free()
