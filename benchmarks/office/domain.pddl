(define (domain robot)
(:requirements :strips)
(:types object roomdoor - object room - object package - object nroom - room oroom - room npackage - package opackage - package)
(:predicates
	(armempty )
	(rloc ?loc - room)
	(in ?obj - package ?loc - room)
	(goal-in ?obj - package ?loc - room)
	(holding ?obj - package)
	(closed ?d - roomdoor)
	(door ?loc1 - room ?loc2 - room ?d - roomdoor)
)

(:functions (total-cost) )

(:action pickup
	:parameters (?obj - package ?loc - room)
	:precondition (and (rloc ?loc) (in ?obj ?loc) (not (goal-in ?obj ?loc)) (armempty ))
	:effect (and 
		(not (armempty ))
		(holding ?obj) (increase (total-cost) 1)
	)
)

(:action putdown
	:parameters (?obj - package ?loc - room)
	:precondition (and (rloc ?loc) (holding ?obj) (goal-in ?obj ?loc))
	:effect (and 
		(not (holding ?obj))
		(armempty ) (increase (total-cost) 1)
	)
)

(:action move-holding
	:parameters (?loc1 - room ?loc2 - room ?d - roomdoor ?obj - package)
	:precondition (and (rloc ?loc1) (door ?loc1 ?loc2 ?d) (not (closed ?d)) (holding ?obj) (in ?obj ?loc1))
	:effect (and 
		(rloc ?loc2)
		(not (rloc ?loc1))
		(not (in ?obj ?loc1))
		(in ?obj ?loc2) (increase (total-cost) 1)
	)
)

(:action move
	:parameters (?loc1 - room ?loc2 - room ?d - roomdoor)
	:precondition (and (rloc ?loc1) (door ?loc1 ?loc2 ?d) (not (closed ?d)) (armempty ))
	:effect (and 
		(rloc ?loc2)
		(not (rloc ?loc1)) (increase (total-cost) 1)
	)
)

(:action open
	:parameters (?loc1 - room ?loc2 - room ?d - roomdoor)
	:precondition (and (rloc ?loc1) (door ?loc1 ?loc2 ?d) (closed ?d))
	:effect (and 
		(not (closed ?d)) (increase (total-cost) 1)
	)
))
