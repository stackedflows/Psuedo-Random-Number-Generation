  @ This file is multiply.s
  .text
  .align  2
  .global  multiply
  .type  multiply, %function
multiply:
  @ Multiply the arguments in registers r0 and r1
  stmfd  sp!, {fp,ip,lr}
  mul  r0, r1, r0
  ldmfd  sp!, {fp,ip,lr}
  bx  lr
  .size  multiply, .-multiply