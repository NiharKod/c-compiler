	.text
.globl printArray
printArray:
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
	movq -16(%rbp), %rbx
	movq %rbx, -32(%rbp)
for_start_0:
	movq -32(%rbp), %rbx
	movq -24(%rbp), %r10
	 # <= 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovle %r12, %rbx
	 cmovg %r11, %rbx
	cmpq $0, %rbx
	je end_for_0
	 jmp for_body_0
	 loop_start_0:
	movq -32(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -32(%rbp)
jmp for_start_0
for_body_0:
	#top=0

	# push string "%d\n" top=0
	movq $string0, %rbx
	movq -32(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
     # func=printf nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
jmp loop_start_0
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
.globl print
print:
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
	#top=0

	# push string "==%s==\n" top=0
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
	.text
.globl quicksortsubrange
quicksortsubrange:
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
	movq -24(%rbp), %rbx
	movq -16(%rbp), %r10

	# -
	subq %r10,%rbx

	# push 1
	movq $1,%r10
	 # <= 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovle %r12, %rbx
	 cmovg %r11, %rbx
	cmpq $0, %rbx
	je if_false_1

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
	jne if_false_after_else_1
	if_false_1:
	if_false_after_else_1:
	movq -24(%rbp), %rbx
	 movq -8(%rbp), %rax
	 movq (%rax, %rbx, 8), %rbx
	movq %rbx, -32(%rbp)
	movq -16(%rbp), %rbx
	movq %rbx, -40(%rbp)
	movq -24(%rbp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	movq %rbx, -48(%rbp)
loop_start_2:
	movq -40(%rbp), %rbx
	movq -48(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je loop_end_2
loop_start_3:
	movq -40(%rbp), %rbx
	movq -48(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	movq -40(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
	movq -32(%rbp), %r13
	 # < 
	 cmpq %r13, %r10
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %r10
	 cmovge %r11, %r10
	 # && 
	 and %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovne %r12, %rbx
	 cmove %r11, %rbx
	cmpq $0, %rbx
	je loop_end_3
	movq -40(%rbp), %rbx

	# push 1
	movq $1,%r10

	# +
	addq %r10,%rbx
	movq %rbx, -40(%rbp)
	jmp loop_start_3
loop_end_3:
loop_start_4:
	movq -40(%rbp), %rbx
	movq -48(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	movq -48(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
	movq -32(%rbp), %r13
	 # > 
	 cmpq %r13, %r10
	 movq $1, %r12
	 movq $0, %r11
	 cmovg %r12, %r10
	 cmovle %r11, %r10
	 # && 
	 and %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovne %r12, %rbx
	 cmove %r11, %rbx
	cmpq $0, %rbx
	je loop_end_4
	movq -48(%rbp), %rbx

	# push 1
	movq $1,%r10

	# -
	subq %r10,%rbx
	movq %rbx, -48(%rbp)
	jmp loop_start_4
loop_end_4:
	movq -40(%rbp), %rbx
	movq -48(%rbp), %r10
	 # < 
	 cmpq %r10, %rbx
	 movq $1, %r12
	 movq $0, %r11
	 cmovl %r12, %rbx
	 cmovge %r11, %rbx
	cmpq $0, %rbx
	je if_false_5
	movq -40(%rbp), %rbx
	 movq -8(%rbp), %rax
	 movq (%rax, %rbx, 8), %rbx
	movq %rbx, -56(%rbp)
	movq -40(%rbp), %rbx
	movq -48(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -48(%rbp), %rbx
	movq -56(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	jne if_false_after_else_5
	if_false_5:
	if_false_after_else_5:
	jmp loop_start_2
loop_end_2:
	movq -24(%rbp), %rbx
	movq -40(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq (%rax, %r10, 8), %r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -40(%rbp), %rbx
	movq -32(%rbp), %r10
	 movq -8(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	movq -8(%rbp), %rbx
	movq -16(%rbp), %r10
	movq -40(%rbp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=quicksortsubrange nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksortsubrange
	movq %rax, %rbx
	movq -8(%rbp), %rbx
	movq -48(%rbp), %r10

	# push 1
	movq $1,%r13

	# +
	addq %r13,%r10
	movq -24(%rbp), %r13
     # func=quicksortsubrange nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksortsubrange
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
	.text
.globl quicksort
quicksort:
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

	# push 0
	movq $0,%r10
	movq -16(%rbp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=quicksortsubrange nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksortsubrange
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

	# push string "Hello" top=0
	movq $string2, %rbx
     # func=print nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	call print
	movq %rax, %rbx

	# push 10
	movq $10,%rbx
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

	# push 0
	movq $0,%rbx

	# push 8
	movq $8,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 1
	movq $1,%rbx

	# push 7
	movq $7,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 2
	movq $2,%rbx

	# push 1
	movq $1,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 3
	movq $3,%rbx

	# push 9
	movq $9,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 4
	movq $4,%rbx

	# push 11
	movq $11,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 5
	movq $5,%rbx

	# push 83
	movq $83,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 6
	movq $6,%rbx

	# push 7
	movq $7,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 7
	movq $7,%rbx

	# push 13
	movq $13,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 8
	movq $8,%rbx

	# push 94
	movq $94,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)

	# push 9
	movq $9,%rbx

	# push 1
	movq $1,%r10
	 movq -16(%rbp), %rax
	 movq %r10, (%rax, %rbx, 8)
	#top=0

	# push string "-------- Before -------\n" top=0
	movq $string3, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	movq -16(%rbp), %rbx

	# push 0
	movq $0,%r10
	movq -8(%rbp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=printArray nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call printArray
	movq %rax, %rbx
	movq -16(%rbp), %rbx
	movq -8(%rbp), %r10
     # func=quicksort nargs=2
     # Move values from reg stack to reg args
	movq %r10, %rsi
	movq %rbx, %rdi
	call quicksort
	movq %rax, %rbx
	#top=0

	# push string "-------- After -------\n" top=0
	movq $string4, %rbx
     # func=printf nargs=1
     # Move values from reg stack to reg args
	movq %rbx, %rdi
	movl    $0, %eax
	call printf
	movq %rax, %rbx
	movq -16(%rbp), %rbx

	# push 0
	movq $0,%r10
	movq -8(%rbp), %r13

	# push 1
	movq $1,%r14

	# -
	subq %r14,%r13
     # func=printArray nargs=3
     # Move values from reg stack to reg args
	movq %r13, %rdx
	movq %r10, %rsi
	movq %rbx, %rdi
	call printArray
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
	.string "%d\n"

string1:
	.string "==%s==\n"

string2:
	.string "Hello"

string3:
	.string "-------- Before -------\n"

string4:
	.string "-------- After -------\n"

