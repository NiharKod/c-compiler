	.text
.globl mysort
mysort:
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
	movq %rdi, -8(%rbp)
	movq %rsi, -16(%rbp)
	movq -8(%rbp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	movq %rbx, -24(%rbp)
for_start_0:
	movq -24(%rbp), %rbx

	# push 0
	movq $0,%r10
	 # > 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovg %r12, %rbx
	 cmovle %r11, %rbx
	cmpq $0, %rbx
	je end_for_0
	 jmp for_body_0
	 loop_start_0:
	movq -24(%rbp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	movq %rbx, -24(%rbp)
jmp for_start_0
for_body_0:

	# push 0
	movq $0,%rbx
	movq %rbx, -32(%rbp)
for_start_1:
	movq -32(%rbp), %rbx
	movq -24(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je end_for_1
	 jmp for_body_1
	 loop_start_1:
	movq -32(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -32(%rbp)
jmp for_start_1
for_body_1:
	movq -32(%rbp), %rbx
	 movq -16(%rbp), %rax
	 movq (%rax, %rbx, 8), %rbx
	movq -32(%rbp), %r10

	# push 1
	movq $1,%r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
	 # > 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovg %r12, %rbx
	 cmovle %r11, %rbx
	cmpq $0, %rbx
	je if_false_2
	movq -32(%rbp), %rbx
	 movq -16(%rbp), %rax
	 movq (%rax, %rbx, 8), %rbx
	movq %rbx, -40(%rbp)
	movq -32(%rbp), %rbx
	movq -32(%rbp), %r10

	# push 1
	movq $1,%r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -32(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq -40(%rbp), %r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	jne if_false_after_else_2
	if_false_2:
	if_false_after_else_2:
jmp loop_start_1
end_for_1:
loop_end_1:jmp loop_start_0
end_for_0:
loop_end_0:# Restore registers
	popq %r15
	popq %r14
	popq %r13
	popq %r10
	popq %rbx
	popq %rbx
	addq $256, %rsp
	leave
	ret
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

	# push 50
	movq $50,%rbx

	# push 1000
	movq $1000,%r10

	# *
	imulq %r10,%rbx
	movq %rbx, -8(%rbp)
	movq -8(%rbp), %rbx

	# push 8
	movq $8,%r10

	# *
	imulq %r10,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx
	movq %rbx, -16(%rbp)
	movq -8(%rbp), %rbx

	# push 10
	movq $10,%r10

	 # /
	movq %rbx, %rax
	movq $0, %rdx
	cqto
	idivq %r10
	movq %rax, %rbx
	movq %rbx, -24(%rbp)

	# push 0
	movq $0,%rbx
	movq %rbx, -32(%rbp)
for_start_3:
	movq -32(%rbp), %rbx
	movq -24(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je end_for_3
	 jmp for_body_3
	 loop_start_3:
	movq -32(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -32(%rbp)
jmp for_start_3
for_body_3:
	movq -32(%rbp), %rbx

	# push 10
	movq $10,%r10

	# *
	imulq %r10,%rbx
	movq %rbx, -40(%rbp)
	movq -40(%rbp), %rbx

	# push 0
	movq $0,%r10
	movq -24(%rbp), %r13

	# *
	imulq %r13,%r10
	movq -32(%rbp), %r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -40(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx

	# push 1
	movq $1,%r10
	movq -24(%rbp), %r13

	# *
	imulq %r13,%r10
	movq -32(%rbp), %r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -40(%rbp), %rbx

	# push 2
	movq $2,%r10

	# +
	addq %r10,%rbx

	# push 2
	movq $2,%r10
	movq -24(%rbp), %r13

	# *
	imulq %r13,%r10
	movq -32(%rbp), %r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -40(%rbp), %rbx

	# push 3
	movq $3,%r10

	# +
	addq %r10,%rbx

	# push 3
	movq $3,%r10
	movq -24(%rbp), %r13

	# *
	imulq %r13,%r10
	movq -32(%rbp), %r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -40(%rbp), %rbx

	# push 4
	movq $4,%r10

	# +
	addq %r10,%rbx

	# push 4
	movq $4,%r10
	movq -24(%rbp), %r13

	# *
	imulq %r13,%r10
	movq -32(%rbp), %r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -40(%rbp), %rbx

	# push 5
	movq $5,%r10

	# +
	addq %r10,%rbx

	# push 5
	movq $5,%r10
	movq -24(%rbp), %r13

	# *
	imulq %r13,%r10
	movq -32(%rbp), %r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -40(%rbp), %rbx

	# push 6
	movq $6,%r10

	# +
	addq %r10,%rbx

	# push 6
	movq $6,%r10
	movq -24(%rbp), %r13

	# *
	imulq %r13,%r10
	movq -32(%rbp), %r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -40(%rbp), %rbx

	# push 7
	movq $7,%r10

	# +
	addq %r10,%rbx

	# push 7
	movq $7,%r10
	movq -24(%rbp), %r13

	# *
	imulq %r13,%r10
	movq -32(%rbp), %r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -40(%rbp), %rbx

	# push 8
	movq $8,%r10

	# +
	addq %r10,%rbx

	# push 8
	movq $8,%r10
	movq -24(%rbp), %r13

	# *
	imulq %r13,%r10
	movq -32(%rbp), %r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -40(%rbp), %rbx

	# push 9
	movq $9,%r10

	# +
	addq %r10,%rbx

	# push 9
	movq $9,%r10
	movq -24(%rbp), %r13

	# *
	imulq %r13,%r10
	movq -32(%rbp), %r13

	# +
	addq %r13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
jmp loop_start_3
end_for_3:
loop_end_3:	movq -8(%rbp), %rbx
	movq -16(%rbp), %r10
     # func=mysort nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call mysort
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
	movq %rbx, -40(%rbp)
for_start_4:
	movq -40(%rbp), %rbx
	movq -8(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je end_for_4
	 jmp for_body_4
	 loop_start_4:
	movq -40(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -40(%rbp)
jmp for_start_4
for_body_4:
	movq -40(%rbp), %rbx
	 movq -16(%rbp), %rax
	 movq (%rax, %rbx, 8), %rbx
	movq -40(%rbp), %r10
	 # != 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovne %r12, %rbx
	 cmove %r11, %rbx
	cmpq $0, %rbx
	je if_false_5
	#top=0

	# push string "\n*** Test failed...\n" top=0
	movq $string0, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx

	# push 1
	movq $1,%rbx
     # func=exit nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call exit
	movq %rax, %rbx
	jne if_false_after_else_5
	if_false_5:
	if_false_after_else_5:
jmp loop_start_4
end_for_4:
loop_end_4:	#top=0

	# push string "\n>>> Test passed...\n" top=0
	movq $string1, %rbx
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
	.string "\n*** Test failed...\n"

string1:
	.string "\n>>> Test passed...\n"

