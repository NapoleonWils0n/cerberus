# HelloWorld Assembly

# compile the program
# as -o HelloWorldProgram.o HelloWorldProgram.s

# link 
# ld -o HelloWorldProgram HelloWorldProgram.o

# then run the program
# ./HelloWorldProgram

.data

HelloWorldString:
	.ascii "Hello World\n"

.text

.globl _start

_start:
	# load all the arguments for write ()

	movl $4, %eax
	movl $1, %ebx
	movl $HelloWorldString, %ecx
	movl $12, %edx
	int $0x80

	# exit the program

	movl $1, %eax
	movl $0, %ebx
	int $0x80
