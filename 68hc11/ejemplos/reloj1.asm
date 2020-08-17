                        ORG     $0000

horas                   rmb     1
minutos                 rmb     1
segundos                rmb     1

                        ORG     $8000
inicio
                        clr     horas                                                                        
                        clr     minutos 
                        clr     segundos
                        lds     #$00ff
main                    
                        jsr     inc_clock
                        bra     main
inc_clock
                        clc
                        ldaa    segundos
                        inca     
                        daa     
                        staa    segundos
                        cmpa    #$60
                        bne     get_out
                        clr     segundos
                        
                        clc
                        ldaa    minutos
                        inca     
                        daa     
                        staa    minutos
                        cmpa    #$60
                        bne     get_out
                        clr     minutos
                        
                        clc
                        ldaa    horas
                        inca
                        daa
                        staa    horas
                        cmpa    #$24
                        bne     get_out
                        clr     horas
get_out 
                        rts                        
                                                            
