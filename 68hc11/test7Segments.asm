
	ORG	$000
	
	LDAA	#$FF
	STAA	$1004

move	BSR	timer
	DECA
	STAA	$1004
	BNE	move
	BRA	*
	
timer	
	LDY #$FF        ; Realizar una pausa
dec
	DEY
	CPY #0        
	BNE dec
	RTS

	END