(define (domain intrusion-detection)
	(:requirements :strips :typing)
	(:types host)
	(:predicates
		(recon-performed ?h - host)
		(broke-into ?h - host)
		(deleted-logs ?h - host)
		(deleted-logs-as-root ?h - host)
		(modified-files ?h - host)
		(modified-files-as-root ?h - host)
		(access-obtained ?h - host)
		(root-access-obtained ?h - host)
		(files-downloaded ?h - host)
		(files-downloaded-as-root ?h - host)
		(information-gathered ?h - host)
		(vandalized ?h - host)
		(data-stolen-from ?h - host)
		(dummy)
	)

(:functions (total-cost))

	(:action recon
		:parameters (?h - host)
		:precondition (and (dummy))
		:effect (and (recon-performed ?h)(increase (total-cost) 1))
	)
	(:action information-gathering
		:parameters (?h - host)
		:precondition (and (recon-performed ?h))
		:effect (and (information-gathered ?h)(increase (total-cost) 1))
	)
	(:action break-into
		:parameters (?h - host)
		:precondition (and (recon-performed ?h))
		:effect (and (access-obtained ?h)(increase (total-cost) 1)) 
	)
	(:action gain-root
		:parameters (?h - host)
		:precondition (and (access-obtained ?h))
		:effect (and (root-access-obtained ?h)(increase (total-cost) 1))
	)

	(:action modify-files
		:parameters (?h - host)
		:precondition (and (access-obtained ?h))
		:effect (and (modified-files ?h)(increase (total-cost) 1))
	)
	(:action modify-files-as-root
		:parameters (?h - host)
		:precondition (and (root-access-obtained ?h))
		:effect (and (modified-files-as-root ?h)(increase (total-cost) 1))
	)
	(:action clean
		:parameters (?h - host)
		:precondition (and (access-obtained ?h))
		:effect (and (deleted-logs ?h)(increase (total-cost) 1))
	)
	(:action clean-as-root
		:parameters (?h - host)
		:precondition (and (root-access-obtained ?h))
		:effect (and (deleted-logs-as-root ?h)(increase (total-cost) 1))
	)
	(:action vandalize
		:parameters (?h - host)
		:precondition (and (modified-files ?h) (deleted-logs ?h))
		:effect (and (vandalized ?h)(increase (total-cost) 1))
	)
	(:action vandalize-as-root
		:parameters (?h - host)
		:precondition (and (modified-files-as-root ?h) (deleted-logs-as-root ?h))
		:effect (and (vandalized ?h)(increase (total-cost) 1))
	)	
	(:action download-files
		:parameters (?h - host)
		:precondition (and (access-obtained ?h))
		:effect (and (files-downloaded ?h)(increase (total-cost) 1))
	)
	(:action download-files-as-root
		:parameters (?h - host)
		:precondition (and (root-access-obtained ?h))
		:effect (and (files-downloaded-as-root ?h)(increase (total-cost) 1))
	)
	(:action steal-data
		:parameters (?h - host)
		:precondition (and (files-downloaded ?h) (deleted-logs ?h))
		:effect (and (data-stolen-from ?h)(increase (total-cost) 1))
	)
	(:action steal-data-as-root
		:parameters (?h - host)
		:precondition (and (files-downloaded-as-root ?h) (deleted-logs-as-root ?h))
		:effect (and (data-stolen-from ?h)(increase (total-cost) 1))
	)
)
