	.text
.globl sum
sum:
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

	# push 0
	movq $0,%rbx
	movq %rbx, -32(%rbp)

	# push 0
	movq $0,%rbx
	movq %rbx, -24(%rbp)
for_start_0:
	movq -24(%rbp), %rbx
	movq -8(%rbp), %r10
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
	movq -24(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -24(%rbp)
jmp for_start_0
for_body_0:
	movq -32(%rbp), %rbx
	movq -24(%rbp), %r10
	 movq -16(%rbp), %rax
	 movq (%rax, %r10, 8), %r10

	# +
	addq %r10,%rbx
	movq %rbx, -32(%rbp)
jmp loop_start_0
end_for_0:
loop_end_0:	movq -32(%rbp), %rbx
	movq %rbx, %rax
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

	# push 5
	movq $5,%rbx

	# push 8
	movq $8,%r10

	# *
	imulq %r10,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx
	movq %rbx, -8(%rbp)

	# push 0
	movq $0,%rbx

	# push 4
	movq $4,%r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 1
	movq $1,%rbx

	# push 3
	movq $3,%r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 2
	movq $2,%rbx

	# push 1
	movq $1,%r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 3
	movq $3,%rbx

	# push 7
	movq $7,%r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 4
	movq $4,%rbx

	# push 6
	movq $6,%r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 5
	movq $5,%rbx
	movq -8(%rbp), %r10
     # func=sum nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call sum
	movq %rax, %rbx
	movq %rbx, -16(%rbp)
	#top=0

	# push string "sum=%d\n" top=0
	movq $string0, %rbx
	movq -16(%rbp), %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
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
	.string "sum=%d\n"

