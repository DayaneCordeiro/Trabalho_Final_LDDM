# Rest Manager 🏝

![Badge](https://img.shields.io/github/forks/DayaneCordeiro/Trabalho_Final_LDDM?style=social)&nbsp;&nbsp;&nbsp;
![Badge](https://img.shields.io/github/stars/DayaneCordeiro/Trabalho_Final_LDDM?style=social)&nbsp;&nbsp;&nbsp;
![Badge](https://img.shields.io/github/license/DayaneCordeiro/Trabalho_Final_LDDM?style=social)<br><br>

![Badge](https://img.shields.io/badge/OS-Android-green)
![Badge](https://img.shields.io/badge/Flutter-2.2-blue)
![Badge](https://img.shields.io/badge/SQLite-3.0-yellowgreen)
![Badge](https://img.shields.io/badge/SharedPreferences-2.0.7-orange)
![Badge](https://img.shields.io/badge/Architecture-MVC-brightgreen)

<h1>🚧 README on improvements, wait for more 🚧</h1>


### Video link:
* https://reccloud.com/pt/u/c2vqbm8

<hr>
<!--  -->

### Descrição da aplicação
* Trabalho desenvolvido na disciplina Laboratório de Desenvolvimento para Dispositivos Móveis.
* Aplicativo mobile utilizando as tecnologias Flutter, SQLite, SharedPreferences e com padrão de arquitetura MVC.

### Objetivo do aplicativo
* Em tempos de pandemia do Covid 19 e do muito falado "novo normal", muitas empresas, escolas e universidades assumiram o regime remoto. O conforto do lar trás alguns benefícios, como comodidade e não precisar passar pelo estresse do trânsito para chegar ao trabalho. Porém ao mesmo tempo que nota-se essas vantagens, pode-se também perceber alguns pontos que precisam de cuidado.
* Sabe-se que a geração atual é a que sofre com os maiores índices registrados na história de casos de depressão. E com o isolamento social é muito importante manter a mente saudável. Pensando nisso, o aplicativo gerenciador de descanso foi desenvolvido. A ideia principal é incluir no dia a dia das pessoas atividades cientificamente comprovadas como benéficas física e psicologicamente.
* O primeiro passo é calcular quanto tempo disponível por dia cada pessoa tem. Para isso foi utilizado o método pomodoro. Nesse método trabalha-se 25 minutos e descansa 5, sendo assim, a cada hora de trabalho, uma pessoa deve ter 10 minutos de descanso para que consiga manter a concentração e produtividade durante sua jornada. Então mesmo que a pessoa não cadastre nenhuma hora de descanso, o aplicativo calcula baseado no tempo de trabalho quantos minutos de descanso a pessoa deve ter.
* Tendo o tempo finalmente calculado, a pessoa escolhe quais atividades quer incluir. As atividades propostas são as seguintes:
    * Ler livros;
    * Fazer exercícios físicos;
    * Meditar;
    * Descansar;
    * Aprender algo novo.
* Após a realização dessas configurações, o usuário terá na tela principal quanto tempo de dedicação deve realizar em cada atividade escolhida. Vale citar que quando o usuário marcar a opção ler livros, invés de aparecer o tempo de dedicação, aparecerá quantas páginas deve ler por dia. O cálculo foi baseado em um estudo que comprova que uma pessoa lê uma média de 1 página de livro a cada 3 minutos. Clicando na atividade, a pessoa pode adicionar os minutos ou páginas que for cumprindo ou lendo e assim, ver a porcentagem do progresso mudando.
* Para zerar o tempo de dedicação no dia seguinte, a pessoa pode clicar no botão disponível ao fim da tela e o progresso reinicia.

### Entradas do usuário
* Quantas horas trabalha por dia;
* Quantas horas de descanso tem por dia;
* Marcar quais atividades quer comprir;

### Saídas do sistema
* Cada um das atividades escolhidas na configuração com seu respectivo tempo de dedicação diário, tempo que falta no dia para que a atividade seja cumprida e porcentagem do progresso.

### Versão do sistema
* v2.4

### Apresentação
* Tela de configurações


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/tela_configura%C3%A7%C3%B5es.PNG)


* Tela principal


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/tela_principal.PNG)


* Tela de Sobre nós


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/tela_about_us.PNG)

### Teste de usabilidade
* Um dos requisitos deste trabalho foi a execução de um teste de usabilidade com usuários do app. Para isso, o apk gerado foi distribuido para oito voluntários e um formulário criado com o Google Forms foi disponibilizado para cada um deles. Todas as respostas foram colhidas de forma sigilosa a fim de obter maior sinceridade dos usuários. Ao fim dos testes os dados foram coletados e serão exibidos abaixo:

#### Pergunta 01
* Essa pergunta teve como objetivo conhecer o perfil do usuário a fim de reconhecer quantos fazem parte do público alvo (pessoas que exercem atividades de forma remota).


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/Anota%C3%A7%C3%A3o%202020-12-13%20005212.png)


#### Pergunta 02
* Essa pergunta teve como objetivo conhecer o perfil do usuário no sentido de comprovar que a maioria das pessoas não tem habilidade em conseguir separar as atividades remotas das atividades pessoais uma vez que tudo acontece no mesmo ambiente.


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/Anota%C3%A7%C3%A3o%202020-12-13%20005249.png)


#### Pergunta 03
* Sobre a facilidade de entender a linguagem utilizada no sistema.


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/Anota%C3%A7%C3%A3o%202020-12-13%20005318.png)


#### Pergunta 04
* Sobre a facilidade de manipulação do aplicativo.


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/Anota%C3%A7%C3%A3o%202020-12-13%20005347.png)


#### Pergunta 05
* Sobre entender o objetivo do produto implementado.


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/Anota%C3%A7%C3%A3o%202020-12-13%20005436.png)


#### Pergunta 06
* A fim de entender a facilidade em termos de usabilidade geral do aplicativo.


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/Anota%C3%A7%C3%A3o%202020-12-13%20005509.png)


#### Pergunta 07
* A fim de entender a utilidade do app criado.


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/Anota%C3%A7%C3%A3o%202020-12-13%20005535.png)


#### Espaço aberto para comentários
* A fim de colher dicas, problemas específicos que não foram encontrados durante os testes e comentários em geral.


![](https://github.com/DayaneCordeiro/Trabalho_Final_LDDM/blob/main/imagens/Anota%C3%A7%C3%A3o%202020-12-13%20005613.png)
