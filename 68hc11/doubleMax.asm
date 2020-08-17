
	ORG 	$0000
vector	RMB 	&20		;Vector de 10 palabras de 2bytes
max	RMB 	&2		;Variable donde guardo el máximo
tam	EQU	&20

	BSR 	initvec		;Inicializo el vector
	BSR 	cargavec	;Carga el vector

	LDX 	#vector		;Coloco IX en el inicio del vector
	LDD 	0,x		
	BSR	strmax		;Guarda el 1ª elemento en "max"

for	LDD	0,x
	CPD	max
	BGT	setmax		;Si D > max  --> max = D
	
sigue	INX
	INX
	CPX	#vector+tam
	BNE	for

	LDD	max		;Muestra el máximo en D
	BRA	*


**************************

setmax	STD	max		;Almaceno en max
	JMP	sigue


**************************

strmax	
	LDD	0,x
	STD	max
	RTS


**************************

initvec	
	LDX	#vector
	LDD	#&0
loop	STD	0,x
	INX
	INX	
	CPX	#vector+tam
	BNE	loop
	RTS


**************************

cargavec	
	LDX	#vector
	LDD	#&30053		;fila 1
	STD	0,x
	INX
	INX

	LDD	#&5213		;fila 2
	STD	0,x
	INX
	INX	
	
	LDD	#&1127		;fila 3
	STD	0,x
	INX
	INX
	
	LDD	#&9		;fila 4
	STD	0,x
	INX
	INX
	
	LDD	#&12732		;fila 5
 	STD	0,x
	INX
	INX
	
	LDD	#&574		;fila 6
	STD	0,x
	INX
	INX
	
	LDD	#&113		;fila 7
	STD	0,x
	INX
	INX
	
	LDD	#&1026		;fila 8
	STD	0,x
	INX
	INX
		
	LDD	#&9621		;fila 9
	STD	0,x
	INX
	INX
	
	LDD	#&21172		;fila 10
	STD	0,x

	CLRA
	CLRB

	RTS
**************************
END	