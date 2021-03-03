.data

.balign 4
scanf_msg: .asciz "Enter a string: \n"

.balign 4
scanpatter: .asciz " %[^\n]s"

.balign 4
user_input: .skip 100

.balign 4 
err_msg: .asciz "Your string is too long\n" 

.balign 4
print_msg: .asciz "Your string is: %s\n"

.balign 4
return: .word 0

.balign 4
output: .skip 24

.balign 4 
print_int: .asciz "%i\n"

.global main
main:

    ldr r1,addr_return
    str lr, [r1] /*stores the original return for func call  */
    mov r5, #0
    mov r6, #0
    ldr r4, addr_output
    
ask_for_string:
    add r5, #1
    ldr r0, addr_scanf_msg
    bl printf

    ldr r0, addr_scanpatter
    ldr r1, addr_user_input
    bl scanf

    ldr r0, addr_user_input
    mov r1, #0

check_len:
    ldrb r2, [r0], #1
    cmp r2, #0x00
    beq continue_check 
    str r2, [r4,r6]
    add r6, r6, #1
    add r1, r1, #1
    
    cmp r1, #13
    beq err1
    b check_len

err1:
    ldr r0, addr_err_msg
    bl printf
    mov r0, #7
    cmp r5,#1
    bne update
    b final

update: 
    mov r0, #8
    b final

continue_check:
    cmp r5, #1
    beq ask_for_string
    b second

second: 

    ldr r0, addr_print_msg
    ldr r1, addr_output
    bl printf

final:
    mov r0, r6
    ldr r1, addr_return
    ldr lr, [r1]
    bx lr



addr_scanf_msg: .word scanf_msg
addr_scanpatter: .word scanpatter
addr_user_input: .word user_input
addr_err_msg: .word err_msg
addr_print_msg: .word print_msg
addr_return: .word return 
addr_output: .word output
addr_print_int: .word print_int

/*Externals */
.global printf
.global scanf


