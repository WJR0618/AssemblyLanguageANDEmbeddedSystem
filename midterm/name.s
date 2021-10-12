.data
.globl  name1
.globl  name2
.globl  name3
.globl  name
team:   .asciz  "Team 33\n"
name1:  .asciz  "Anny Hsu\n"
name2:  .asciz  "Michael Lo\n"
name3:  .asciz  "JunRu Wang\n"
start:  .asciz  "*****Print Name***** \n"
end:    .asciz  "*****End Print***** \n\n"

.text

.globl  main

name:  stmfd   sp!,{lr}
       mov     r1,#255
       mov     r2,#255
       adcs    r0, r1, r2
       mov     r1,#250
       mov     r2,#250
       adcs    r0, r1, r2
       ldr     r0,=start
       bl      printf
       ldr     r0,=team
       bl      printf
       ldr     r0,=name1
       bl      printf
       ldr     r0,=name2
       bl      printf
       ldr     r0,=name3
       bl      printf
       ldr     r0,=end
       bl      printf
       mov     r0,#0
       ldmfd   sp!,{lr}
       mov     pc,lr
