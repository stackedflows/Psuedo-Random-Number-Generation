# Psuedo-Random-Number-Gen
Implementation of the Middle-square method, inveneted by von-Neumann, with a small difference.

https://en.wikipedia.org/wiki/Middle-square_method

to run, we simply enter

    nasm -f elf32 random_num_gen.asm -o gen.o
    ld -m elf_i386 gen.o -o gen
    ./gen
    echo $?
    
 
# Fibonacci Gen

Recursive fibonacci generator.

    nasm -f elf32 fib.asm -o fib.o
    ld -m elf_i386 fib.o -o _fib
    ./_fib
    echo $?
    
Is this too much voodoo for the next 10 centuries of gods official temple?
