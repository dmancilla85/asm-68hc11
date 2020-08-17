                        ORG     $0000		; Primer ejemplo
contador                rmb     1		; Observar relacion entre
resultado               rmb     2		; el tamaño de los operandos
op1                     rmb     1		; y el del resultado
op2                     rmb     1		; (Hay que cargar valores de prueba)

                        ORG     $8000		; en el sim11, ver mem 8000
                        clr     resultado	; Hresultado=0
                        ldaa    op1		; A <- op1
                        adda    op2		; A = A + op2
                        staa    resultado+1	; parte baja de resultado=A
                        bcc     sale		; Si no hay carry, chau
                        inc     resultado	; Else, Hresultado++
sale                        
                        bra     sale		; se fini
                        
