;;globals
section .bss ; declare variable arrays
  _bss_start:
    seed resd 2
    numbers_seen resq 4000
    position_in_seen resd 8

    square resd 8
    square_ret resd 8

    ten_val resd 8
    ten_val_ret resd 8

    to_divide resd 8
    divide_by resd 8
    quotient resd 8
    remainder resd 8

    digit resd 1
    digit_ret resd 1

    ten_raised_to resd 8
    power_of_ten_ret resd 8

    number_to_analyse resd 8
    analyse_against resd 8
    base_ten_iterations resb 1
  _bss_end:

;;main code
section .text ; code section
  global _start
_start:
  mov eax, 1 ; sys write

;;functions
_length: ;calulates number of digits in number, returns to base_ten_iterations
  mov edx, 1
  jmp _loop_l
_loop_l:
  inc edx
  mov dword [base_ten_iterations], edx
  mov dword [ten_raised_to], edx
  call _power_of_ten
  mov edx, [base_ten_iterations]
  mov eax, [power_of_ten_ret]
  cmp eax, [number_to_analyse]
  jle _loop_l
  jg _exit
_exit:
  mov dword [base_ten_iterations], edx
  ret

_nth_digit: ;returns the nth digit from the right to digit_ret
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

_divide: ; divides and returns to quotient/remainder
  mov eax, [to_divide]
  mov ebx, [divide_by]
  mov edx, 0
  div ebx
  mov ebx, eax
  mov [quotient], eax
  mov [remainder], edx
  ret

_power_of_ten: ;returns power of ten
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
