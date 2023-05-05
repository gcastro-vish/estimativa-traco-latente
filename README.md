# TRI - Estimativa do Traço Latente

Aplicação em shiny para a estimação de traço latente de modelos de TRI com parâmetros dos itens conhecidos.

<!-- TABLE OF CONTENTS -->
## Conteúdos

  * [TRI - Estimativa do Traço Latente](#tri---estimativa-do-traço-latente)
  * [Pré Requisitos](#pré-requisitos)
  * [Preparação do Ambiente](#preparação-do-ambiente)
  * [Execução do aplicativo](#execução-do-aplicativo)
    * [Execução sem o R](#execução-sem-o-r)
  * [Contribuições](#contribuições)


<!-- REQUIREMENTS -->
## Pré Requisitos
  - [Instalação do Git](https://git-scm.com/downloads)>2.40
  - [Instalação do R](https://cran.r-project.org/)>4.2
    1. Uma IDE, como o [RStudio](https://posit.co/download/rstudio-desktop/) ou [VS Code](https://code.visualstudio.com/) facilita a programação em R
  - [Instalação do Python](https://www.python.org/downloads/)>3.10
    1. Assim como em R, o [VS Code](https://code.visualstudio.com/) facilita a programação em Python

<!-- SETTING THE ENVIRONMENT -->
## Preparação do Ambiente

Depois de instalar todos os pré requisitos, iremos fazer as preparações de ambiente necessárias. Escolha uma pasta para instalar este repositório.
  
  1. [Configuração do Git](https://docs.github.com/en/get-started/quickstart/set-up-git#setting-up-git)
  
  2. Com o Git configurado, abra o Git Bash e dê cd na pasta
  
  ```git
  cd pasta
  ```
   
  3. Clone este repositório
  
  ```git
  git clone https://github.com/gcastro-vish/estimativa-traco-latente
  ```
  
  4. Abra o código `app.R` dentro da pasta `estimativa-traco-latente\myapp\` e instale os pacotes necessários

<!-- HOW TO RUN -->
## Execução do Aplicativo

Depois de todas as configurações de ambientes, para executar o aplicativo basta definir o _working directory_ e rodar o comando `runApp()`, do pacote `shiny`. No console em R:

  ```R
  setwd('pasta/estimativa-traco-latente')
  shiny::runApp('myapp/app.R')
  ```
### Execução sem o R

Ainda que não recomendado, é possível executar o aplicativo sem o R ou quaisquer outros pré-requisitos ou configurações aqui descritas, através [deste link](https://gabrielcgr.shinyapps.io/myapp/).

Isso não é recomendado pois o _deploy_ do aplicativo foi feito utilizando uma conta _free_ do _shinyapps_. Isso implica em diversas limitações, como por exemplo, limite de 10 horas de uso por aplicativo. Essas limitações podem fazer com que o aplicativo seja removido da plataforma.

<!-- HOW TO UPDATE -->
## Contribuições

Toda contribuição é bem-vinda! Para sugerir modificações, crie e uma _branch_ com o nome `develop-nome-modificacao` (deve necessariamente começar com _**develop**_) e altere para dentro dela. Faça as as modificações necessárias, lembrando de dar _commit_ com as mensagens de mudança e crie um _pull request_. Mais informações sobre como fazer isso estão disponíveis [aqui](https://docs.github.com/en/get-started/quickstart/contributing-to-projects). Além disso, é possível utilizar o [VS Code como uma interface gráfica para o Git](https://code.visualstudio.com/docs/sourcecontrol/overview).
