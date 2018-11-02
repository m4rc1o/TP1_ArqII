li $v0, 5		# read and int from the user
syscall 		# call the system
move $t1, $v0		# saves the input into T1

add $t3, $t3, 1 	# variable mult T3 = 1
add $t2, $t2, 2 	# variable i T2 = 2

blt $t1 , $t2 RETURN	# if the entry is less than 2, return printing 0

LOOP:
bgt  $t2, $t1 , DONE 	# if N > i, finaliza o loop
mult $t3, $t2  		# multiply  t3 to the next even number
mflo $t3		# save the value of T3
add $t2 ,$t2, 2		# increase the 'i' of the  loop in 2 
j LOOP			# run the loop again

DONE:
li $v0, 1		# print
move $a0, $t3		# the value of the multiplications
syscall
li $v0, 10              # finish the program
syscall			# Exit 

RETURN:			
li $v0, 1		#print
move $a0, $0		#value of 0
syscall