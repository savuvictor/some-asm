#PURPOSE:   Finds the maximum value out of 
#           a set of data
#
#           Modify the maximum program to use
#           a length count rather
#           than the number 0 to know when to stop.
#

#VARIABLES  The registers have the followin useage
#           
#   %edi - holds the index of the data being examined
#   %ebx - holds the current maximum value       
#   %eax - holds the current value to be examined
#   %ecx - holds the number of elements

#   The following memory locations are used:
#      
#   data_items  - contains the address where our data starts
#   data_length - contains the address where we store our data count
#

.section .data

data_items:
.long 3,67,34,222,45,75,54,34,44,33,22,11,66

data_length:
.long 13

.section .text

.global _start

_start:

movl $0, %edi                   # index = 0
movl data_length, %ecx          # load data count in %ecx

movl data_items(,%edi,4), %eax  # load first elem
movl %eax, %ebx                 # set current max 

start_loop: 
incl %edi                       # increment index
cmpl %ecx, %edi                 # if index == 13 exit 
                                # we reached end of data
je exit_loop

movl data_items(,%edi,4), %eax
cmpl %ebx, %eax                 
jle start_loop                  # if %eax <= %ebx continue looping

movl %eax, %ebx                 # else, update new max
jmp start_loop

exit_loop:
movl $1, %eax                   # exit syscall
int $0x80                       # exit %ebx as status (current max)

movl $1, %eax                   # 1 is the exit() syscall
int $0x80
