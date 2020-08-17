
	ORG $000


tam	EQU 	&20	
vector	RMB 	tam
aux	RMB	&2
k	RMB	&1
final	RMB	&2

	CLR	vector
	JMP 	carga

inicio	LDX 	#vector
	LDY	#vector+tam
	STY	final

while1	LDAA	#&0 	; Estado de cambio (k) en 0
	STAA	k
	
while2	LDY	#vector
cond1	LDD 	0,y	; Carga posición del vector
	CPD	2,y	; Compara con el siguiente
	BGT	cambia
cambgo	
	INY
	INY
cond2	CPY	final
	BNE	cond1
	
	LDAA	#0
	CMPA	k
	BNE	go	

go
sigue	INX		; Incremento dos posiciones de memoria
	INX
	CPX	final
	BNE	while1
	 
	LDY	final
	LDD	0,y
	BRA	*
	LDX	#vector
	LDD	8,x
	BRA 	*
		
*******************
carga	LDX 	#vector
	
	LDD 	#&12
	STD 	0,x
	
	LDD 	#&18
	STD 	2,x 
	
	LDD 	#&104
	STD 	4,x 

	LDD 	#&6
	STD 	6,x

	LDD 	#&99
	STD 	8,x
	
	LDD 	#&32
	STD 	10,x

	LDD 	#&1
	STD 	12,x

	LDD 	#&63
	STD 	14,x

	LDD 	#&117
	STD 	16,x

	LDD 	#&55
	STD 	18,x

	JMP 	inicio

********************
cambia
	STD	aux	; Guarda posición actual en "aux"
	LDD	2,y	; Lee siguiente posición
	STD	0,y 	; Guarda siguiente en posición actual
	LDD	aux
	STD	2,y	; Guarda en siguiente posición contenido actual
	LDAA	#&1
	STAA	k
	JMP	cambgo

********************	
END