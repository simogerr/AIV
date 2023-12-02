.data



.text
lui $a0, 0x1001
lui $t7, 0xFFFF
ori $t7, $t7, 0x00FF

# indirizzo $t0 = X
# indirizzo $t1 = Y



loop:
   sw $t7, ($a0)
   addiu $t0, $t0, 1
   bne $t0, 16 , dont_update_X
   addiu $t1, $t1, 1
   addiu $t0, $t0, -16

   
dont_update_X:
      
blt $t1, 4, end_loop
bge $t1, 12, end_loop
beq $t0, 4, change_color_green
beq $t0, 12, change_color_background



j end_loop

end_loop:
   addiu $a0, $a0, 4
   j loop
   
   lui $t6, 0x1001
   ori $t6, $t6, 0x00c8
   beq $a0, $t6, change_color
   
   
   lui $t6, 0x1001
   ori $t6, $t6, 0x00f4
   beq $a0, $t6, change_color_background
   
   lui $t6,0x1001
   ori $t6, $t6, 0x00e0
   beq $a0, $t6, change_color_red
   
   lui $t6, 0x1001
   ori $t6, $t6, 0x0240
   beq $a0, $t6, change_color_green



change_color_background:
  lui $t7, 0xFFFF 
  ori $t7, $t7, 0x00FF
  j end_loop
change_color:
   lui $t7, 0xFF00 
   ori $t7, $t7, 0x00FF
   j loop 


change_color_red:
  lui $t7, 0xFFFF
  ori $t7,0x0001
  j loop
  
change_color_green:
  lui $t7, 0xFF00
  ori $t7,0xFF00
  j end_loop
  
  
