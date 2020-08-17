
	ORG	$0000

vector	RMB 	&20
ceros 	RMB	&1
multis 	RMB 	&1
cant	EQU	&20
diviso	RMB	&2

	BSR	inicio
	BSR	cargavec

	LDY	#vector
	LDX	#diviso

loop	LDD 	0,y ; CORREGIRRRR
	CPD 	#&0
	BEQ	cero
	
div	LDX	#$4
	FDIV
	CPD	#&0
	BEQ	esmulti

inc	INY
	INY	
	CPY	#vector+cant
	BNE	loop
	bra *

	LDAA	multis
	LDAB	ceros
	bra	*


****************************

inicio	
	LDAA	#&0
	STAA 	ceros
	STAA	multis
	
	LDD	#&4
	STD	diviso	
	RTS
****************************

cero	
	LDAA	ceros
	INCA
	STAA	ceros
	LDD	0,y
	JMP 	div
****************************

esmulti
	LDAA	multis
	INCA	
	STAA	multis
	LDX	0,y
	JMP 	inc
****************************

cargavec	
	LDX	#vector
	LDD	#&36		;fila 1
	STD	0,x

	LDD	#&53		;fila 2
	STD	2,x	
	
	LDD	#&11		;fila 3
	STD	4,x
	
	LDD	#&8		;fila 4
	STD	6,x
	
	LDD	#&12		;fila 5
 	STD	8,x
	
	LDD	#&0		;fila 6
	STD	10,x
	
	LDD	#&36		;fila 7
	STD	12,x
	
	LDD	#&0		;fila 8
	STD	14,x
	INX
		
	LDD	#&9		;fila 9
	STD	16,x
	INX
	
	LDD	#&22		;fila 10
	STD	18,x

	CLRA
	CLRB

	RTS

***************************
END