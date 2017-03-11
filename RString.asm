; Programming Assignment 4
; CSCI 2525 Assembly Language
; Patricia Figueroa 


TITLE RString.asm
INCLUDE Irvine32.inc    


.data 								; data directive segment, this is the data area
prompt1 byte "Please enter an integer value between 5 and 25: " , 0
L = 25                              ; the instructions say that L is between 5 and 25
userInput byte 0h                   ; used for user input to pass back as an argument 
myString byte L DUP(0)		          ;array for the string where L= 25, and initialized at 0	
invalid byte "Invalid Entry. Please try again.", 0		; user prompt for invalid entry
mainPrompt byte "How many times do you want to generate a random string?: ", 0    ; user input for the amount of times the random string will be generated 
numStrings dword 0h					        ; stores ecx in a data memory to be used later 

.code                               ; code segment

main proc          					        ; main procedure 
call Randomize   				            ; init random generator with a unique value 
StartPoint:                         ; MAIN LOOP 
	mov edx, OFFSET	mainPrompt        ; procure that writes a null terminated string to the console window  
	call WriteString				          ; passes the string's offset in edx
	call ReadInt                      ; reads a signed integer from the keyboard , and returns the value in eax
	cmp eax, 0						            ; compares eax 
	jle InputError					          ; jumps to InputError if less than or equal to

	mov numStrings, eax				        ; moves numStrings into eax 
	jmp GetStringLength				        ; else jumps back to GetStringLength 

InputError:							            ; Writes invalid entry if user inputs invalid number outside the range 
mov edx, OFFSET	invalid				
	call WriteString
	call Crlf						              ; displays a new line 
	jmp StartPoint					          ; back to Startpoint

GetStringLength:
	call UserInt                      ; User input procedure 

	mov edx, numStrings
GenerateStrings:
	call RandStr               		    ; Random string procedure 
	dec edx							              ; decrements edx 
	;call DumpRegs
	cmp edx, 0						            ; compares edx 
	je Finished						            ; if equal back to finished 
	jmp GenerateStrings				        ; else jump to GenerateStrings


Finished: 
	call WaitMsg					            ; Displays the message "Press any key to continue..."
	
exit
main endp


;==================================================================;
; UserInt PROC                                                     ;
                                                                   ;
; Asks for an unsigned interger inut from the user                 ;
; The procedure must pass the integer back to the calling          ;
; procedure as an argument (register)                              ;
;                                                                  ;
; Function: prompts the user to enter an integer into the terminal ;
; Requires: string array containing a prompt  					          
; Recieves: does not receive anything							                 ;
; Returns : the integer that the user entered stored in eax		     ;
;==================================================================;

UserInt PROC 

GetUserInput:                                 
mov edx, OFFSET prompt1                		 
call WriteString 
call ReadInt
call Crlf                    ; display a new line 
cmp eax, 25									 ; compares the user input between L= 5-25 
	jg ErrorMsg								 ; if greater then, error message
cmp eax, 5									 ; compares if less than 5
	jl ErrorMsg								 ; jump is less, display error message

jmp Accept

ErrorMsg:
mov edx, OFFSET invalid      ; Displays invalid entry message
call WriteString
call Crlf
jmp GetUserInput

Accept:
mov ecx, eax 
mov eax, OFFSET myString
ret 
UserInt ENDP 


;==================================================================;
; RandStr PROC                                                     ;
                                                                   ;
; Function: Generates a string of length L, where L is between 5   ;
; and 25 containg random capital letters the using ASCII code      ;
; for capital 													                           ;
; letters
;                                                                  ;                                                     
; Requires: nothing							  					   
; Recieves: 	eax, containg the length of the string			         ;
; Returns : 	nothing, the string is kept within the function	     ;
;==================================================================;


RandStr PROC                    ; RandStr Procedure
push eax						
push ecx

mov esi, eax
produceString:
mov eax, 25                     ; A =0 , Z=25
call RandomRange 
call SetTextColor 
add eax, 'A'                    ; A ASCII value 
mov [esi], al                   ;
inc esi                         ; increment esi
call WriteChar
loop produceString              ; stores random string in esi  
call Crlf						; 
pop ecx
pop eax
ret
RandStr ENDP


;==================================================================;
; SetextColor PROC                                                 ;
                                                                   ;
; Function: prints each part of the string in a random foreground  ;
; color , excludes black
;                                                                  ;                                                     
; Requires: nothing							  					   
; Recieves: 	eax, containg the length of the string			         ;
; Returns : 	ntthing, the string is kept within the function	     ;
;==================================================================;

SetextColor PROC              
   push eax              
   mov eax, 15           		; SetTextColor is from 0 to n-1 and the colors go from 0 to 14, therefore you would never get white
   add eax, 1          			; for black to not be a set color
   call SetTextColor			
   pop eax
   
   ret
   SetextColor ENDP



end main
