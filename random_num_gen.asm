section .bss ; declare variable arrays
  _bss_start:
    seed resd 8 ; seed location intitialised with 8 bytes of space
    numbers_seen resq 4000 ; array of 100*8 bytes, bloody massive! too big?
    position_in_seen resd 8
    square resd 8
    square_ret resd 8
    ten_val resd 8
    ten_val_ret resd 8
    num_to_check resd 8
    to_test_even resd 8
    is_even resb 1
    to_divide resd 8
    quotient resd 8
    remainder resd 8
  _bss_end:

section .text ; code section
  global _start
_start:
  mov eax, 4 ; sys write

  mov dword [position_in_seen], 0 ; structure for array building
  mov dword [seed], 22 ;intitialise seen array with seed
  mov ebx, [numbers_seen] ; {22, 0, 0, ... , 0}
  mov dword [numbers_seen], ebx ; move seed into seen
  inc dword [position_in_seen]

  mov dword [quotient], 256
  mov ebx, [quotient + 1]
  mov eax, 1
  int 0x80

_divide_by:
  mov eax, [to_divide]
  mov ebx, 2
  div ebx
  mov dword [quotient], eax
  mov dword [remainder], edx

_test_even: ;not even, returns 1 to is_even, else returns 0
  mov ebx, [to_test_even]
  test bl, 1
  jz _even
  mov eax, 1
  mov dword [is_even], 1
_even:
  mov eax, 1
  mov dword [is_even], 0

_times_ten: ; multiply a number by 10 function
  mov ebx, [ten_val]
  mov ecx, 10
  jmp _loop_t
_loop_t:
  dec ecx
  add ebx, [ten_val]
  cmp ecx, 1
  jne _loop_t
  mov dword [ten_val_ret], ebx

_square: ;square function
  mov ebx, [seed]
  mov ecx, [seed]
  jmp _loop_s
_loop_s:
  dec ecx
  add ebx, [seed]
  cmp ecx, 1
  jne _loop_s
  mov dword [square_ret], ebx
