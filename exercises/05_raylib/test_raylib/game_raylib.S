bits 64

extern MessageBeep
extern MessageBoxA
extern ExitProcess

extern InitWindow
extern BeginDrawing
extern ClearBackground
extern WindowShouldClose
extern DrawText
extern SetTargetFPS
extern DrawRectangle
extern EndDrawing
extern IsKeyDown
extern DrawLine


start:
  sub rsp,8

  sub rsp, 32
  mov rcx, 30
  call [MessageBeep]
  add rsp, 32
  
  sub rsp, 32
  mov rcx, 1024
  mov rdx, 768
  mov r8, gameTitle  
  call [InitWindow]


  mov rcx, 60
  call [SetTargetFPS]
  add rsp, 32


gameloop:
  sub rsp, 32
  call [WindowShouldClose]
  cmp rax, 0
  jnz end

  ; inc dword [textx]
  ; inc dword [texty]

  call [BeginDrawing]
  mov rcx, 0xFFFFF110
  call [ClearBackground]


  ;Draw Text
  mov rcx, boxTitle
  mov rdx, [textx]
  mov r8, [texty]
  mov r9, 30

  mov rax, 0xFFFF00DD
  sub rsp, 8
  push rax

  sub rsp, 32
  call [DrawText]
  add rsp, 32
  add rsp, 8
  pop rax

  mov rcx, instructionTitle
  mov rdx, [textx]
  mov r8,  300
  mov r9, 30

  mov rax, 0xFFFF0011
  sub rsp, 8
  push rax

  sub rsp, 32
  call [DrawText]
  add rsp, 32
  add rsp, 8
  pop rax

  ; DRAW STATS
  mov rcx, stats
  mov rdx, 100
  mov r8, 50
  mov r9, 20

  mov rax, 0xFF0000DD
  sub rsp, 8
  push rax

  sub rsp, 32
  call [DrawText]
  add rsp, 32
  add rsp, 8
  pop rax



  ; INPUT 
  ; IsKeyDown(int key)

  xor rax, rax ; zeroing rax
  mov rcx, 68 ; Right
  sub rsp, 32
  call [IsKeyDown]
  add rsp, 32
  add [squarex], rax
  add [squarex], rax
  add [squarex], rax

  xor rax, rax ; zeroing rax
  mov rcx, 65 ; Left
  sub rsp, 32
  call [IsKeyDown]
  add rsp, 32
  sub [squarex], rax
  sub [squarex], rax
  sub [squarex], rax

  xor rax, rax ; zeroing rax
  mov rcx, 87 ; Up
  sub rsp, 32
  call [IsKeyDown]
  add rsp, 32
  sub [squarey], rax
  sub [squarey], rax
  sub [squarey], rax

  xor rax, rax ; zeroing rax
  mov rcx, 83 ; Up
  sub rsp, 32
  call [IsKeyDown]
  add rsp, 32
  add [squarey], rax 
  add [squarey], rax 
  add [squarey], rax 
  

  ;shooting
  xor rax, rax ; zeroing rax
  mov rcx, 32 ; Space
  sub rsp, 32
  call [IsKeyDown]
  cmp rax, 0
  jnz shoot

  add rsp, 32
  
aftershoot:

  ;aftershoot

  mov rcx, [enemyx]
  mov rdx, [enemyy]
  mov r8, 30
  mov r9, 30
  mov rax, 0xFF3344FF
  sub rsp, 8
  push rax
  sub rsp, 32
  call [DrawRectangle]
  add rsp, 32
  inc dword [enemyy]
 



no_input:
  ;void DrawRectangle(int posX, int posY, int width, int height, Color color);  
  ;Player
  mov rcx, [squarex]
  mov rdx, [squarey]
  mov r8, 40
  mov r9, 40
  mov rax, 0xFFFFFFFF
  sub rsp, 8
  push rax
  sub rsp, 32
  call [DrawRectangle]
  add rsp, 32

  cmp dword [squarex], 984
  jge reset_playerx
  cmp dword [squarey], 728
  jge reset_playery


  ;Projectile

  ;Enemy
  mov rcx, [enemyx]
  mov rdx, [enemyy]
  mov r8, 30
  mov r9, 30
  mov rax, 0xFF3344FF
  sub rsp, 8
  push rax
  sub rsp, 32
  call [DrawRectangle]
  add rsp, 32
  inc dword [enemyy]
  inc dword [enemyy]
  cmp dword [enemyy], 768
  jge reset_enemy

    ;Enemy2
  mov rcx, [enemy2x]
  mov rdx, [enemy2y]
  mov r8, 18
  mov r9, 18
  mov rax, 0xFF3344FF
  sub rsp, 8
  push rax
  sub rsp, 32
  call [DrawRectangle]
  add rsp, 32
  inc dword [enemy2y]
  inc dword [enemy2y]
  cmp dword [enemy2y], 768
  jge reset_enemy2

   ;Enemy3
  mov rcx, [enemy3x]
  mov rdx, [enemy3y]
  mov r8, 50
  mov r9, 50
  mov rax, 0xFF3344FF
  sub rsp, 8
  push rax
  sub rsp, 32
  call [DrawRectangle]
  add rsp, 32
  inc dword [enemy3y]
  cmp dword [enemy3y], 768
  jge reset_enemy3

  ;Enemy4
  mov rcx, [enemy4x]
  mov rdx, [enemy4y]
  mov r8, 50
  mov r9, 50
  mov rax, 0xFF3344FF
  sub rsp, 8
  push rax
  sub rsp, 32
  call [DrawRectangle]
  add rsp, 32
  inc dword [enemy4y]
  cmp dword [enemy4y], 768
  jge reset_enemy4


  add rsp, 8
  pop rax
  call [EndDrawing]
  add rsp, 32


  jmp gameloop


;Functions
shoot:
  mov eax, [squarex]
  mov [projectilex], eax
  mov eax, [squarey]
  mov [projectiley], eax
  
  sub rsp, 32
  mov rcx, 0
  call [MessageBeep]
  add rsp, 32
  jmp aftershoot

reset_enemy:
  mov dword [enemyy], 0
  jmp no_input

reset_enemy2:
  mov dword [enemy2y], 0
  jmp no_input

reset_enemy3:
  mov dword [enemy3y], 0
  jmp no_input 

reset_enemy4:
  mov dword [enemy4y], 0
  jmp no_input 

reset_playerx:
  mov dword [squarex], 0
  jmp no_input

reset_playery:
  mov dword [squarey], 0
  jmp no_input





;END PROGRAM
  end:
  sub rsp, 32
  call [ExitProcess]
  add rsp, 32

  ret

section .data

boxTitle:
  db "ASSEMBLY RAYLIB GAME", 0
instructionTitle:
  db "PRESS WASD", 0
gameTitle:
  db "SQUARED", 0
stats:
  db "PLAYER1", 0

textx:
  dq 350

texty:
  dq 350

squarex:
  dq 400

squarey:
  dq 200

enemyx:
  dq 500

enemyy:
  dq 100

enemy2x:
  dq 300

enemy2y:
  dq 150

enemy3x:
  dq 200

enemy3y:
  dq 200

enemy4x:
  dq 740

enemy4y:
  dq 500

projectilex:
  dq 200

projectiley:
  dq 200