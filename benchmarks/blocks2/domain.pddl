(define (domain blocks)
(:requirements :strips)
(:types object block - object robot - object nrobot - robot orobot - robot)
(:predicates
	(on ?o1 - block ?o2 - block)
	(ontable ?o1 - block)
	(clear ?o1 - block)
	(handempty)
	(holding ?r - robot ?o1 - block)
)

(:functions (total-cost))

(:action pick-up
	:parameters (?r - robot ?o1 - block)
	:precondition (and (clear ?o1) (ontable ?o1) (handempty))
	:effect (and 
		(not (ontable ?o1))
		(not (clear ?o1))
		(not (handempty))
		(holding ?r ?o1) (increase (total-cost) 1)
	)
)

(:action put-down
	:parameters (?r - robot ?o1 - block)
	:precondition (and (holding ?r ?o1))
	:effect (and 
		(not (holding ?r ?o1))
		(clear ?o1)
		(handempty)
		(ontable ?o1) (increase (total-cost) 1)
	)
)

(:action stack
	:parameters (?r - robot ?o1 - block ?o2 - block)
	:precondition (and (holding ?r ?o1) (clear ?o2))
	:effect (and 
		(not (holding ?r ?o1))
		(not (clear ?o2))
		(clear ?o1)
		(handempty)
		(on ?o1 ?o2) (increase (total-cost) 1)
	)
)

(:action unstack
	:parameters (?r - robot ?o1 - block ?o2 - block)
	:precondition (and (on ?o1 ?o2) (clear ?o1) (handempty))
	:effect (and 
		(holding ?r ?o1)
		(clear ?o2)
		(not (clear ?o1))
		(not (handempty))
		(not (on ?o1 ?o2)) (increase (total-cost) 1)
	)
))
