#PURPOSE:           This program illustrates how functions work
#                   We'll compute the value of 
#
#                   2^3 + 5^2
#            

#Everything is stored in registers,
#So the .data section doesn't have anything

.section .data

.section .text

.global _start

_start:

pushl $3            # push second arg
pushl $2            # push first arg
call power          # call the function
addl $8, %esp       # move the stack pointer back

pushl %eax          # save the first result before 
                    # calling the next function

pushl $2
pushl $5
call power
addl $8, %esp

popl %ebx           # second result is already
                    # in %eax. We saved the first result
                    # into the stack so now we just pop
                    # out into %ebx

addl %eax, %ebx     # add them together (2^3 + 5^2)
                    # into %ebx, which is also used
                    # as the program exit status code

movl $1, %eax       # exit (%ebx is returned)
int $0x80   


#PURPOSE:           This function is used to
#                   compute the value of a number       
#                   raised to a power
#
#          
#
#INPUT:             First argument - the base number
#                   Second argument - the exponent       
#
#
#OUTPUT:            Will give the result as a return value
#
#
#
#NOTES:             The power must be 1 or greater
#
#
#
#VARIABLES:         %ebx        - holds the base
#                   %ecx        - holds the exponent
#                   -4(%ebp)    - holds the current result
#                   %eax        - is used for temporary storage 

.type power, @function

power:
pushl %ebp              # save old base pointer
movl %esp, %ebp         # make stack pointer the base pointer
subl $4, %esp           # make room for out local storage

movl 8(%ebp), %ebx      # put first arg in %eax
movl 12(%ebp), %ecx     # put second arg in %ecx

movl %ebx, -4(%ebp)     # store current result

power_loop_start:
cmpl $1, %ecx           # if exponent == 1, we're done
je end_power

movl -4(%ebp), %eax     # move the current result in %eax   
imull %ebx, %eax        # multiply current result by the base

movl %eax, -4(%ebp)     # store the current result 
decl %ecx               # decrease exponent
jmp power_loop_start    # run for next power

end_power:
movl -4(%ebp), %eax     # return value goes into %eax
movl %ebp, %esp         # restore stack pointer
popl %ebp               # restore the base pointer
ret


