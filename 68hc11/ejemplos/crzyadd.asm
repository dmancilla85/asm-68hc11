                        ORG     $0000

nbytes                  equ     4            ;dimensiona la palabra utilizada en la suma            
p                       rmb     nbytes                       
q                       rmb     nbytes
r                       rmb     1+nbytes
punterop                equ     nbytes-1     ;Calculo la dirección final del vector p
punteroq                equ     nbytes       ;Calculo el offset que existe entre el vector p y q
punteror                equ     2*nbytes+1   ;Calculo el offset que existe entre el vector p y r que tiene un elemento mas


                        ORG     $8000
inicio          
                        clc
                        clr     r            ;voy a guardar el carry del resultado
                        ldab    #nbytes      ;Cargo el acc B con el numero de loops
                        ldx     #punterop
loop                        
                        ldaa    0,x
                        adca    punteroq,x
                        sta     punteror,x
                        dex
                        decb
                        bne     loop
                        bcc     get_out
                        inc     r
get_out
                        bra     get_out                        


                        
                        
        
