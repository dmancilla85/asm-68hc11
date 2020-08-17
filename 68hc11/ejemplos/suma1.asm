                        ORG     $0000	; los datos los dejamos al principio
contador                rmb     1	; desde la posicion 0000
resultado               rmb     3	; observar que el resultado es de 3
op1                     rmb     2	; bytes (24 bits) para soportar
op2                     rmb     2	; los 17 bits del resultado


                        ORG     $8000 	; a partir de aqui va el codigo 
inicio
                        clr     resultado	; limpiamos la parte alta (H)
                        ldaa    op1+1		; cargamos la parte baja (L)
                        adda    op2+1		; sumamos Lop2 
                        staa    resultado+2	; guarda en L de resultado
                        ldaa    op1		; carga Hop1
                        adca    op2		; suma con carry Hop2
                        staa    resultado+1	; guarda en HL resultado
                        bcc     sale		; si no hay carry, se va
                        inc     resultado	; else HHresultado=1
sale                    
                        bra     sale		; terminamos
                        
                        
