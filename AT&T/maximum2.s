#PURPOSE:   Finds the maximum value out of 
#           a set of data
#
#           Modify the maximum program to use 
#           an ending address 
#           rather than the number 0 to know when to stop.
#

#VARIABLES  The registers have the followin useage
#           
#   %ebx - holds the current maximum value       
#   %eax - holds the current value to be examined
#   
#   %esi - holds the effective address of data_start
#   %edx - holds the effective address of data_end
#
#   The following memory locations are used:
#      
#   data_items  - contains the address where our data starts
#   data_end    - contains the address of where our data ends   
#

.section .data

data_items:
.long 3,67,34,222,45,75,54,34,44,33,22,11,66
data_end:                       # data_end has the exact address
                                # after last element from data_items

.section .text

.global _start

_start:

lea data_items, %esi            # load effective address 
                                # of data_items in %esi

lea data_end, %edx              # load effective address
                                # of data_end in %edx      

movl (%esi), %eax               # load the the contents at %esi
                                # into %eax

movl %eax, %ebx                 # initial max = firt element

start_loop: 
addl $4, %esi                   # move to next element (4 bytes ahead)

cmpl %edx, %esi                 # reached end?
                                # if yes, exit loop
je exit_loop

movl (%esi), %eax               # load current elem. into %eax
cmpl %ebx, %eax                 # compare current to max

jle start_loop                  # if %eax <= % ebx, continue
movl %eax, %ebx                 # else, update max
jmp start_loop

exit_loop:
movl $1, %eax                   # exit syscall
int $0x80                       # exit %ebx as status (current max)


movl $1, %eax                   # 1 is the exit() syscall
int $0x80
