
project("asmsum")
cmake_minimum_required(VERSION 3.10.2)

set(can_use_assembler TRUE)
enable_language(ASM)
add_definitions(-DANDROID -DOC_ARM_ASM)
add_library( multiply-lib STATIC
             multiply.s )

add_library( native-lib
             SHARED
             native-lib.cpp )

target_link_libraries( native-lib
                       multiply-lib
                       ${log-lib} )