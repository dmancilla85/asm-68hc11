

	ORG $000

start	LDAA 	$1000	; Cargo en acum. A el puerto A	
	EORA 	#$78	; PA5 + PA6 + PA4 + PA3
	STAA	$1000	; Cambia de estado los bits PA6, PA5, PA4 y PA3 de puerto A
	

	LDY #$AFF	; Tiempo

dec	DEY		; Decremento Y
	CPY #0		; Y es igual a 0?
	BNE dec		; si no es 0 decrementa otra vez

	BRA start	; vuelve a empezar...

	END

