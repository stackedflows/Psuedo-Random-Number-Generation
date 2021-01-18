;;globals
section .bss ; declare variable arrays
  _bss_start:
    seed resd 8 ; seed location intitialised with 8 bytes of space
    numbers_seen resq 4000 ; array of 100*8 bytes, bloody massive! too big?
    position_in_seen resd 8

    square resd 8
    square_ret resd 8

    ten_val resd 8
    ten_val_ret resd 8

    to_test_even resd 8
    is_even resb 1

    to_divide resd 8
    divide_by resd 8
    quotient resd 8
    remainder resd 8

    digit resd 1
    digit_ret resd 1

    ten_raised_to resd 8
    power_of_ten_ret resd 8
  _bss_end:

;;main code
section .text ; code section
  global _start
_start:
  mov eax, 4 ; sys write


;;functions

_nth_digit: ;returns the nth digit from the right
  mov eax, [digit]
  cmp eax, 1
  je _unit
  jne _nunit
_unit:
  mov dword [divide_by], 10
  call _divide
  mov ebx, [remainder]
  mov dword [digit_ret], ebx
  ret
_nunit:
  mov dword [ten_raised_to], eax
  mov ebx, [ten_raised_to]
  call _power_of_ten
  mov ebx, [power_of_ten_ret]
  mov dword [divide_by], ebx
  call _divide
  mov ebx, [quotient]
  mov dword [to_divide], ebx
  mov dword [divide_by], 10
  call _divide
  mov ebx, [remainder]
  mov dword [digit_ret], ebx
  ret

_divide: ; divides and returns to address quotient, remainder
  mov eax, [to_divide]
  mov ebx, [divide_by]
  mov edx, 0
  div ebx
  mov ebx, eax
  mov [quotient], eax
  mov [remainder], edx
  ret

_test_even: ;not even, returns 1 to is_even, else returns 0
  mov ebx, [to_test_even]
  test bx, 1
  jnz _even
  mov dword [is_even], 1
  ret
_even:
  mov dword [is_even], 0
  ret

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
  ret

_square: ;square function
  mov ebx, [square]
  mov ecx, [square]
  jmp _loop_s
_loop_s:
  dec ecx
  add ebx, [square]
  cmp ecx, 1
  jne _loop_s
  mov dword [square_ret], ebx
  ret

_power_of_ten: ;returns ten to the power of some value
  mov eax, 10
  mov ecx, [ten_raised_to]
  jmp _loop_pot
_loop_pot:
  dec ecx
  mov ebx, 10
  mul ebx
  cmp ecx, 1
  jne _loop_pot
  mov dword [power_of_ten_ret], eax
  mov eax, 0
  mov ebx, 0
  mov edx, 0
  mov ecx, 0
  ret

