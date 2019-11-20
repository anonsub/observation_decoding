(define (domain camera)
(:requirements :typing)
(:types clear - tile covered - tile)
(:predicates
	(connected ?x - tile ?y - tile)
	(at ?x - tile)
)

(:action move
	:parameters (?curpos - tile ?nextpos - tile)
	:precondition (and (at ?curpos) (connected ?curpos ?nextpos))
	:effect (and 
		(at ?nextpos)
		(not (at ?curpos))
		(increase (total-cost) 60)
	)
))