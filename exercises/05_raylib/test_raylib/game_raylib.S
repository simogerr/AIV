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
extern DrawEllipse


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

  ; INPUT 
  ; IsKeyDown(int key)
  xor rax, rax ; zeroing rax
  mov rcx, 262 ; Right
  sub rsp, 32
  call [IsKeyDown]
  add rsp, 32

  cmp rax, 1
  jz move_right

  xor rax, rax ; zeroing rax
  mov rcx, 263 ; Left
  sub rsp, 32
  call [IsKeyDown]
  add rsp, 32

  cmp rax, 1
  je move_left


no_input:
  ;DrawRectangle(int posX, int posY, int width, int height, Color color);
  draw_rect:  
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
  add rsp, 8
  pop rax
  call [EndDrawing]
  add rsp, 32 

  jmp gameloop


;Functions
move_right:
  inc dword [squarex]
  jmp no_input

move_left:
  dec dword [squarex]
  jmp no_input

;END PROGRAM
  end:
  sub rsp, 32
  call [ExitProcess]
  add rsp, 32

  ret

section .data

boxTitle:
  db "RAYLIB GAME", 0

gameTitle:
  db "SQUARED",0

textx:
  dq 400

texty:
  dq 350

squarex:
  dq 400

squarey:
  dq 200