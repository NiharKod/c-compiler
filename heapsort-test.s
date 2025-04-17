	.text
.globl heapify
heapify:
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
	movq %rdx, -24(%rbp)
loop_start_0:
	movq -24(%rbp), %rbx
	movq -16(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je loop_end_0
	movq -24(%rbp), %rbx
	movq %rbx, -32(%rbp)

	# push 2
	movq $2,%rbx
	movq -24(%rbp), %r10

	# *
	imulq %r10,%rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -40(%rbp)

	# push 2
	movq $2,%rbx
	movq -24(%rbp), %r10

	# *
	imulq %r10,%rbx

	# push 2
	movq $2,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -48(%rbp)
	movq -40(%rbp), %rbx
	movq -16(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je if_false_1
	movq -40(%rbp), %rbx
	 movq -8(%rbp), %rax
	 movq (%rax, %rbx, 8), %rbx
	movq -32(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
	 # > 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovg %r12, %rbx
	 cmovle %r11, %rbx
	cmpq $0, %rbx
	je if_false_2
	movq -40(%rbp), %rbx
	movq %rbx, -32(%rbp)
	jne if_false_after_else_2
	if_false_2:
	if_false_after_else_2:
	jne if_false_after_else_1
	if_false_1:
	if_false_after_else_1:
	movq -48(%rbp), %rbx
	movq -16(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je if_false_3
	movq -48(%rbp), %rbx
	 movq -8(%rbp), %rax
	 movq (%rax, %rbx, 8), %rbx
	movq -32(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
	 # > 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovg %r12, %rbx
	 cmovle %r11, %rbx
	cmpq $0, %rbx
	je if_false_4
	movq -48(%rbp), %rbx
	movq %rbx, -32(%rbp)
	jne if_false_after_else_4
	if_false_4:
	if_false_after_else_4:
	jne if_false_after_else_3
	if_false_3:
	if_false_after_else_3:
	movq -32(%rbp), %rbx
	movq -24(%rbp), %r10
	 # != 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovne %r12, %rbx
	 cmove %r11, %rbx
	cmpq $0, %rbx
	je if_false_5
	movq -24(%rbp), %rbx
	 movq -8(%rbp), %rax
	 movq (%rax, %rbx, 8), %rbx
	movq %rbx, -56(%rbp)
	movq -24(%rbp), %rbx
	movq -32(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -32(%rbp), %rbx
	movq -56(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -32(%rbp), %rbx
	movq %rbx, -24(%rbp)
	jne if_false_after_else_5
	if_false_5:
	 jmp loop_end_0
	if_false_after_else_5:
	jmp loop_start_0
loop_end_0:
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
	.text
.globl heapsortc
heapsortc:
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
	movq -16(%rbp), %rbx

	# push 2
	movq $2,%r10

	 # /
	movq %rbx, %rax
	movq $0, %rdx
	cqto
	idivq %r10
	movq %rax, %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	movq %rbx, -24(%rbp)
for_start_6:
	movq -24(%rbp), %rbx

	# push 0
	movq $0,%r10
	 # >= 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovge %r12, %rbx
	 cmovl %r11, %rbx
	cmpq $0, %rbx
	je end_for_6
	 jmp for_body_6
	 loop_start_6:
	movq -24(%rbp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	movq %rbx, -24(%rbp)
jmp for_start_6
for_body_6:
	movq -8(%rbp), %rbx
	movq -16(%rbp), %r10
	movq -24(%rbp), %r13
     # func=heapify nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call heapify
	movq %rax, %rbx
jmp loop_start_6
end_for_6:
loop_end_6:	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	movq %rbx, -24(%rbp)
for_start_7:
	movq -24(%rbp), %rbx

	# push 0
	movq $0,%r10
	 # >= 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovge %r12, %rbx
	 cmovl %r11, %rbx
	cmpq $0, %rbx
	je end_for_7
	 jmp for_body_7
	 loop_start_7:
	movq -24(%rbp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	movq %rbx, -24(%rbp)
jmp for_start_7
for_body_7:
	movq -24(%rbp), %rbx
	 movq -8(%rbp), %rax
	 movq (%rax, %rbx, 8), %rbx
	movq %rbx, -32(%rbp)
	movq -24(%rbp), %rbx

	# push 0
	movq $0,%r10
	 movq -8(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 0
	movq $0,%rbx
	movq -32(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -8(%rbp), %rbx
	movq -24(%rbp), %r10

	# push 0
	movq $0,%r13
     # func=heapify nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call heapify
	movq %rax, %rbx
jmp loop_start_7
end_for_7:
loop_end_7:# Restore registers
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

	# push 10
	movq $10,%rbx

	# push 1000
	movq $1000,%r10

	# *
	imulq %r10,%rbx

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
for_start_8:
	movq -32(%rbp), %rbx
	movq -24(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je end_for_8
	 jmp for_body_8
	 loop_start_8:
	movq -32(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -32(%rbp)
jmp for_start_8
for_body_8:
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
jmp loop_start_8
end_for_8:
loop_end_8:	movq -16(%rbp), %rbx
	movq -8(%rbp), %r10
     # func=heapsortc nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call heapsortc
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
	movq %rbx, -40(%rbp)
for_start_9:
	movq -40(%rbp), %rbx
	movq -8(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je end_for_9
	 jmp for_body_9
	 loop_start_9:
	movq -40(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -40(%rbp)
jmp for_start_9
for_body_9:
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
	je if_false_10
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
	jne if_false_after_else_10
	if_false_10:
	if_false_after_else_10:
jmp loop_start_9
end_for_9:
loop_end_9:	#top=0

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

