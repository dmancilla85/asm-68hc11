	ORG	$0015
vector	RMB	&20	; Declara un vector de 20 bytes
max	RMB	&2	; Variable donde guarda el maximo
tam	EQU	&18	; Variable donde guarda el tamaño

	CLR	vector 	; Inicializa vector
	
	BSR	cargvec ; Carga el vector con valores asignados
	
	LDX	#vector ; Posiciona el indice en el inicio del vector

	LDD	0,X		
	BSR	strmax 	; Guarda el 1er elemento en max.

for	LDD	0,X	; Carga posición indicada por el indice
	CPD	max	; Compara con el máximo  D - max
	BGT	setmax	; si D > max => D - max > 0
sigue	
	INX		; Por ser variables de 2bytes, incremento 2 posiciones IX
	INX
	CPX	#vector+tam
	BNE	for

	LDD	max
	BRA	*

setmax	STD	max
	JMP	sigue		
********************

strmax	
	LDD	0,X
	STD	max	
	RTS

********************
cargvec	
	LDX 	#vector
	
	LDD	#&53	
	STD	0,X		
	
	LDD	#&1329
	STD	2,X
	
	LDD	#&621
	STD	4,X
		
	LDD	#&753
	STD	6,X
	
	LDD	#&11
	STD	8,X
	
	LDD	#&863
	STD	10,X
		
	LDD	#&6340
	STD	12,X
	
	LDD	#&3161
	STD	14,X
	
	LDD	#&230
	STD	16,X
	
	LDD	#&160
	STD	18,X

	RTS
********************
	END