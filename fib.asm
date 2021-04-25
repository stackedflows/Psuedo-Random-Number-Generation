section .bss
  _bss_start:
    max_iterations resb 1
    fibonacci_seq resb 256 ; we have allocated 64 x 4 bytes of storage
  _bss_end:

section .text

  global _start

_start: ; initialise the function variables
  mov dword [max_iterations], 11
  mov edx, 0
  push 0
  push 1
  jmp fib

fib:
  mov eax, 0
  mov ebx, 0
  mov ecx, 0
  pop ebx
  pop eax
  add ecx, eax
  add ecx, ebx
  mov dword [fibonacci_seq + edx + 4], ecx ; records the current fib number
  push eax
  push ebx
  push ecx
  inc edx
  cmp edx, [max_iterations]
  jle fib
  je print

print:
  mov eax, 1
  pop ebx
  int 0x80
