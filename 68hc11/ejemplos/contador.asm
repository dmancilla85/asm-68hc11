                        ORG     $0000
centenas                rmb     1
decenas                 rmb     1
unidades                rmb     1
                      
                        ORG     $7000
inicio                
                        lds     #$00ff
                        clr     centenas
                        clr     decenas
                        clr     unidades
                      
main
                        jsr     inc_counter
                        bra     main
                        
inc_counter
                        inc     unidades
                        ldaa    unidades
                        cmpa    #10
                        blo     get_out
                        clr     unidades
                        inc     decenas
                        ldaa    decenas
                        cmpa    #10
                        blo     get_out
                        clr     decenas
                        inc     centenas
                        ldaa    centenas
                        cmpa    #10
                        blo     get_out
                        clr     centenas
get_out
                        rts                        
                        
                        
                        
                                                
                                               
                                
                                
                                                                
