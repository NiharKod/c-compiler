.data
 .comm queens, 8
.data
 .comm solid, 8
	.text
.globl abs
abs:
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
	movq -8(%rbp), %rbx

	# push 0
	movq $0,%r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je if_false_0

	# push -1
	movq $-1,%rbx
	movq -8(%rbp), %r10

	# *
	imulq %r10,%rbx
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
	jne if_false_after_else_0
	if_false_0:
	if_false_after_else_0:
	movq -8(%rbp), %rbx
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
.globl check
check:
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
	movq %rbx, -16(%rbp)
for_start_1:
	movq -16(%rbp), %rbx
	movq -8(%rbp), %r10
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
	movq -16(%rbp), %rbx
	 movq queens, %rax
	 movq (%rax, %rbx, 8), %rbx
	movq -8(%rbp), %r10
	 movq queens, %rax
	 movq (%rax, %r10, 8), %r10
	 # == 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmove %r12, %rbx
	 cmovne %r11, %rbx
	movq -16(%rbp), %r10
	 movq queens, %rax
	 movq (%rax, %r10, 8), %r10
	movq -8(%rbp), %r13
	 movq queens, %rax
	 movq (%rax, %r13, 8), %r13

	# -
	subq %r13,%r10
     # func=abs nargs=1
     # Move values from reg stack to reg args
	movq %r10, %rdi
	call abs
	movq %rax, %r10
	movq -8(%rbp), %r13
	movq -16(%rbp), %r14

	# -
	subq %r14,%r13
	 # == 
	 cmpq %r13, %r10
	 movq $1, %r12
	 movq $0, %r11
	 cmove %r12, %r10
	 cmovne %r11, %r10
	 # || 
	 or %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovne %r12, %rbx
	 cmove %r11, %rbx
	cmpq $0, %rbx
	je if_false_2

	# push 0
	movq $0,%rbx
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
	jne if_false_after_else_2
	if_false_2:
	if_false_after_else_2:
jmp loop_start_1
end_for_1:
loop_end_1:
	# push 1
	movq $1,%rbx
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
.globl bruteforce
bruteforce:
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
	movq -8(%rbp), %rbx

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
	#top=0

	# push string "Solution #%2ld = [ " top=0
	movq $string0, %rbx
	movq solid, %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	movq solid, %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, solid

	# push 0
	movq $0,%rbx
	movq %rbx, -16(%rbp)
for_start_4:
	movq -16(%rbp), %rbx

	# push 8
	movq $8,%r10
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
	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -16(%rbp)
jmp for_start_4
for_body_4:
	#top=0

	# push string "%ld " top=0
	movq $string1, %rbx
	movq -16(%rbp), %r10
	 movq queens, %rax
	 movq (%rax, %r10, 8), %r10

	# push 1
	movq $1,%r13

	# +
	addq %r13,%r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
jmp loop_start_4
end_for_4:
loop_end_4:	#top=0

	# push string "]\n" top=0
	movq $string2, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx

	# push 0
	movq $0,%rbx
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
	jne if_false_after_else_3
	if_false_3:
	if_false_after_else_3:

	# push 0
	movq $0,%rbx
	movq %rbx, -16(%rbp)
for_start_5:
	movq -16(%rbp), %rbx

	# push 8
	movq $8,%r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je end_for_5
	 jmp for_body_5
	 loop_start_5:
	movq -16(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -16(%rbp)
jmp for_start_5
for_body_5:
	movq -8(%rbp), %rbx
	movq -16(%rbp), %r10
	 movq queens, %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -8(%rbp), %rbx
     # func=check nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call check
	movq %rax, %rbx

	# push 0
	movq $0,%r10
	 # != 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovne %r12, %rbx
	 cmove %r11, %rbx
	cmpq $0, %rbx
	je if_false_6
	movq -8(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
     # func=bruteforce nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call bruteforce
	movq %rax, %rbx
	jne if_false_after_else_6
	if_false_6:
	if_false_after_else_6:
jmp loop_start_5
end_for_5:
loop_end_5:
	# push 0
	movq $0,%rbx
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

	# push 8
	movq $8,%rbx

	# push 8
	movq $8,%r10

	# *
	imulq %r10,%rbx
     # func=malloc nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call malloc
	movq %rax, %rbx
	movq %rbx, queens

	# push 1
	movq $1,%rbx
	movq %rbx, solid

	# push 0
	movq $0,%rbx
     # func=bruteforce nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call bruteforce
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
	.string "Solution #%2ld = [ "

string1:
	.string "%ld "

string2:
	.string "]\n"

