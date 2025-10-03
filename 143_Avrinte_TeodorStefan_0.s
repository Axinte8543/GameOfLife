.data
    matrix: .space 1600
    columnIndex: .space 4
    lineIndex: .space 4
    n: .space 4 
    m: .space 4
    k: .space 4
    nCopy: .space 4
    mCopy: .space 4
    p: .space 4
    index: .space 4
    left: .space 4
    right: .space 4
    left1: .space 4
    right1: .space 4
    val: .space 4
    valoare: .space 4
    valoare1: .space 4
    valoare2: .space 4
    valoare3: .space 4
    ct1: .space 4
    ct: .space 4
    formatScanf: .asciz "%d"
    formatPrintf: .asciz "%d "
    newLine: .asciz "\n"
.text

.global main

main:
    push $m
    push $formatScanf
    call scanf
    addl $8,%esp

    push $n
    push $formatScanf
    call scanf
    addl $8,%esp
    
    push $p
    push $formatScanf
    call scanf
    addl $8,%esp

    movl $0, index
    movl m,%ebx
    movl %ebx,mCopy
    movl n,%ebx
    movl %ebx,nCopy
    addl $2,mCopy
    addl $2,nCopy
et_for:
    movl index, %ecx
    cmp %ecx,p
    je ceva
    
    push $left
    push $formatScanf
    call scanf
    addl $8,%esp
    
    push $right
    push $formatScanf
    call scanf
    addl $8,%esp
    
    addl $1,left
    addl $1,right
    
    movl left,%eax
    movl $0,%edx
    mull nCopy
    addl right,%eax

    lea matrix, %edi
    movl $1, (%edi,%eax,4)

    incl index
    jmp et_for

ceva:
   push $k
   push $formatScanf
   call scanf
   addl $8,%esp
   
   movl $1,%ebx
   movl %ebx,left
   movl $1,%ebx
   movl %ebx,right
   movl $0,ct
   
   movl nCopy,%ebx
   movl %ebx,p
   subl $1,p
   movl mCopy,%ebx
   movl %ebx,index
   subl $1,index
   
   incl k
rezolvare:
   movl $1,left
   incl ct
   movl ct,%ecx
   cmpl %ecx,k
   je et_afis_matr
   for_lines1:      
      movl left,%ecx
      cmp %ecx,index
      je ajutor
      
      movl $1,right 
      for_columns1:
         movl right,%ecx
         cmpl %ecx,p
         je crestere

         movl left,%eax
         movl $0,%edx
         mull nCopy
         addl right,%eax
         lea matrix,%edi
         movl (%edi,%eax,4),%ebx
         movl %ebx,valoare
         movl %eax,val
      
         movl right,%eax
         movl %eax,right1
         movl left,%eax
         movl %eax,left1    
           
         jmp doi2
        
        doispe1:
         movl $0,valoare3 
         movl $1,%ecx
         cmpl %ecx,valoare1
         je creste
        doispe: 
         movl $1,%ecx
         cmpl %ecx,valoare2
         je creste1
        treispe: 
         movl $0,%ecx
         cmpl %ecx,valoare3
         je creste2
        paispe: 
         movl val,%eax
         movl valoare,%ecx
         movl %ecx,(%esi,%eax,4) 
         
         incl right
         jmp for_columns1
        ajutor:
           movl $1,lineIndex
           for_lines2:
               movl lineIndex, %ecx
               cmp %ecx,index
               je rezolvare

               movl $1, columnIndex
               for_columns2:
                   movl columnIndex, %ecx
          	   cmp %ecx,p
           	   je crestere2

           	   movl lineIndex, %eax
           	   movl $0,%edx
           	   mull nCopy
           	   addl columnIndex, %eax

           	   lea matrix,%edi
           	   movl (%esi,%eax,4), %ebx
                   movl %ebx,(%edi,%eax,4)
           
           	   incl columnIndex
           	   jmp for_columns2
doi2:
       movl $0,ct1
     unu:    
       subl $1,right
       subl $1,left
       movl left,%eax
       movl $0,%edx
       mull nCopy
       addl right,%eax
      	    
       lea matrix,%edi
       movl (%edi,%eax,4),%ebx
       movl $1,%ecx
       cmpl %ebx,%ecx
       je unu1
     doi: 
       addl $1,right
       movl left,%eax
       movl $0,%edx
       mull nCopy
       addl right,%eax
         
       lea matrix,%edi
       movl (%edi,%eax,4),%ebx
       movl $1,%ecx
       cmpl %ebx,%ecx
       je doi1
     trei: 
       addl $1,right
       movl left,%eax
       movl $0,%edx
       mull nCopy
       addl right,%eax
         
       lea matrix,%edi 
       movl (%edi,%eax,4),%ebx 
       movl $1,%ecx
       cmpl %ebx,%ecx
       je trei1
     patru: 
       addl $1,left
       movl left,%eax
       movl $0,%edx
       mull nCopy
       addl right,%eax
         
       lea matrix,%edi
       movl (%edi,%eax,4),%ebx
       movl $1,%ecx
       cmpl %ebx,%ecx
       je patru1
     cinci: 
       addl $1,left
       movl left,%eax
       movl $0,%edx
       mull nCopy
       addl right,%eax 
         
       lea matrix,%edi
       movl (%edi,%eax,4),%ebx
       movl $1,%ecx
       cmpl %ebx,%ecx
       je cinci1
     sase: 
       subl $1,right
       movl left,%eax
       movl $0,%edx
       mull nCopy
       addl right,%eax
         
       lea matrix,%edi
       movl (%edi,%eax,4),%ebx
       movl $1,%ecx
       cmpl %ebx,%ecx
       je sase1
     sapte:      
       subl $1,right
       movl left,%eax
       movl $0,%edx
       mull nCopy
       addl right,%eax
    
       lea matrix,%edi
       movl (%edi,%eax,4),%ebx
       movl $1,%ecx
       cmpl %ebx,%ecx
       je sapte1
     opt:      
       subl $1,left
       movl left,%eax
       movl $0,%edx
       mull nCopy
       addl right,%eax
      
         
       lea matrix,%edi
       movl (%edi,%eax,4),%ebx
       movl $1,%ecx
       cmpl %ebx,%ecx
       je opt1
     noua:    
       movl $0,valoare1
       movl $0,valoare2
 
       movl $3,%edx
       cmpl ct1,%edx
       je zero1
     zece:     
       movl $2,%edx
       cmpl ct1,%edx
       je zero2
     unspe:
       movl right1,%eax
       movl %eax,right
       movl left1,%eax
       movl %eax,left 
       call doispe1
unu1:
      incl ct1
      call doi
doi1:
      incl ct1
      call trei
trei1:
      incl ct1
      call patru
patru1:
      incl ct1
      call cinci
cinci1:
      incl ct1
      call sase
sase1:
      incl ct1
      call sapte
sapte1:
      incl ct1
      call opt
opt1:
      incl ct1
      call noua         
                                          
zero1:
      incl valoare1
      call zece
zero2:
      incl valoare2
      call unspe

creste1:
      movl $1,%ecx
      cmpl %ecx,valoare  
      je creste3
     cinspe: 
      call treispe
creste:
      movl $1,valoare
      incl valoare3
      call doispe
creste2:
      movl $0,valoare
      call paispe
creste3:
      movl $1,valoare
      incl valoare3
      call cinspe      
crestere:
      incl left
      jmp for_lines1
crestere2:
      incl lineIndex
      jmp for_lines2    

et_afis_matr:
   movl $1,lineIndex
   for_lines:
       movl lineIndex, %ecx
       cmp %ecx,index
       je et_exit

       movl $1, columnIndex
       for_columns:
           movl columnIndex, %ecx
           cmp %ecx,p
           je cont

           movl lineIndex, %eax
           movl $0,%edx
           mull nCopy
           addl columnIndex, %eax

           lea matrix,%edi
           movl (%edi,%eax,4), %ebx
           movl %ebx,valoare
           
           push valoare
           push $formatPrintf
           call printf
           addl $8,%esp

           push $0
           call fflush
           addl $4,%esp
 

           incl columnIndex
           jmp for_columns


        cont:
          movl $4,%eax
          movl $1,%ebx
          movl $newLine,%ecx
          movl $2,%edx
          int $0x80
          
          incl lineIndex
          jmp for_lines

          et_exit:
           movl $1,%eax
           movl $0,%ebx
           int $0x80
