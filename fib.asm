section .bss
  _bss_start:
    ; store max iterations and current iteration
    max_iterations resb 4
    iteration resb 4
    ; store arguments
    n_0 resb 4
    n_1 resb 4
  _bss_end:

section .text
  global _start

; initialise the function variables
_start:
  mov dword [max_iterations], 11
  mov dword [iteration], 0
  mov dword [n_0], 0
  mov dword [n_1], 1
  jmp fib

fib:
  mov ecx, 0
  mov edx, 0
  mov eax, [n_0]
  mov ebx, [n_1]
  add ecx, eax
  add ecx, ebx
  mov edx, [n_1]
  mov dword [n_0], edx
  mov dword [n_1], ecx

  mov edx, [iteration]
  inc edx
  mov dword [iteration], edx

  cmp edx, [max_iterations]
  je print

  call fib
  ret

print:
  mov eax, 1
  mov ebx, [n_1]
  int 0x80
