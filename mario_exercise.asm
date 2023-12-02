.db "NES", $1A, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

.org $8000

.define PPUCTRL $2000
.define PPUMASK $2001
.define PPUSTATUS $2002
.define OAMADDR $2003
.define OAMDATA $2004
.define PPUSCROLL $2005
.define PPUADDR $2006
.define PPUDATA $2007

.define POS_Y $0200
.define SPRITE1_tile $0201
.define SPRITE1_attr $0202
.define POS_X $0203

.define POS_Y2 $0204
.define SPRITE2_tile $0205
.define SPRITE2_attr $0206
.define POS_X2 $0207

.define POS_Y3 $0208
.define SPRITE3_tile $0209
.define SPRITE3_attr $020a
.define POS_X3 $020b

.define POS_Y4 $020c
.define SPRITE4_tile $020d
.define SPRITE4_attr $020e
.define POS_X4 $020f

.define FLIP_LEFT $02

.define DMA $4014

.define FRAME_PASSED $F0

.define OLD_A_DATA $FE

.define JOYPAD1 $4016
.define player_1_input $41 

palette:
    .db $22, $14, $23, $37
    .db $22, $16, $27, $18
    .db $22, $29, $1A, $0F
    .db $0F, $1A, $30, $27
    .db $22, $1A, $27, $30
    .db $22, $16, $27, $30

start:
    LDX #$FF
    TXS
clear:
    LDA #$20
    STA PPUADDR
    LDA #$00
    STA PPUADDR

; Repeat for each number from  -- PULISCE LO SCHERMO 
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
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; apro comunicazione con PPU per la palette colori
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LDA #$3F
STA PPUADDR
LDA #0
STA PPUADDR

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LOAD DELLA PALETTE, setto il regisro x a 0
;; LDA della palette e incremento l'indirizzo conil valore ceh cè in X
;; LDA $indirizzo, X e poi incremento la X, STA del valore nell'indirizzo PPUADDR
;; continuo il loop finchè non arggiungo ilnumero delle palette presenti
;; #$10 = 16
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LDX #0
load_palette:
    LDA palette, X
    STA PPUDATA
    INX
    TXA
    CMP #$18 ; compare che sia uguiale a 12, numero di palette che voglio inserire
    BNE load_palette

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ANDIMAO A DISEGNARE NELLA NAMETABLE
;; PER FAR QUESTO DPBBIAMO VEDERE GLI INDIRIZZI DELL'ATTRIBUTE TABLE
;; DOVE COMINCIANO: Each attribute table, starting at $23C0, $27C0, $2BC0, or $2FC0, 
;; is arranged as an 8x8 byte array:
;; significa che comincio a scrivere a schermo dall'indirizzo $23C0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;------MARIO 1UP
;; Tile of nametable
LDA #$20
STA PPUADDR
LDA #$D0
STA PPUADDR
;; Tileof sprite
LDA #$FC
STA PPUDATA
LDA #$FD
STA PPUDATA
LDA #$FE
STA PPUDATA
LDA #$FF

; ;;---------- MARIO HEAD
;; Tile of nametable
LDA #$20
STA PPUADDR
LDA #$EF
STA PPUADDR
;; Tileof sprite
LDA #$00
STA PPUDATA
LDA #$01
STA PPUDATA

; ;;---------- MARIO HEAD LOW - BODY
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$0F
STA PPUADDR
;; Tileof sprite
LDA #$02
STA PPUDATA
LDA #$03
STA PPUDATA

; ;;---------- MARIO BODY LOW
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$2F
STA PPUADDR
;; Tileof sprite
LDA #$04
STA PPUDATA
LDA #$05
STA PPUDATA

; ;;---------- MARIO LEGS LOW
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$4F
STA PPUADDR
;; Tileof sprite
LDA #$06
STA PPUDATA
LDA #$07
STA PPUDATA

;;------------------------------------------------

; ;;---------- MUSHROOMS HEAD
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$33
STA PPUADDR
;; Tileof sprite
LDA #$70
STA PPUDATA
LDA #$71
STA PPUDATA

; ;;---------- MUSHROOMS FOOTS
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$53
STA PPUADDR
;; Tileof sprite
LDA #$72
STA PPUDATA
LDA #$73
STA PPUDATA

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ;;---------- BRICK 0------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$6D
STA PPUADDR
;; Tileof sprite
LDA #$85
STA PPUDATA
LDA #$86
STA PPUDATA

; ;;---------- BRICK 1------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$6F
STA PPUADDR
;; Tileof sprite
LDA #$85
STA PPUDATA
LDA #$86
STA PPUDATA

; ;;---------- BRICK 2 ------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$71
STA PPUADDR
;; Tileof sprite
LDA #$85
STA PPUDATA
LDA #$86
STA PPUDATA

; ;;---------- BRICK 3 ------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$73
STA PPUADDR
;; Tileof sprite
LDA #$85
STA PPUDATA
LDA #$86
STA PPUDATA

; ;;---------- BRICK 4 ------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$75
STA PPUADDR
;; Tileof sprite
LDA #$85
STA PPUDATA
LDA #$86
STA PPUDATA

; ;;---------- BRICK 5 ------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$77
STA PPUADDR
;; Tileof sprite
LDA #$85
STA PPUDATA
LDA #$86
STA PPUDATA

; ;;---------- BRICK 6 ------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$79
STA PPUADDR
;; Tileof sprite
LDA #$85
STA PPUDATA
LDA #$86
STA PPUDATA

; ;;---------- BRICK 7 ------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$7B
STA PPUADDR
;; Tileof sprite
LDA #$85
STA PPUDATA
LDA #$86
STA PPUDATA

; ;;---------- TURTOIS  ------------------------------
;;-------------FEETS-------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$57
STA PPUADDR
;; Tileof sprite
LDA #$A3
STA PPUDATA
LDA #$A4
STA PPUDATA

;;-------------BODY-------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$37
STA PPUADDR
;; Tileof sprite
LDA #$A1
STA PPUDATA
LDA #$A2
STA PPUDATA

;;-------------HEAD-------------------------------
;; Tile of nametable
LDA #$21
STA PPUADDR
LDA #$18
STA PPUADDR
;; Tileof sprite
LDA #$A0
STA PPUDATA

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; # CHE PALETTE UTILIZZA OGNI PEZZO DELLA TILE? la tile è divisa in 4
;; con i bit vado a specificare quale palette ogni pezzo della tile deve utilizzare
;; bottomright  | bottomleft | topright | topleft
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PPU MASK per attivare la visibilità della sprite
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
LDA #%00011000
STA PPUMASK

;;;MOVE SPRITE
LDA #$20
STA POS_Y
STA POS_X
STA POS_Y2
STA POS_X3

LDA #$28
STA POS_X2
STA POS_Y3
STA POS_X4
STA POS_Y4

LDA #$B2
STA SPRITE1_tile
LDA #$01
STA SPRITE1_attr

LDA #$B3
STA SPRITE2_tile
LDA #$01
STA SPRITE2_attr

LDA #$B4
STA SPRITE3_tile
LDA #$01
STA SPRITE3_attr

LDA #$B5
STA SPRITE4_tile
LDA #$01
STA SPRITE4_attr

LDA #%10000000
STA PPUCTRL

;;;; SETTO FLIP LEFT OFF
LDA #0
STA FLIP_LEFT

loop:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
;; NECESSARIO PER NON AVERE ARTEFATTI NELLA PRIMA COLONNA $23C0, $23C8
;; $23D0, $23D8, $23E0, $23E8 etc..
;; senza questo se scrivo nella prima colonna mi appare anche un pezzo
;; di sprite dopo l'ultima colonna $23C7, $23CF, $23D7, $23DF etc..
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 

;MOVING SRITE Y e X

LDA FRAME_PASSED
BEQ loop

JSR readjoy_1

LDA player_1_input
BEQ j_p1_end_input

;; INPUT DESTRA 
LDA player_1_input
AND #%00000001
BNE p1_right_input ;no uguale a 0 quindi destra premuto

LDA player_1_input
AND #%00000010
BNE p1_left_input

p1_no_input_left_right:

LDA player_1_input
AND #%00001000
BNE p1_up_input

LDA player_1_input
AND #%00000100
BNE j_p1_down_input

j_p1_end_input:
JMP p1_input_notFound
j_p1_down_input:
JMP p1_down_input

p1_right_input:
    LDA FLIP_LEFT
    BEQ RIGHT_NO_FLIP
    LDX POS_X2
    LDY POS_X

    STX POS_X
    STY POS_X2

    STX POS_X3
    STY POS_X4

    LDA #0
    STA FLIP_LEFT

    RIGHT_NO_FLIP:

    INC POS_X
    INC POS_X2
    INC POS_X3
    INC POS_X4
    LDA #%00000001
    STA SPRITE1_attr
    STA SPRITE2_attr
    STA SPRITE3_attr
    STA SPRITE4_attr
    JMP p1_no_input_left_right

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

p1_left_input:
    LDA FLIP_LEFT
    BNE LEFT_NO_FLIP
    LDX POS_X2
    LDY POS_X

    STX POS_X
    STY POS_X2

    STX POS_X3
    STY POS_X4

    LDA #1
    STA FLIP_LEFT

    LEFT_NO_FLIP:
    DEC POS_X
    DEC POS_X2
    DEC POS_X3
    DEC POS_X4
    LDA #%01000001
    STA SPRITE1_attr
    STA SPRITE2_attr
    STA SPRITE3_attr
    STA SPRITE4_attr
    JMP p1_no_input_left_right
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
p1_up_input:
    DEC POS_Y
    DEC POS_Y2
    DEC POS_Y3
    DEC POS_Y4
    JMP p1_end_input

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
p1_down_input:
    INC POS_Y
    INC POS_Y2
    INC POS_Y3
    INC POS_Y4
    JMP p1_end_input

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

p1_input_notFound:

p1_end_input:

LDA #$0
STA FRAME_PASSED

JMP loop

;INPUT

readjoy_1:
        LDA #$01
        STA JOYPAD1
        LDA #$00
        STA JOYPAD1
        LDX #$08
    ReadController1Loop:
        LDA JOYPAD1
        LSR A
        ROL player_1_input
        DEX
        BNE ReadController1Loop
        RTS

nmi:
    STA OLD_A_DATA

    INC FRAME_PASSED
    
    LDA #$2
    STA DMA

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    LDA #0
    STA PPUSCROLL
    LDA #0
    STA PPUSCROLL

    LDA OLD_A_DATA

    RTI

irq:
    RTI

.goto $FFFA 

.dw nmi
.dw start
.dw irq

.incbin "mario0.chr"
.fill $4096 $aa