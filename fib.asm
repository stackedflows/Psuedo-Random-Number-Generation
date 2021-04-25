section .bss
  fib resb 4
  fib_ resb 4

section	.text
   global _start

; 1st and 2nd fibonacci numbers, and the number of iterations
_start:
  mov dword [fib], 0
  mov dword [fib_], 1
  mov edx, 11
  call call_fib

  mov	eax,1
  mov ebx, [fib_]
  int	0x80

call_fib:
  cmp edx, 0
  jg do_calculation
  ret

do_calculation:
  dec edx
  call call_fib
  mov eax, [fib]
  mov ebx, [fib_]
  add eax, ebx
  mov dword [fib_], eax
  mov dword [fib], ebx
  ret
