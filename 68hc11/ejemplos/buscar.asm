	ORG	$0000
vector	RMB	10
finvec	EQU 	vector+19
clave	EQU	18
pos	RMB	2
	
	BSR 	cargar
	BSR 	buscar
	BRA	*

;-------------------------
buscar	
	LDX	#vector
	LDY	#0

loop	LDAA	0,X
	CMPA	#clave
	BEQ	existe
sigue	INX
	CPX	#finvec
	
	BNE	loop
		

fin	LDD	pos
	bra	*
	RTS			
;-----------------------
existe	
	INY
	CPY	#1
	BEQ	guarda
	JMP 	sigue
guarda	STX	pos
	JMP	sigue
;-----------------------
cargar	
	LDX 	#vector
	LDAA	#84
	STAA	0,X

	INX
	LDAA	#1
	STAA	0,X

	INX
	LDAA	#26
	STAA	0,X
	
	INX
	LDAA	#11
	STAA	0,X

	INX
	LDAA	#84
	STAA	0,X
	
	INX
	LDAA	#18
	STAA	0,X

	INX
	LDAA	#53
	STAA	0,X
	
	INX
	LDAA	#22
	STAA	0,X

	INX
	LDAA	#71
	STAA	0,X
		
	INX
	LDAA	#38
	STAA	0,X

	INX
	LDAA	#1
	STAA	0,X

	INX
	LDAA	#26
	STAA	0,X
	
	INX
	LDAA	#11
	STAA	0,X

	INX
	LDAA	#84
	STAA	0,X
	
	INX
	LDAA	#18
	STAA	0,X

	INX
	LDAA	#53
	STAA	0,X
	
	INX
	LDAA	#18
	STAA	0,X
	
	RTS