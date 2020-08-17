                        ORG     $0000

vector                  rmb     10
numeros                 rmb     10
letras                  rmb     10
puntero_n               rmb     2
puntero_l               rmb     2 

                        ORG     $8000
inicio          
                      
                        ldx     #numeros
                        stx     puntero_n
                        ldx     #letras
                        stx     puntero_l
                        ldx     #vector
loop
                        ldaa    0,x     ;leo una posicion del vector
                        cmpa    #'9'
                        bls     esnumero
                        cmpa    #'Z'
                        bls     esletra
                        bra     again   ;Si pasa por aca es un simbolo
esnumero                
                        cmpa    #'0'
                        blo     again   ;Es menor que 0 por lo tanto es un simbolo
                        ldy     puntero_n
                        staa    0,y
                        iny
                        sty     puntero_n
                        bra     again
esletra                 
                        cmpa    #'A'                                                
                        blo     again   ;Es menor que A por lo tanto es un simbolo
                        ldy     puntero_l
                        staa    0,y     
                        iny     
                        sty     puntero_l
again
                        inx
                        cmpx    #vector+10
                        bne     loop
                        
fin                     bra     fin                        
                                                 
                        
                                        
                        
                        
                        
        
