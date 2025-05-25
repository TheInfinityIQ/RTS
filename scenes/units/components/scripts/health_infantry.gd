extends HealthBehaviour

func damage(actor: Unit, amount: float):
	actor.health_total -= abs(amount)
	
	if actor.health_total <= 0:
		destroy(actor)

func destroy(actor: Unit):
	print("BLEH")
