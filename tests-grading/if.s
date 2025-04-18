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

	# push 1
	movq $1,%rbx
	cmpq $0, %rbx
	je if_false_0
	#top=0

	# push string "OK1\n" top=0
	movq $string0, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	jne if_false_after_else_0
	if_false_0:
	if_false_after_else_0:

	# push 0
	movq $0,%rbx
	cmpq $0, %rbx
	je if_false_1
	#top=0

	# push string "OK2\n" top=0
	movq $string1, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	jne if_false_after_else_1
	if_false_1:
	if_false_after_else_1:

	# push 1
	movq $1,%rbx
	cmpq $0, %rbx
	je if_false_2
	#top=0

	# push string "OK3\n" top=0
	movq $string2, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	jne if_false_after_else_2
	if_false_2:
	#top=0

	# push string "OK4\n" top=0
	movq $string3, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	if_false_after_else_2:

	# push 0
	movq $0,%rbx
	cmpq $0, %rbx
	je if_false_3
	#top=0

	# push string "OK5\n" top=0
	movq $string4, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	jne if_false_after_else_3
	if_false_3:
	#top=0

	# push string "OK6\n" top=0
	movq $string5, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	if_false_after_else_3:
	#top=0

	# push string "OK7\n" top=0
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
	.string "OK1\n"

string1:
	.string "OK2\n"

string2:
	.string "OK3\n"

string3:
	.string "OK4\n"

string4:
	.string "OK5\n"

string5:
	.string "OK6\n"

string6:
	.string "OK7\n"

