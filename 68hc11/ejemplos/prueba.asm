*** Prueba N1  -- 9/10/10 ***	

	ORG	$0000	; Organiza el contenido desde esta dir.

var1	RMB	1
var2	RMB	1
dir1	RMB	1	

	LDAA	#$10
	STAA	var1
	
	LDAB	#$5
	STAB	var2

	CLRB
inicio	CLRA		; Setea el acumulador A
	LDAB	var1	; Carga el acumulador B
otro	ADDA	var2	; Suma al acumulador A
	DECB		; Decrementa B
	BNE	otro	; Salta si no hay 0
	STAA	dir1	; Almacena en $00F8
	BRA	*	; Salta siempre
	END