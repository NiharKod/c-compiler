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

	# push 8
	movq $8,%rbx

	# push 20
	movq $20,%r10

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
	movq %rbx, -16(%rbp)
for_start_0:
	movq -16(%rbp), %rbx

	# push 20
	movq $20,%r10
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
	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -16(%rbp)
jmp for_start_0
for_body_0:
	movq -16(%rbp), %rbx

	# push 3
	movq $3,%r10
	movq -16(%rbp), %r13

	# *
	imulq %r13,%r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
jmp loop_start_0
end_for_0:
loop_end_0:	#top=0

	# push string "Ok so far\n" top=0
	movq $string0, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
	movq %rbx, -16(%rbp)
for_start_1:
	movq -16(%rbp), %rbx

	# push 20
	movq $20,%r10
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
	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -16(%rbp)
jmp for_start_1
for_body_1:
	#top=0

	# push string "%d: %d\n" top=0
	movq $string1, %rbx
	movq -16(%rbp), %r10
	movq -16(%rbp), %r13
	 movq -8(%rbp), %rax
	 movq (%rax, %r13, 8), %r13
     # func=printf nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
jmp loop_start_1
end_for_1:
loop_end_1:# Restore registers
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
	.string "Ok so far\n"

string1:
	.string "%d: %d\n"

