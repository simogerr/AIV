
.data


.text
#move bot
lui $s1, 0xffff
ori $s1, $s1, 0x8050 

#Direzione bot
lui $s0, 0xffff
ori $s0, $s0, 0x8010

#track
lui $s2, 0xffff
ori $s2, $s2, 0x8020

ori $a1,$a1, 1
sw $a1, ($s1)
#inizia a posizionare la track
sw $a1, 16($s0)


addiu $a2,$a2,134
sw $a2,($s0)
nop
sw $zero, ($s2)
sw $a1, ($s2)
addiu $a2,$a2,90
sw $a2,($s0)
# a1 è sempre uguale a 1
# a2 è la nostra direzione
# quando voglio cambiare devo fare sw di $a2 nell'indirizzo $s0
# per cambiare direzoine di dove voglio disegnare 
addiu $a2,$a2,134
sw $a2,($s0)
nop

#sw $zero, ($s2)
#sw $a1, ($s2)
#addiu $a2,$a2,90
#sw $a2,($s0)






#stop_bot:
 # sw $0,($s1)
  