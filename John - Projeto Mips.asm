 .data
 terminoop: .asciiz "O PROGRAMA ESTARA SENDO FINALIZADO!!!....."
 Menu: .asciiz "=-=-=-=-=-= MENU DE OP��ES! =-=-=-=-=-=\n1 - Fahrenheit = > Celsius\n2 - Fatorial\n3 - Enesimo par\n4 - Equacao de 2� grau\n5 - Sair\n"
 linhas: .asciiz "=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n"
 incorreto: .asciiz "Voc� digitou um n�mero n�o valido, sera redirecionado para o Menu!\n"
 finish: .asciiz  "Finalizando o programa!!"
 start: .asciiz "\nDigite um n�mero inteiro(negativos ou positivos), para encontrar seu en�simo par: "
 fim: .asciiz "O valor da posi��o "
 paresp: .asciiz "� na sequ�ncia dos conjuntos dos pares positivos �: "
 paresn: .asciiz "� na sequ�ncia dos conjuntos dos pares negativos �: "
 newline: .asciiz "\n"
 saudacao: .asciiz "\nDigite um n�mero em Fahrenheit: "
 resultadoC: .asciiz "Convertendo Fahrenheit em Celsius fica: "
 zero: .double 0.0
 muti: .double 0.555556  # Divisao de 5/ pra fazer a 1 opc��o
 soma: .double 32.0 
 digite: .asciiz "\nDigite um n�mero inteiro para descobrimos o fatorial: "
 resultado: .asciiz "Resultado de "
 fator: .asciiz "! �: "
 impri: .asciiz  "0! = 1"
 negativo: .asciiz "N�o existe Fatorial de um n�mero negativo.\n~~~ Voc� sera direcionado para o Menu! ~~~"
 bemv: .asciiz "\nVamos Calcula as ra?zes da equacao de 2� grau dado a, b e c.\n"
 rA: .asciiz "\nInforme a raiz (a): "
 rB: .asciiz "\nInforme a raiz (b): "
 rC: .asciiz "\nInforme a raiz (c): "
 resultadoD: .asciiz "\nO valor de Delta �: "
 raiz1: .asciiz " Valor de X1: "
 raiz2: .asciiz " Valor de X2: "
zero0: .asciiz "\nN�o existe Raiz de 2 grau com a = 0\nTente novamente!!"
 semraiz: .asciiz "\nDelta menor que zero, a equação não possui valores reais\n"
 .text
 
menu:

  li $v0, 4
  la $a0, Menu #Opções pra selecionar
  syscall 
  
  li $v0, 4
  la $a0, linhas
  syscall 
  
  li $v0, 5 #entrada do usuario, referente a opção
  syscall
   
  move $t0, $v0
  beq $t0, 1, FCE #chamado a label de calculo de convers�o
  beq $t0, 2, FAT #chamado a label fatorial
  beq $t0, 3, ENE #chamado a label do enesimo
  beq $t0, 4, EQU #chamado a label da equação
  beq $t0, 5, FINALIZADO #label do fim
  
  li $v0, 4
  la $a0, incorreto
  syscall
  
  li $v0, 4
  la $a0, newline
  syscall 
  
  j menu

###################################################################################################
  #ESCOLHENDO A 1 OP��O
###################################################################################################  
FCE:
  li $v0, 4
  la $a0, saudacao #msg solicitando o valor
  syscall
  
  li $v0, 7 # Entrada do usuario
  syscall 
  
  ldc1 $f2, zero #colocando os valores nos registradores
  ldc1 $f6, soma
  ldc1 $f8, muti
  sub.d $f4, $f0, $f6 # efetuando a sub de 5/9
  mul.d $f10, $f4, $f8 # multiplicando com entrada "F"
  add.d $f12, $f2, $f10 # somando mais 32 e finazliando o resultado
  
  li $v0, 4
  la $a0, resultadoC #resultado expresso
  syscall
  
  li $v0, 3
  syscall 
    
   li $v0, 4
   la $a0, newline
   syscall 
    
   li $v0, 4
   la $a0, linhas
   syscall
   
   li $v0, 4
   la $a0, newline
   syscall  
   
   j menu

###################################################################################################
  #ESCOLHENDO A 2 OP��O
###################################################################################################

FAT:

 li $v0, 4
  la $a0, digite #msg pra solicitar dados
  syscall 
  
  li $v0, 5 #entrada de dados do usu�rio
  syscall 
  
  move $a0, $v0
  move $t1, $v0
   
  move $t0, $zero #contador
  add $t2, $zero, 1 #base pra multiplicar
  
  beq $t1, $zero, impri1 # pula pra informa que o 0!=1
  blt $t1, $zero, fatornegativo # avisa que n�o existe fator negativo
 
  while:
    beq $t0, $t1, calculo # os calculos chegam em 12! e para de funcionar, bug?
    addi $t0, $t0, 1 #aumentando o contador
    mul $t2, $t0, $t2 #multiplcando conforme o numero do contador
    j while
      
  calculo:
    li, $v0, 4
    la $a0, resultado #msg de resultado
    syscall 
    
    li, $v0, 1
    move $a0, $t1 #valor que usu�rio deu de entrada
    syscall 
    
    li, $v0, 4
    la $a0, fator #complemento da frase
    syscall 
  
    move $a0, $t2 
    li $v0,1 # valor impresso
    syscall
    
    li $v0,4
    la $a0, newline
    syscall 
    
    li $v0,4
    la $a0, newline
    syscall 
    
    j menu
    
  impri1:
    li $v0, 4
    la $a0, impri # caso seja 0
    syscall 
    
    li $v0, 4
    la $a0, newline
    
    j menu
    
  fatornegativo:
   li $v0, 4
   la $a0, negativo #caso seja negativo ele gera uma msg de que n existe
   syscall 
   
    li $v0, 4
   la $a0, newline
   syscall 
    
   li $v0, 4
   la $a0, linhas
   syscall
   
   li $v0, 4
   la $a0, newline
   syscall 
   
   j menu

###################################################################################################
  #ESCOLHENDO A 3 OP��O, N�MERO ENESIMO
###################################################################################################
ENE: 

 li $v0, 4
 la $a0, start # mmsg de come�o e pedido da entrada do usu�rio
 syscall 
 
 li $v0, 5 
 syscall 
 
 move $t1,$v0
 add $t2, $zero, $zero # formando o incial
 move $t0, $zero # variavel contador i=0 
 bltz $t1, whileparnegativo # base de calculo expressa pelo conjuntos dos negativos
 
 whilepar:
 
   beq $t0, $t1,saida #ate o valor da entrada for igual ao contador
   addi $t2, $t2, 2  #adcionando de 2 em 2
   addi $t0, $t0, 1 # contador add de 1 em 1
   j whilepar
   
 saida:
 
   li $v0, 4
   la $a0, fim
   syscall 
   
   li $v0, 1
   move $a0, $t1 # entrada do usu�rio
   syscall 
   
   li $v0, 4
   la $a0, paresp # valores dos enesimo pares positivos
   syscall
    
   move $a0, $t2
   li $v0, 1 #resultado
   syscall
   
   li $v0, 4
   la $a0, newline
   syscall 
    
   li $v0, 4
   la $a0, linhas
   syscall
   
   li $v0, 4
   la $a0, newline
   syscall  
   
   j menu
   
 whileparnegativo:
   beq $t0, $t1,saidan #ate o valor da entrada for igual ao contador
   addi $t2, $t2, -2  #adcionando de -2 em -2
   addi $t0, $t0, -1 # contador add de -1 em -1
   j whileparnegativo 
  
  saidan:
 
   li $v0, 4
   la $a0, fim
   syscall 
   
   mul $t1, $t1, -1 #transgformanda a entrada do usuario em numero positivo pra informa a posi��o na sequencia
   li $v0, 1
   move $a0, $t1 
   syscall 
   
   li $v0, 4
   la $a0, paresn #msg valores do enesimo sendo ele negativo
   syscall
   
    
   move $a0, $t2
   li $v0, 1  #imprimir o resultado
   syscall 
   
   li $v0, 4
   la $a0, newline
   syscall 
    
   li $v0, 4
   la $a0, linhas
   syscall
   
   li $v0, 4
   la $a0, newline
   syscall 
    
  j menu

###################################################################################################
# ESCOLHENDO A OP��O 4, NELA DEVERA FINALIZAR O PROGRAMA! ########################################
###################################################################################################
EQU:

  li $v0, 4
  la $a0, bemv #msg de inicio
  syscall 
  
  li $v0, 4
  la $a0, rA # Raiz A 
  syscall 
  
  li $v0, 5 # pegando o valor de "a"
  syscall 
  
  move $t0, $v0 #movendo valor do registrador
  beqz $t0, incompleta  # caso a= 0 nao existe fun��o de 2 grau
  
  li $v0, 4
  la $a0, rB # Raiz B 
  syscall 
  
  li $v0, 5 # pegando o valor de "b"
  syscall 
  
  move $t1, $v0 #movendo valor do registrador
  
  li $v0, 4
  la $a0, rC # Raiz C
  syscall 
  
  li $v0, 5 # pegando o valor de "c"
  syscall 
  
  move $t2, $v0 #movendo valor do registrador
  
  #os valores de a= $t0, b=$t1, c=$t2 , Lembra de colocar as condi��es de a<0
  
  mul $t3,$t2,$t0  #Primeira parte do calculo axc
  mul $t4, $t3, 4  # 4x(axc)
  mul $t5, $t1,$t1 # b^2
  sub $t6, $t5, $t4 #achamos o DELTA = $t6 , se o Delta<0 , n�o tem raiz real 
  bltz $t6, semraizes #DELTA menor que 0, n tem raiz real
  mtc1 $t6, $f1 # conversao de int pra float
  cvt.s.w $f1, $f1 
  sqrt.s $f1, $f1  # RESOLVENDO A RAIZ DE DELTA
  mul $t1, $t1, -1 # Modificando B = (-B)
  mul $t7, $t0, 2 # 2xa
 
 # $f1 = Raiz de DELTA
 # $f7 = Ax2 pra dividir
 # $f2 = -b
   mtc1 $t1, $f2
   cvt.s.w $f2, $f2
   
    #valor de X1
   mtc1 $t7, $f7 # valor de 2xa
   cvt.s.w $f7, $f7
   add.s $f5, $f1, $f2 #somando o -b com DELTA
   div.s $f8, $f5, $f7 # dividindo com 2xa

   #valor de X2, $f3= -b,  $f10 = 2xa, $f1= raiz de delta
   mtc1 $t1, $f3
   cvt.s.w $f3, $f3
   mtc1 $t7, $f10
   cvt.s.w $f10, $f10
   sub.s $f6, $f3, $f1 #subtraindo o o -b com DELTA
   div.s $f9, $f6, $f10 # dividindo com 2xa
   
  li $v0, 4
  la $a0, resultadoD #msg pra dar o resultado
  syscall 
  
  li $v0, 1
  move $a0, $t6
  syscall 
  
  li $v0, 4
  la $a0,  newline
  syscall 
  
  li $v0, 4
  la $a0, raiz1  #imprimir X1
  syscall 
  
  li $v0, 2
  mov.s $f12, $f8
  syscall 
  
  li $v0, 4
  la $a0,  newline
  syscall 
  
  li $v0, 4
  la $a0, raiz2 #imprimir X2
  syscall 
  
  li $v0, 2
  mov.s $f12, $f9
  syscall
  
  li $v0, 4
  la $a0,  newline
  syscall 
  
  li $v0, 4
  la $a0, linhas
  syscall
  
  li $v0, 4
  la $a0,  newline
  syscall 
  
  li $v0,4
  la $a0, terminoop #Termino as op��es
  syscall 
  
  li $v0, 4
  la $a0,  newline
  syscall 
  j FINALIZADO
  
semraizes:

  li $v0, 4
  la $a0, semraiz # quando o valor do delta � negativo
  syscall 
  
  j FINALIZADO
  
incompleta: 

  li $v0, 4
  la $a0, zero0 #ele informa a=0, sendo que n existe equa��o com a=0 e dado outra chance pro us�ario
  syscall 
  
  li $v0, 4
  la $a0, newline
  syscall 
  
  j EQU
  
FINALIZADO:
  li $v0, 4
  la $a0, linhas
  syscall 
  li $v0, 4
  la $a0, finish #msg do fim
  syscall 
  
 li $v0,10 #code pra fechar
 syscall 
