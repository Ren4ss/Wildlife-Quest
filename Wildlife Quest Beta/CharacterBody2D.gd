extends CharacterBody2D
var speed = 80

var gravity = 980
var dirx
var diry
enum {IDLE, WALK, HIT, DIE}
var estado_atual = 0
var inicio_de_estado = true
var anim_fin = false
var jogador_andando = false
var alcance_ataque = false

func _physics_process(delta):
	diry = Input.get_axis("cima", "baixo")
	dirx = Input.get_axis("esquerda", "direita")

	if Input.is_action_just_pressed("dash"):
		velocity *= 10 
		
	if Input.is_action_pressed("corre"):
		velocity *= 2 

	match estado_atual:
		IDLE:
			idle_state(delta)
		WALK:
			walk_state(delta)
		HIT:
			hit_state(delta)
		DIE:
			die_state(delta)

func set_state(novo_estado):
	if novo_estado != estado_atual:
		estado_atual = novo_estado
		inicio_de_estado = true
		anim_fin = false

func idle_state(delta):
	$AnimatedSprite2D.play("Idle")
	move(0,delta)
	if jogador_andando:
		set_state(WALK)


func walk_state(delta):
	$AnimatedSprite2D.play("down")
	move(200, delta)
	if not dirx && not diry:
		set_state(IDLE)

func hit_state(delta):
	pass

func die_state(delta):
	pass

func move(speed, delta):
	jogador_andando = true
	if dirx:
		velocity.x = dirx * speed
		
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if diry:
		velocity.y = diry * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()
