                        ORG     $0000	; el signo $ es para hexadecimal
contador                rmb     1
resultado               rmb     3
op1                     rmb     2
op2                     rmb     2

                        
                        ORG    $8000	; Ahora sumaremos dos numeros de 16
* de 16 bits, aprovechando el registro indice IX para sumar de a 8 bits
                        
                        clr     resultado	; HHresultado = 0
                        ldab    #$2		
* el # indica modo Inmediato B <- 2 (hexadecimal)
                        ldx     #resultado+2	; carga el registro IX
* con la direccion de resultado mas dos (Lresultado)
                        clc			; Carry = 0
loop                        
                        ldaa    2,x		; A = *(IX+2) (contenido de IX+2)
                        adca    4,x		; A+= *(IX+4) 
                        staa    0,x		; direccion de IX <- A
                        dex			; IX--
                        decb			; B--
                        bne     loop		; si B<>0 vuelve a loop
                        bcc     sale		; si B=0 y si Carry=0, sale
                        inc     resultado	; si Carry=1 HHresultado++
sale                    
                        bra     sale            ; fin del programa. while(1)
                        
                        
                        
                        
                        
                        
                        
