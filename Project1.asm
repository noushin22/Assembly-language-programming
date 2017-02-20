# Name: Noushin Iqra
# Last modified date: 12/8/2016
# This program gets integer inputs from the user to store in an array of size 10, then prints out each element, 
# along with the sum of all 10 elements.
# This program in C++ language:              
#		int main () { 	
#		int n, a[10], sum = 0;
#		    for(int i=0; i<10; i++) {
#	   		cout<< "Enter an integer to store in element " << i << " of array A: "; 
#	   		cin >> n;
#	     		     a[i] = n;
#	      		     sum = sum+a[i]; 	 }
#	    	          for(int i=0; i<10; i++) {
#				cout << "Element " << i << " of array A contains: " << a[i] << endl; }	
#		    cout << "The sum of the 10 elements of array A is: " << sum << endl;
#		return 0; }
# Registers: 	
#		$t0 = stores the offset		    $s0 = points to the address of array A		 $a0 = stores the output values
#		$t1 = stores the inputs		    $s1 = stores the elements to add to the sum	      	 $v0 = stores the return values
#		$t7 = counter for 10 inputs	    $s2 = stores the sum of 10 elements
#		$t8 = counter for 10 outputs						
		
		.data
A:		.space		40	#size of the array in bytes
prompt1:	.asciiz		"Enter an integer to store in element "
prompt2: 	.asciiz		" of array A: "
output_msg1:	.asciiz		"\nElement "
output_msg2:	.asciiz		" of array A contains: "
sum:		.asciiz		"\n\nThe sum of the 10 elements of array A is: "

		.text
main:	 
		la  $s0, A		# $s0 = points to the address of array A
		li  $t7, 0  		#counter
		li  $t8, 0		#counter
		li  $s2, 0		#initialize the sum = 0
loop:		
		#print the prompt 
		la  $a0, prompt1	# $a0 = address to prompt1
		li  $v0, 4
		syscall
		
		#printing the element number
		la  $a0, ($t7)
		li  $v0, 1
		syscall
		
		#print the rest of the prompt
		la  $a0, prompt2	# $a0 = address to prompt2
		li  $v0, 4
		syscall
		
		#get the input from the user, and move it in register $t1
		li  $v0, 5
		syscall
		move  $t1, $v0
		 
		sll  $t0, $t7, 2	#multiplying by 4(as needed for integers), $t0 stores the number of bits of offset
		addu  $t0, $t0, $s0	#$t0 = $s0+$t0, adding the base address and the offset, to get index, and storing in register $t1
		sw   $t1, 0($t0)	#A[$t0]= $t1, loading the value in $t1 to the memory address of element A[$t0] 
		
		#increment counter by 1, if the counter is = to 10 branch to print, else jump to loop
		addi  $t7, $t7, 1	
		beq  $t7, 10, print	
		j loop
		
print:		
		#print the output message
		la  $a0, output_msg1	# $a0 = address to output_msg1
		li  $v0, 4
		syscall
		
		#print the element number
		la  $a0, ($t8)
		li  $v0, 1
		syscall
		
		#print the rest of the output message
		la  $a0, output_msg2	# $a0 = address to output_msg2
		li  $v0, 4
		syscall
		
		lw   $a0, 0($s0)	#load the content of an element in array A in register $a0
		
		move   $s1, $a0		#copy content of $a0 to register $s1
		addu   $s2, $s2, $s1	#to get the sum, add the value of each element and store in register $s2, until loop ends
		
		#print the value in element from the array
		li   $v0, 1
		syscall
		
		addi  $s0, $s0, 4	#move to the next offset by 4 bytes
		
		#increment counter by 1, if the counter is = to 10 branch to done, else jump to print
		addi  $t8, $t8, 1
		beq  $t8, 10, done  
		j print
		
done:
		#print the sum message
		la  $a0, sum		# $a0 = address to the sum message
		li  $v0, 4
		syscall
		
		#print the sum
		la  $a0, ($s2)
		li  $v0, 1
		syscall
		
		#execute the program
		li  $v0, 10
		syscall

	
