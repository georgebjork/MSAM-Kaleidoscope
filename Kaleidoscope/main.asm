TITLE MP5

Include Irvine32.inc 


.data

array1 BYTE 24 DUP(?)	;this will hold one line of ints 
background BYTE 16		;this will be what we multiply eax by to get a the proper backgroubd on text
maxSize BYTE 23			;the max size of the kaleidoscope

xCoord BYTE 0	;xCoord default
yCoord BYTE 0	;yCoord default

.code 

generateLine PROC

	call Randomize                          ;srand(time(NULL))
	mov ecx, 12								;run loop 12 times
	mov esi, 0
	mov eax, 0
	l1:                                     ;Fill array with random values
		mov al, 12							;range 
		call RandomRange					;call random number within range (stackoverflow.com/questions/10475590/assembly-random-number-using-irvine)
		mov array1[esi*TYPE BYTE], al		;move the number into the array 
		inc esi

	LOOP l1

	mov ecx, 12
	mov esi, 0
	l2:                                         ;Copy first 12 array values in reverse order into last 12 spaces
		mov bl, array1[ecx*TYPE BYTE]-1
		mov eax, ecx							;eax is going to hold ecx
		add ecx, esi							;add ecx and esi to get our index

		mov array1[ecx*TYPE BYTE], bl			; move value in ebx into array at ecx index
		add esi, 2                              ; esi += 2 to adjust for ecx decreasing each loop 
		mov ecx, eax

	LOOP l2
	ret
generateLine ENDP

printAllLines PROC
	mov ecx, 24
	mov esi, 0
	mov dl, xCoord	;set x
	
	loop1:
		mov al, array1[esi*TYPE BYTE]							;grab number from array
		mul background											;multiply by 16 to set background same as text
		add al, array1[esi*TYPE BYTE]							;add number by 16
		call SetTextColor										;set text color from eax
							
		mov eax, "    "											;what we want to print

		;Move cursor to (dl, dh)
		call Gotoxy 											;go to xy
		call WriteChar ; Write '*' in bottom right				;write char
		call Crlf

		;now lets print out a mirror image
		mov bl, dh												;hold onto our lasy y coord
		mov dh, maxSize											;make y coord the largest it can be 
		sub dh, bl												;now lets subract the largest from our last y coord to give a mirrored image 

		;Move cursor to (dl, dh)
		call Gotoxy 											;go to xy
		call WriteChar ; Write '*' in bottom right				;write char
		call Crlf

		mov dh, bl												;reset to old y coord so code can run properly 

		inc esi
		inc dl													;move the x over 1
	LOOP loop1
	
	ret
printAllLines ENDP


main PROC

mov esi, 0
mov ecx, 10

;this will the kaleidoscope forever
foreverLoop:

	;push the forever loop esi and ecx
	push esi
	push ecx

	mov esi, 0
	mov ecx, 12			;how many times we want to run this loop 
	mov dh, yCoord	   ;set y	

	mainLoop:
		push esi													;push to the stack
		push ecx													;push to the stack 

		call generateLine		;generate a line
		call printAllLines		;print the line(s)

		pop ecx														;retrive from stack 
		pop esi														;retrive from stack 
		inc esi 
		inc dh
	
	LOOP mainLoop

	;here we are intenionally gonna pop esi and ecx incorrectly to create a forever loop
	pop esi
	pop ecx
	inc esi

	mov eax, 500
	call Delay		;delay the code slightly based on the value in eax
LOOP foreverLoop

	;move cursor out of way so we can see final product 
	mov dh, 27
	mov dl, 0
	call Gotoxy

exit 
main ENDP 
END main
