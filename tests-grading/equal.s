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
	#top=0

	# push string "9==8%d\n" top=0
	movq $string0, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13
	 # == 
	 cmpq %r13, %r10
	 movq $1, %r12
	 movq $0, %r11
	 cmove %r12, %r10
	 cmovne %r11, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9==9=%d\n" top=0
	movq $string1, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13
	 # == 
	 cmpq %r13, %r10
	 movq $1, %r12
	 movq $0, %r11
	 cmove %r12, %r10
	 cmovne %r11, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9!=8%d\n" top=0
	movq $string2, %rbx

	# push 9
	movq $9,%r10

	# push 8
	movq $8,%r13
	 # != 
	 cmpq %r13, %r10
	 movq $1, %r12
	 movq $0, %r11
	 cmovne %r12, %r10
	 cmove %r11, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	#top=0

	# push string "9!=9=%d\n" top=0
	movq $string3, %rbx

	# push 9
	movq $9,%r10

	# push 9
	movq $9,%r13
	 # != 
	 cmpq %r13, %r10
	 movq $1, %r12
	 movq $0, %r11
	 cmovne %r12, %r10
	 cmove %r11, %r10
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
	.string "9==8%d\n"

string1:
	.string "9==9=%d\n"

string2:
	.string "9!=8%d\n"

string3:
	.string "9!=9=%d\n"

