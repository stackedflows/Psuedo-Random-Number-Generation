;;globals
section .bss ; declare variable arrays
  _bss_start:
    square resd 8
    square_ret resd 8

    to_divide resd 8
    divide_by resd 8
    quotient resd 8
    remainder resd 8

    number_to_parse resd 8
    digit resd 8
    digit_ret resd 8

    ten_raised_to resd 8
    power_of_ten_ret resd 8

    number_to_analyse resd 8
    base_ten_iterations resd 8

    middle_num resd 8
    next_number resd 8

    current_number resd 8
    seed resd 8 ; greater than 2 digits
    numbers_seen resb 4000 ; 1000 entries of 8 bytes
    position resd 8
  _bss_end:

;;main code
section .text ; code section
  global _start
_start:
  mov dword [seed], 1234
  mov eax, [seed]
  mov dword [numbers_seen], eax
  jmp _populate_arr

;;processes
_populate_arr: ;populates the array with pseudo-random integers
  mov ecx, 0
  jmp _loop_pa
_loop_pa:
  mov eax, [numbers_seen + ecx]
  mov dword [current_number], eax
  mov dword [position], ecx
  call _iterate_middle
  mov ebx, [next_number]
  mov ecx, [position]
  inc ecx
  mov dword [numbers_seen + ecx + 1], ebx
  cmp ecx, 1000
  jg _gg
  jl _loop_pa

_gg:
  mov eax, 1
  mov ebx, [numbers_seen + 13] ;pick what number in the sequence to look at
  int 0x80

;;functions
_iterate_middle: ; calulates the next middle digit, returns to middle_num_ret
  mov eax, [current_number]
  mov dword [square], eax
  call _square
  mov eax, [square_ret]
  mov dword [middle_num], eax
  call _middle_digit
  ret

_middle_digit: ; returns the middle digit of middle_num to middle_num_ret
  mov ebx, [middle_num]
  mov dword [number_to_analyse], ebx
  call _length
  mov ebx, [base_ten_iterations]
  mov dword [to_divide], ebx
  mov dword [divide_by], 2
  call _divide
  mov ebx, [quotient]
  mov eax, [middle_num]
  mov dword [number_to_parse], eax
  mov dword [digit], ebx
  call _nth_digit
  mov ebx, [digit_ret]
  mov dword [next_number], ebx
  ret

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
  jl _loop_l
  jg _exit
_exit:
  mov eax, 1 ; possible faults
  mov dword [base_ten_iterations], edx
  ret

_nth_digit: ;returns the nth digit from the right to digit_ret
  mov eax, [digit]
  mov ebx, [number_to_parse]
  mov dword [to_divide], ebx
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
