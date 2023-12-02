.db "NES", $1A, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.org $8000

.define PPUCTRL $2000
.define PPUMASK $2001
.define PPUADDR $2006
.define PPUDATA $2007
.define OAMDATA $2004
.define PPUSCROLL $2005
.define PPUSTATUS $2002


start:
    LDX #$FF
    TXS

 clear:
    LDA #$20
    STA PPUADDR
    LDA #$00
    STA PPUADDR

; Repeat for each number from 
    ;2000 - 23C0
    LDY #$FF
    LDX #$0
    empty_first_row_new_row:
        INY
        empty_first_row:
            LDA #$FC
            STA PPUDATA
            INX
            BEQ empty_first_row_new_row
            TXA
            CMP #$C0
            BNE empty_first_row
            TYA
            CMP #$03
            BNE empty_first_row
    

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; PPUADDR indirizzo $2006 inserisco valore $3F00 che è l'indirizzo della pallette colori
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDA #$3F
    STA PPUADDR
    LDA #0
    STA PPUADDR

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; COLOR PALETTE values
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDA #$28
    STA PPUDATA

    LDA #$16
    STA PPUDATA

    LDA #$27
    STA PPUDATA

    LDA #$18
    STA PPUDATA

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PALETTE 2
    LDA #$30
    STA PPUDATA

    LDA #$1A
    STA PPUDATA

    LDA #$0F
    STA PPUDATA

    LDA #$29
    STA PPUDATA

   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; PALETTE 3
    LDA #$0f
    STA PPUDATA

    LDA #$36
    STA PPUDATA

    LDA #$17
    STA PPUDATA

    LDA #$0F
    STA PPUDATA

    ;TILE CHE COMPONGONO LA SPRITE
    LDA #$20
    STA PPUADDR
    LDA #$C4
    STA PPUADDR

    ;; TILE DELLA SPRITE AIV
    LDA #$00
    STA PPUDATA
    LDA #$01
    STA PPUDATA
    LDA #$02
    STA PPUDATA
    LDA #$03
    STA PPUDATA

    ;;POSIZIONE ALL'INTERNO DELLA NAMETABLE
    LDA #$20
    STA PPUADDR
    LDA #$E4
    STA PPUADDR

    ;; TILE DELLA SPRITE AIV
    LDA #$10
    STA PPUDATA 
    LDA #$11
    STA PPUDATA
    LDA #$12
    STA PPUDATA
    LDA #$13
    STA PPUDATA

    ;POSIZIONE ALL'INTERNO DELLA NAMETABLE
    LDA #$21
    STA PPUADDR
    LDA #$04
    STA PPUADDR

    ;; TILE DELLA SPRITE AIV
    LDA #$20
    STA PPUDATA
    LDA #$21
    STA PPUDATA
    LDA #$22
    STA PPUDATA
    LDA #$23
    STA PPUDATA

    ;POSIZIONE ALL'INTERNO DELLA NAMETABLE
    LDA #$21
    STA PPUADDR
    LDA #$24
    STA PPUADDR

    ;; TILE DELLA SPRITE AIV
    LDA #$30
    STA PPUDATA
    LDA #$31
    STA PPUDATA
    LDA #$32
    STA PPUDATA
    LDA #$33
    STA PPUDATA

    ;;SPECIFICO LA COLOR PALETTE PER L'INDIRIZZO DI MEMORIA DOVE 
    LDA #$23
    STA PPUADDR
    LDA #$C9
    STA PPUADDR

    LDA #%01010101
    STA PPUDATA


    LDA #$23
    STA PPUADDR
    LDA #$D1
    STA PPUADDR

    LDA #%01010101
    STA PPUDATA
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; per mostrare le sprite devo ativare i bit della maschera inquesto caso il bit 00001000
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDA #%00001000
    STA PPUMASK

loop:

wait_for_vBlank:
    LDA PPUSTATUS
    AND #%10000000
    BEQ wait_for_vBlank
    LDA #0
    STA PPUSCROLL
    LDA #0
    STA PPUSCROLL
    JMP loop

nmi:
    RTI

irq:
    RTI
    

.goto $FFFA

.dw nmi
.dw start
.dw irq

.incbin "aiv.chr"
.fill 4096 $aa