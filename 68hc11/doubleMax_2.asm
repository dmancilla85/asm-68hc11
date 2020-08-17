	ORG	$0000
vector	RMB	10	; Declaro un vector de 10 bytes
max	RMB	1	; Variable donde guardare el maximo
tam	RMB	2	; Variable donde guardo el tamano

	LDAB	#$9	; Tamano del archivo
	STAB	tam

	BSR	initvec ; Inicializar vector
	BSR	cargvec ; Carga el vector con valores asignados
	
	LDX	#vector ; Posiciono el vector en el inicio
	LDAA 	0,X
	BSR	strmax 	; Guarda el 1er elemento en max.

for	LDAA	0,X
	CMPA	max
	BMI	strmax
	INX
	CPX 	tam
	BRA *
	BNE	for
	
	BRA *		
********************
strmax	
	STAA	max
	CLRA
	BRA	*
	RTS
********************
initvec	
	LDX 	#vector
	CLRA
loop	STAA	0,X
	INX
	CPX	#tam
	BNE	loop
	bra *
	RTS
********************
cargvec	
	LDX 	#vector
	LDAA	#$6
	STAA	0,X
	INX
	
	LDAA	#$12
	STAA	0,X
	INX
	
	LDAA	#$62
	STAA	0,X
	INX
	
	LDAA	#$75
	STAA	0,X
	INX
	
	LDAA	#$14
	STAA	0,X
	INX
	
	LDAA	#$8
	STAA	0,X
	INX
		
	LDAA	#$91
	STAA	0,X
	INX
	
	LDAA	#$36
	STAA	0,X
	INX
	
	LDAA	#$26
	STAA	0,X
	INX
	
	LDAA	#$16
	STAA	0,X
	INX
	
	RTS
********************
	END