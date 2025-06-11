#PURPOSE:   Finds the maximum value out of 
#           a set of data
#

#VARIABLES  The registers have the followin useage
#           
#   %edi - holds the index of the data being examined
#   %ebx - holds the current maximum value       
#   %eax - holds the current value to be examined
#
#   The following memory locations are used:
#      
#   data_items - contains the data items, ends with 0
#

.section .data

data_items:
.long 3,67,34,222,45,75,54,34,44,33,22,11,66,0

.section .text

.global _start

_start: 
movl $0, %edi                   # move 0 into the index register
movl data_items(,%edi,4), %eax  # load the first byte from data

movl %eax, %ebx                 # since this is the first item, 
                                # %eax the biggest

start_loop:
cmpl $0, %eax                  # checks if we hit the end
je loop_exit

incl %edi                       # load the next value (increment index +1)

movl data_items(,%edi,4), %eax  # load the next 4 bytes from data into %eax
cmpl %ebx, %eax                 # compare values (current val to current max) 

jle start_loop                  # jump to loop beginning if the 
                                # new one is not bigger (%eax < %ebx)
                                # (jle: if eax <= ebx -> jump to start_loop
                                # else eax > ebx and we move eax into ebx

movl %eax, %ebx                 # else, set new highest value
jmp start_loop                  # jump to loop beginning 

loop_exit:

# %ebx is the status code for the exit system call
# and it already has the maximum value

movl $1, %eax                   # 1 is the exit() syscall
int $0x80








