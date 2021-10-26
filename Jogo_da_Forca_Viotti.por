programa
{
	inclua biblioteca Calendario-->c
	inclua biblioteca Sons-->s
	inclua biblioteca Texto-->txt
	inclua biblioteca Arquivos--> arq
	inclua biblioteca Util --> u
	
	funcao inicio()
	{ 
		//Variáveis usadas para achar as palavras e dicas dos arquivos e também a escolha do usuário
		inteiro escolha_dica,arquivo
		//Variáveis de sons
		inteiro musica_abertura=s.carregar_som("abertura_jequiti.mp3")
		inteiro musica_escolha=s.carregar_som("grilo.mp3")
		inteiro musica_comeco=s.carregar_som("comecou.mp3")
		inteiro musica_regra=s.carregar_som("regra.mp3")
		menu()
		s.reproduzir_som(musica_abertura, verdadeiro)
		leia(escolha_dica)
		se(escolha_dica < 1 ou escolha_dica > 8){ //Lógica usada para o usuário caso digite uma opção inválida
			limpa()
			s.reproduzir_som(musica_escolha, falso)
			s.interromper_som(musica_abertura)
			escreva("escolha uma das dicas pré-indicadas!")
			u.aguarde(3000)
			limpa()
			s.interromper_som(musica_escolha)
			inicio()
		}senao{
			limpa()
			s.interromper_som(musica_abertura)
			s.reproduzir_som(musica_regra, verdadeiro)
			regras()// Chama a função regras
			s.interromper_som(musica_regra)
			contador_sorteio()// Chama a função contador_sorteio
			s.reproduzir_som(musica_comeco, falso)
		escolha(escolha_dica){ // Uso do escolha para abrir o arquivo da respectiva escolha do usuário (Caso mude o nome do arquivo, aqui será o local da mudança)
			caso 1:
				arquivo=arq.abrir_arquivo("cidades_forca.txt",arq.MODO_LEITURA)
				logica_jogo(arquivo)//Chama a função lógica_jogo (em todos os casos)
				pare
			caso 2:
				arquivo=arq.abrir_arquivo("frutas_forca.txt",arq.MODO_LEITURA)
				logica_jogo(arquivo)
				pare
			caso 3:
				arquivo=arq.abrir_arquivo("times_forca.txt",arq.MODO_LEITURA)
				logica_jogo(arquivo)
				pare
			caso 4:
				arquivo=arq.abrir_arquivo("paises_forca.txt",arq.MODO_LEITURA)
				logica_jogo(arquivo)
				pare
			caso 5:
				arquivo=arq.abrir_arquivo("animais_forca.txt",arq.MODO_LEITURA)
				logica_jogo(arquivo)
				pare
			caso 6:
				arquivo=arq.abrir_arquivo("personagens_forca.txt",arq.MODO_LEITURA)
				logica_jogo(arquivo)
				pare
			caso 7:
				arquivo=arq.abrir_arquivo("celebridades_forca.txt",arq.MODO_LEITURA)
				logica_jogo(arquivo)
				pare
			caso 8:
				arquivo=arq.abrir_arquivo("profissoes_forca.txt",arq.MODO_LEITURA)
				logica_jogo(arquivo)
				pare	
					
			}
		}
	}

	funcao logica_jogo(inteiro arquivo){	//Função responsável por controlar as ações do jogo		
		inteiro tempo=u.tempo_decorrido() //Variável responsável por armazenar o tempo
		cadeia matriz_jogo [100] [11] //Variável principal do jogo, onde armazenará as palavras e as dicas do jogo (até 100 palavras e até 10 dicas)
		cadeia ler_linha,palavra,letras_digitadas_errada=" ",letras_digitadas_certa=" " 
		inteiro tamanho, sorteio,l,c,dicas
		inteiro acertos
		inteiro erros,posicao
		logico acertou,repeticao
		caracter formacao_palavra_secreta[100],letras[100],tamanho_palavra,letra
		inteiro musica_comeco=s.carregar_som("comecou.mp3")
		inteiro musica_acerto=s.carregar_som("mizeravi.mp3"),musica_dica=s.carregar_som("dica.mp3"),musica_repete=s.carregar_som("repete.mp3")
		inteiro musica_erro=s.carregar_som("jacquin.mp3")
		inteiro musica_acabou=s.carregar_som("champions.mp3")
		inteiro musica_perdeu=s.carregar_som("perdeu.mp3") //Todas essas variáveis estão presentes dentro do jogo em si
		

		l=0 //Contador de linhas começa em 0
		c=0 //Contador de colunas começa em 0
		dicas=1//Começa em 1, já que a posição 0 está reservado para as palavras
		ler_linha=arq.ler_linha(arquivo) //Lerá cada linha do arquivo (De acordo com a opção escolhida pelo usuário)

		faca{
			se(txt.obter_caracter(ler_linha, 0)== 'P'){ //Se a linha começar com "P:", ela será uma palavra e irá ser colocada na primeira posição de cada linha da matriz
				tamanho = txt.numero_caracteres(ler_linha)
				matriz_jogo[l][c] = txt.extrair_subtexto(ler_linha, 2, tamanho) //Será tirado o P:, pois ela não será uma letra a ser desvendada
				c++
				ler_linha = arq.ler_linha(arquivo)
			enquanto(txt.obter_caracter(ler_linha, 0)!= 'P'){ //Se a linha não começar com "P:", significa que ela é uma dica e será colocada em sequência de cada palavra
				tamanho = txt.numero_caracteres(ler_linha)
				matriz_jogo[l][c] = txt.extrair_subtexto(ler_linha, 2, tamanho) //Será tirado o D:
				ler_linha = arq.ler_linha(arquivo)
				c++	
			se(txt.numero_caracteres(ler_linha)==0){ //Ao acabar de ler as dicas de uma determinada palavra, o contador pulará uma linha e executará o laço novamente
				pare
				}		
				}
				l++ //Pulará para a próxima linha da matriz, já que o programa leu todas as dicas e começará uma outra palavra, repetindo o laço
				c = 0 //A coluna setará em 0 novamente, porque as palavras ficam na posição 0 da matriz
		    }
			

	         }enquanto(nao arq.fim_arquivo(arquivo)) //Se o EOF for verdadeiro, ele fechará o arquivo em sequência
				arq.fechar_arquivo(arquivo) //Fechará o arquivo em questão
				sorteio=u.sorteia(0, l-1) //Sorteio de uma palavra
				palavra=matriz_jogo[sorteio] [0] //Sorteio de uma dica
				tamanho=txt.numero_caracteres(palavra) //Variável que armazena o tamanho da palavra sorteada
		 		acertos=tamanho //A variável acertos será igual o tamanho, que é o total de caracteres da palavra
		 		erros=6 //Erros iniciará em 6 pois é o total de membros que tem na forca
		 	
		    para( posicao=0;posicao<tamanho;posicao++){//Laço responsável por extrair cada caractere da palavra sorteada
				tamanho_palavra=txt.obter_caracter(palavra, posicao)
				letras[posicao]=tamanho_palavra //O vetor letras receberá os caracteres (de acordo com a posição de cada letra) da palavra sorteada
				se(letras[posicao]== ' '){ // Se a palavra for composta, o jogo irá separar a palavra
					acertos=tamanho-1 
					formacao_palavra_secreta[posicao]= ' ' // Irá ser colocado um espaço entre as palavras
				}senao{
		 			formacao_palavra_secreta[posicao]= '_'	//Será colocado, de acordo com cada posição do caractere, um traço indicando a posição de dada letra
			     }		
		 			
		 	}
		 	
		    enquanto(acertos>0 e erros>0){ // Laço principal do jogo, onde será repetido enquanto o total de acertos e erros for maior que 0
		 		se(u.tempo_decorrido()> tempo+300000){ //Tempo estipulado para o jogo, o qual se passar disso o jogador perde
					limpa()
					desenho_tempo () //Chama a função desenho_tempo
					pare
		 		}senao{
		 			boneco(erros) //Chama a função bonecos
		 			escreva("\n")
		 			escreva(" Letras erradas --> ", letras_digitadas_errada,"\n") //Letras erradas
		 			escreva(" Letras certas  --> ", letras_digitadas_certa,"\n") //Letras certas
		 			escreva(" \n Dica --> ", matriz_jogo[sorteio][dicas],"\n") //Dicas
		 			escreva(" \n Suas chances:" , erros, "\n Digite uma letra: ") //Número de chances que o jogador ainda tem
	
		 	 para( posicao=0;posicao<tamanho;posicao++){
		 		  escreva(formacao_palavra_secreta[posicao]," ")
		 		}
		 	 escreva("\n")
		 	 escreva(" Digite aqui a letra --> ")
		 	 leia(letra)
		 	 acertou=falso // acertou e repetição começa como falso
			 repeticao=falso
		 	 para( posicao=0;posicao<tamanho;posicao++){
		 		se(letra==letras[posicao]){ //Verifica se a letra digitada é igual a letra de uma determinada posição da palavra
		 			se(formacao_palavra_secreta[posicao]==letra){ //Verifica se a letra da palavra já foi digitada
		 				repeticao=verdadeiro
		 		     }senao{
		 				acertou=verdadeiro
		 				formacao_palavra_secreta[posicao]=letra // Se a pessoa acertou a letra, o tracinho será substituído pela letra digitada corretamente
		 				acertos--
		 		      }		
		 	      }
		      }
		 	  se(repeticao==verdadeiro){ //Se repetição for verdadeiro, será tocado um som que remete a uma repetição da letra já digitada na palavra
		 			s.reproduzir_som(musica_repete, falso)
		 			acertos++
		 			limpa()
		 		}senao
		 	  se(acertou==verdadeiro){ //Se acertou é verdadeiro, significa que a pessoa acertou uma letra e será tocado um som
		 	  		s.interromper_som(musica_erro)
		 			s.reproduzir_som(musica_acerto, falso)
		 			letras_digitadas_certa=letra+letras_digitadas_certa
		 			limpa()
		 		}senao
		 	  se(letra=='D'){ //Caso a pessoa digite D, será sorteado outra dica
		 			s.reproduzir_som(musica_dica, falso)
		 			dicas++
		 			erros-- //Decrementa a quantidade de erros, onde começa em 6
		 			limpa()
		 			
		 		}senao{ //Se ela não repetiu a letra, não digitou D ou não acertou a letra, quer dizer que a pessoa errou a letra
		 			s.interromper_som(musica_acerto)
		 			s.reproduzir_som(musica_erro, falso)
		 			erros-- //Decrementa a quantidade de erros, onde começa em 6
		 			letras_digitadas_errada=letra+letras_digitadas_errada
		 			limpa()
		 		}
		 	     }
		 	
		 	  se(acertos==0){ // Se o número de acertos for igual a 0 (número total de caracteres da palavra), o jogador acertou a palavra completa
		 			s.interromper_som(musica_acerto)
		 			s.reproduzir_som(musica_acabou, verdadeiro)
		 			limpa()
		 			desenho_ganhou() //Chama a função desenho_ganhou
		 			escreva("\n Parabéns!!!, você descobriu a palavra: ") 
		 	  para( posicao=0;posicao<tamanho;posicao++){
		 			escreva(formacao_palavra_secreta[posicao]) //Será disvendada a palavra
		 		
		 	  }
		 	  erros_final(erros) //Chama a função erros_final
		 	  escreva("\n")
		 	  fim_jogo() //Chama a função fim_jogo
		 	  }
		 	}
		 	  se (erros==0){ //Se o número de erros for igual a 0, quer dizer que o jogador perdeu e não descobriu a palavra
		 		     s.interromper_som(musica_erro)
		 		     s.interromper_som(musica_dica)
		 		     s.reproduzir_som(musica_perdeu, verdadeiro)
		 		     limpa()
		 		     desenho_perdeu() //Chama a função desenho_perdeu
		 		     boneco(erros=0)
		 		     escreva("\n \t \t \t GAME OVER")
		 		     escreva("\n Que pena, você não acertou a palavra :(. A palavra era: ")
		 	  para( posicao=0;posicao<tamanho;posicao++){
		 		     escreva(letras[posicao]) //Será disvendada a palavra
		 		
		 	  }	
		 	  erros_final(erros) //Chama a função erros_final
		 	  fim_jogo() //Chama a função fim_jogo
		
	            }
		 	
	            retorne
	}
   funcao menu(){ // Função que trará o nome dos desenvolvedores do programa, o nome do jogo e o menu de escolha para o jogador
	   escreva(" \n ======================================================= ")
	   escreva ("\n ========= Gabriel Simonato e Emílio Brandão =========")
	   escreva( "\n ========= RA:1680482111018 RA:1680482111038 ========")
	   escreva("\n  ======================================================= ")
	   escreva( "\n ============= J O G O  D A  F O R C A =============== ") 
	   escreva(" \n ======================================================= ")
	   escreva("\n JOGO [X]")
        escreva("\n DICAS [X]")
        escreva("\n CONTROLE DE TEMPO [X]")
	   escreva("\n \t \t \t  +---+")
        escreva("\n \t \t \t  |   |")
   	   escreva("\n \t \t \t  0   |")
  	   escreva("\n \t \t \t /|\\  |")
        escreva("\n \t \t \t / \\  |")
   	   escreva("\n \t \t \t      | ")
  	   escreva("\n \t \t \t ========= \n")
  	   escreva("\n")
  	   boas_vindas()
  	   escreva("\n ################# MENU DE ESCOLHA ###################")
  	   escreva("\n #                                                   #")
	   escreva("\n #  escolha alguma dica para jogar o jogo da forca:  #")
	   escreva("\n #                  1- Cidades                       #")
	   escreva("\n #                  2- Frutas                        #")
	   escreva("\n #                  3- Times de futebol              #")
	   escreva("\n #                  4- Países                        #")
	   escreva("\n #                  5- Animais                       #")
	   escreva("\n #                  6- Personagens(em geral)         #")
	   escreva("\n #                  7- Celebridades                  #")
	   escreva("\n #                  8- Profissões                    #")
	   escreva("\n #####################################################")
	   escreva("\n Escolha do jogador: ")
	}
	
	funcao boneco(inteiro erros){ //Função que desenhará a forca de acordo com o número de erros do jogador
          escolha (erros){
          caso 6:
	          escreva("\n +---+")
	          escreva("\n |   |")
	          escreva("\n     |")
	          escreva("\n     |")
	          escreva("\n     |")
	          escreva("\n     |")
	          escreva("\n =========")
               pare
          caso 5:
	          escreva("\n +---+")
	          escreva("\n |   |")
	          escreva("\n 0   |")
	          escreva("\n     |")
	          escreva("\n     |")
	          escreva("\n     |")
	          escreva("\n =========")
               pare
   	     caso 4:
	          escreva("\n +---+")
	          escreva("\n |   |")
	          escreva("\n 0   |")
	          escreva("\n |   |")
	          escreva("\n     |")
	          escreva("\n     |")
	          escreva("\n =========")
              pare
          caso 3:
	          escreva("\n  +---+")
	          escreva("\n  |   |")
	          escreva("\n  0   |")
	          escreva("\n /|   |")
	          escreva("\n      |")
	          escreva("\n      |")
	          escreva("\n =========")
               pare
          caso 2:
	          escreva("\n  +---+")
	          escreva("\n  |   |")
	          escreva("\n  0   |")
	          escreva("\n /|\\  |")
	          escreva("\n      |")
	          escreva("\n      |")
	          escreva("\n =========")
               pare
          caso 1:
	          escreva("\n  +---+")
	          escreva("\n  |   |")
	          escreva("\n  0   |")
	          escreva("\n /|\\  |")
	          escreva("\n /    |")
	          escreva("\n      |")
	          escreva("\n =========")
               pare
          caso 0:
	          escreva("\n \t \t \t  +---+")
	          escreva("\n \t \t \t  |   |")
	          escreva("\n \t \t \t  0   |")
	          escreva("\n \t \t \t /|\\  |")
	          escreva("\n \t \t \t / \\  |")
	          escreva("\n \t \t \t      |")
	          escreva("\n \t \t \t =========")
               pare

    }
    }
    funcao regras(){ // Função que trará algumas instruções pro jogador
   	    caracter resposta
   	    escreva("\n ######################### INSTRUÇÕES DO JOGO ##########################")
  	    escreva("\n #                                                                     #")
	    escreva("\n #  1)TEMPO MÁXIMO PARA JOGAR:5 MINUTOS;                               #")
	    escreva("\n #                                                                     #")
	    escreva("\n #  2)VOCÊ POSSUI 6 CHANCES;                                           #")
	    escreva("\n #                                                                     #")
	    escreva("\n #  3)O BONECO INDICA QUANTOS ERROS VOCÊ TEM TAMBÉM;                   #")
	    escreva("\n #                                                                     #")
	    escreva("\n #  4)PARA PEDIR UMA NOVA DICA, CLIQUE 'D';                            #")
	    escreva("\n #                                                                     #")
	    escreva("\n #  5)LEMBRE-SE: QUANDO PEDIR DICA, SERÁ CONTABILIZADO COMO ERRO;      #")
	    escreva("\n #                                                                     #")
	    escreva("\n #  6)NÃO SE PREOCUPE EM COLOCAR LETRAS MAIÚSCULAS.                    #")
	    escreva("\n #                                                                     #")
	    escreva("\n #             BOA SORTE NO JOGO, VOCÊ VAI PRECISAR...                 #")
	    escreva("\n #######################################################################")
	    escreva("\n")
   	    u.aguarde(3000)
   	    escreva (" Clique QUALQUER TECLA para prosseguir: ")
   	    leia(resposta)
   	    limpa()

    }
   funcao contador_sorteio(){ // Função responsável por carregar o jogo antes de começar
   	   inteiro contador = 10,som_sorteio=s.carregar_som("som_palavra_sorteio.mp3")
	   s.reproduzir_som(som_sorteio, falso)
	   enquanto (contador > 0){
		     limpa()
		     escreva ("Aguarde, sua palavra está sendo sorteada: ", contador)
		     escreva("\n")
		     contador = contador - 1
		     u.aguarde(250)
		     escreva("carr")
	          u.aguarde(250)
		     escreva("ega")
		     u.aguarde(250)
		     escreva("ndo...")
		     u.aguarde(250)
			
	   }

	   limpa()
    }
   funcao erros_final(inteiro erros){ // Essa função trará uma mensagem de acordo com o número de erros do jogador
   	   se(erros==6){
   		   escreva("\n parabéns, você não errou nenhuma letra!")
   	   }
   	   senao se(erros==5){
   		   escreva("\n Você errou 1 letra, mas jogou muito bem!")
   	   }
   	   senao se(erros==4){
   		   escreva("\n Continue jogando e tente não errar nenhuma letra da próxima vez, mesmo tendo errado 2 letras!")
   	   }
   	   senao se(erros==3){
   		   escreva("\n Jogou razoavelmente bem, mas precisa melhorar muito!")
   	   }
   	   senao se(erros==2){
   		   escreva("\n vish o negócio tá feio, errou 4 letras")
   	   }
   	   senao se(erros==1){
   		   escreva("\n Ganhou na bacia das almas!!!")
   	   }
   	   senao{
   		   escreva("\n Vish, não conseguiu adivinhar a palavra :(")
   		
   	   }
     }
  funcao boas_vindas() // Função que ficará visível logo no começo que irá escrever as boas vindas de acordo com o horário atual
    { 
		inteiro hora = c.hora_atual(falso) //24 horas

		se(hora < 12) 
		{
			escreva(" \t \t        Bom Dia!!! \n")
		}
		senao se(hora < 18)
		{
			escreva(" \t \t        Boa Tarde!!! \n")
		}
		senao
			escreva(" \t \t        Boa Noite!!! \n")
    }
   funcao fim_jogo(){ // Função que terá como finalidade se o usuário quer jogar novamente ou não
	   caracter resposta_final
	   inteiro musica_acabou=s.carregar_som("champions.mp3")
	   inteiro musica_perdeu=s.carregar_som("perdeu.mp3")
	   inteiro musica_proximo_game=s.carregar_som("ate_proximo_game.mp3")
	   escreva("\n Deseja jogar de novo? se sim, digite S, senão, N: ")
	   leia (resposta_final)
	   se(resposta_final=='S' ou resposta_final=='s'){
		   s.interromper_som(musica_acabou)
		   s.interromper_som(musica_perdeu)
		   limpa()
		   inicio()
	  }senao se(resposta_final!='S' ou resposta_final!='s'){
	  	   s.interromper_som(musica_acabou)
	  	   s.interromper_som(musica_perdeu)
	  	   s.reproduzir_som(musica_proximo_game, falso)
	  	   u.aguarde(5000)
		   retorne
	  }	
    }	
    funcao desenho_perdeu(){ // Desenho de uma baleia que irá aparecer quando o jogador perder o jogo por errar as letras
		escreva("\n \t \t ▄██████████████▄▐█▄▄▄▄█▌")
		escreva("\n \t \t ██████▌▄▌▄▐▐▌███▌▀▀██▀▀ ")
		escreva("\n \t \t ████▄█▌▄▌▄▐▐▌▀███▄▄█▌   ")
		escreva("\n \t \t ▄▄▄▄▄██████████████▀    ")
    }
    funcao desenho_tempo (){ // Desenho de um relógio que irá aparecer quando o jogador perder o jogo por tempo
		escreva("\n__________________________________________________")
		escreva("\n_______¶¶¶¶¶___________________________¶¶¶¶_______")
		escreva("\n______¶¶___¶¶¶¶¶¶¶______________¶¶¶¶¶¶¶¶__¶¶______")
		escreva("\n______¶¶¶________¶¶¶__________¶¶¶¶______¶__¶______")
		escreva("\n_____¶¶____________¶¶________¶¶___________¶¶¶_____")
		escreva("\n____¶¶____________¶¶¶_______¶¶¶_____________¶¶____")
		escreva("\n___¶¶_________¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶__________¶¶____")
		escreva("\n___¶¶______¶¶_¶¶¶¶_____________¶¶¶¶¶_________¶____")
		escreva("\n___¶¶__¶¶¶¶¶________________________¶¶¶____¶¶_____")
		escreva("\n____¶¶¶¶¶¶¶¶_____¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶____¶¶¶¶¶¶¶_____")
		escreva("\n_______¶¶¶____¶¶¶_______¶¶_______¶¶¶____¶¶¶¶¶_____")
		escreva("\n______¶¶____¶¶___¶______¶¶______¶__¶¶¶____¶¶______")
		escreva("\n_____¶¶___¶¶_____¶¶____________¶¶____¶¶¶___¶¶_____")
		escreva("\n____¶¶___¶_____________________________¶¶___¶¶____")
		escreva("\n___¶¶___¶__¶____________¶¶___________¶__¶¶___¶¶___")
		escreva("\n__¶¶___¶____¶___________¶¶__________¶____¶¶___¶___")
		escreva("\n__¶¶__¶¶________________¶¶________________¶___¶¶__")
		escreva("\n__¶___¶_________________¶¶_________________¶__¶¶__")
		escreva("\n¶¶___¶_________________¶¶_________________¶___¶___  VOCÊ ESTRAPOLOU NO TEMPO!!!")
		escreva("\n_¶¶___¶_¶¶¶¶¶___________¶¶¶¶¶¶_______¶¶¶¶¶_¶___¶¶_")
		escreva("\n_¶¶___¶____________________________________¶___¶__")
		escreva("\n__¶___¶____________________________________¶___¶__")
		escreva("\n__¶¶__¶¶__________________________________¶___¶¶__")
		escreva("\n__¶¶___¶____¶_______________________¶_____¶___¶¶__")
		escreva("\n___¶¶___¶__¶_________________________¶___¶___¶¶___")
		escreva("\n____¶____¶______________________________¶___¶¶____")
		escreva("\n____¶¶____¶______¶______¶¶______¶_____¶¶___¶¶_____")
		escreva("\n_____¶¶¶___¶¶___¶_______¶¶_______¶__¶¶¶___¶¶______")
		escreva("\n_______¶¶___¶¶¶_________¶¶________¶¶¶____¶¶_______")
		escreva("\n________¶¶¶___¶¶¶¶¶¶__________¶¶¶¶¶___¶¶¶_________")
		escreva("\n_______¶¶¶__¶¶_____¶¶¶¶¶¶¶¶¶¶¶¶_____¶¶_¶¶_________")
		escreva("\n______¶¶_______¶¶________________¶¶_____¶¶________")
		escreva("\n______¶¶_______¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶________¶________")
		escreva("\n______¶¶¶______¶¶_______________¶¶______¶¶________")
		escreva("\n________¶¶¶¶¶¶¶¶_________________¶¶¶¶¶¶¶¶_________")
		escreva("\n__________________________________________________")
		     	
     }
     funcao desenho_ganhou(){ // Desenho de um troféu que irá aparecer quando o jogador acertar a palavra e ganhar
		escreva("\n█████████─████████████████████─█████████")
		escreva("\n█████████─████████████████████─█████████")
		escreva("\n███───────████████────████████───────███")
		escreva("\n███───────██████───██───██████───────███")
		escreva("\n─███──────█████──████────█████──────███─")
		escreva("\n──███─────████─────██─────████─────███──")
		escreva("\n───███────████─────██─────████────███───")
		escreva("\n────███───█████────██────█████───███────")
		escreva("\n─────███──█████────██────█████──███─────")
		escreva("\n──────███─███████──────███████─███──────")
		escreva("\n───────██─████████████████████─██───────")
		escreva("\n────────█─████████████████████─█────────")
		escreva("\n────────────────────────────────────────")
		escreva("\n──────────████████████████████──────────")
		escreva("\n───────────██████████████████───────────")
		escreva("\n─────────────██████████████─────────────")
		escreva("\n───────────────███████████──────────────")
		escreva("\n────────────────────────────────────────")
		escreva("\n────────────────█████████───────────────")
		escreva("\n──────────────█████████████─────────────")
     }
}
			
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1398; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */