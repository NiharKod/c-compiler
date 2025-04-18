	.text
.globl inc
inc:
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

	# push 0
	movq $0,%rbx

	# push 0
	movq $0,%r10
	 movq -8(%rbp), %rax
	 movq (%rax, %r10, 8), %r10

	# push 1
	movq $1,%r13

	# +
	addq %r13,%r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
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

	# push 8
	movq $8,%rbx
	movq %rbx, -8(%rbp)
	#top=0

	# push string "a=%d\n" top=0
	movq $string0, %rbx
	movq -8(%rbp), %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	 lea -8(%rbp), %rbx     # func=inc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call inc
	movq %rax, %rbx
	#top=0

	# push string "a=%d\n" top=0
	movq $string1, %rbx
	movq -8(%rbp), %r10
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
	.string "a=%d\n"

string1:
	.string "a=%d\n"

