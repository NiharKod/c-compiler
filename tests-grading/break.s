.data
 .comm i, 8
	.text
.globl main
main:
	# Save Frame pointer
	pushq %rbp
	movq %rsp,%rbp
	subq $256, %rsp
# Save registers. 
# Push one extra to align stack to 16bytes
	pushq %rbx
	pushq %rbx
	pushq %r10
	pushq %r13
	pushq %r14
	pushq %r15

	# push 0
	movq $0,%rbx
	movq %rbx, i
for_start_0:
	movq i, %rbx

	# push 15
	movq $15,%r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je end_for_0
	 jmp for_body_0
	 loop_start_0:
	movq i, %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, i
jmp for_start_0
for_body_0:
	movq i, %rbx

	# push 5
	movq $5,%r10
	 # == 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmove %r12, %rbx
	 cmovne %r11, %rbx
	cmpq $0, %rbx
	je if_false_1
	 jmp loop_end_0
	jne if_false_after_else_1
	if_false_1:
	if_false_after_else_1:
	#top=0

	# push string "i=%d\n" top=0
	movq $string0, %rbx
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
jmp loop_start_0
end_for_0:
loop_end_0:	#top=0

	# push string "for i=%d\n" top=0
	movq $string1, %rbx
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
	movq %rbx, i
loop_start_2:
	movq i, %rbx

	# push 15
	movq $15,%r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je loop_end_2
	#top=0

	# push string "i=%d\n" top=0
	movq $string2, %rbx
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	movq i, %rbx

	# push 8
	movq $8,%r10
	 # == 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmove %r12, %rbx
	 cmovne %r11, %rbx
	cmpq $0, %rbx
	je if_false_3
	 jmp loop_end_2
	jne if_false_after_else_3
	if_false_3:
	if_false_after_else_3:
	movq i, %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, i
	jmp loop_start_2
loop_end_2:
	#top=0

	# push string "while i=%d\n" top=0
	movq $string3, %rbx
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
	movq %rbx, i
loop_start_4:
	#top=0

	# push string "i=%d\n" top=0
	movq $string4, %rbx
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	movq i, %rbx

	# push 10
	movq $10,%r10
	 # == 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmove %r12, %rbx
	 cmovne %r11, %rbx
	cmpq $0, %rbx
	je if_false_5
	 jmp loop_end_4
	jne if_false_after_else_5
	if_false_5:
	if_false_after_else_5:
	movq i, %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, i
	movq i, %rbx

	# push 15
	movq $15,%r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	 jne loop_start_4
	 loop_end_4:	#top=0

	# push string "do/while i=%d\n" top=0
	movq $string5, %rbx
	movq i, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "OK\n" top=0
	movq $string6, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	popq %rbx
	addq $256, %rsp
	leave
	ret
string0:
	.string "i=%d\n"

string1:
	.string "for i=%d\n"

string2:
	.string "i=%d\n"

string3:
	.string "while i=%d\n"

string4:
	.string "i=%d\n"

string5:
	.string "do/while i=%d\n"

string6:
	.string "OK\n"

