section .bss
  fib resb 4
  fib_ resb 4


section	.text
   global _start

_start:
  mov dword [fib], 0
  mov dword [fib_], 1
  mov edx, 11             ;for calculating [] iterations
  call call_fib

  mov	eax,1          ;print
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
