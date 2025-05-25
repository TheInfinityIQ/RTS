extends DetectBehaviour

func detect(actor: Unit, detected: Node2D):
	if detected is not Unit:
		return
	scan(actor, detected)

func scan(actor: Unit, detected: Unit):
	if detected.team != actor.team:
		actor.enemies_in_range[detected.id] = detected
