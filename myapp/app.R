library(shiny)

library(mirt)
library(mirtCAT)

createParams = function(input){
  if(input$model == 'Rasch'){
       a1 = rep(1, 5)
       d = c(input$b1, input$b2, input$b3, input$b4, input$b5)
       params = data.frame('a1' = a1, 'd' = d)
  }
  else if(input$model == '2PL'){
       a1 = c(input$a1, input$a2, input$a3, input$a4, input$a5)
       d = -a1 * c(input$b1, input$b2, input$b3, input$b4, input$b5)
       params = data.frame('a1' = a1, 'd' = d)
  }
  else if(input$model == '3PL'){
       a1 = c(input$a1, input$a2, input$a3, input$a4, input$a5)
       d = -a1 * c(input$b1, input$b2, input$b3, input$b4, input$b5)
       g = c(input$c1, input$c2, input$c3, input$c4, input$c5)
       params = data.frame('a1' = a1, 'd' = d, 'g' = g)
  }
  
  return(params)
}

createPattern = function(input, items = c('Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5')){
  response_pattern = rep(0, 5)
  response_pattern[which(items %in% input$pattern)] = 1
  return(response_pattern)
}

estimate_latent_trace = function(model, params, pattern, method){
  
  mo = generate.mirt_object(parameters = params, itemtype = model)
  
  scores = fscores(mo, response.pattern = pattern, method = method)
  colnames(scores) = c('Estimativa', 'Erro Padrão')
  
  return(scores)
}

# User interface ----
ui <- fluidPage(
  wellPanel(titlePanel("Estimativa do traço latente com parâmetros dos itens conhecidos")
            ),
  hr(),
  fluidRow(
    column(width = 4,
           radioButtons("method", label = h3("Método de Estimação"),
                        choices = list("Máxima verossimilhança" = "ML", "Moda à posteriori" = "MAP", "Esperança à posteriori" = "EAP"), 
                        selected = "ML"),
           h6("As prioris são as default do pacote mirt nos métodos Bayesianos")
    ),
    column(width = 4,
           radioButtons("model", label = h3("Modelo"),
                        choices = list("Rasch" = "Rasch", "Logístico 2 Parâmetros" = "2PL", "Logístico 3 Parâmetros" = "3PL"), 
                        selected = "Rasch"),
    )
  ),
  hr(),
  h3("Parâmetros do modelo"),
  
  conditionalPanel(condition = "input.model == '2PL' | input.model == '3PL'",
       fluidRow(
       column(width = 2, helpText('Discriminação 1'),
              numericInput("a1", "a_1", 1.8)
       ),
       column(width = 2, helpText('Discriminação 2'),
              numericInput("a2", "a_2", 1.8)
       ),
       column(width = 2, helpText('Discriminação 3'),
              numericInput("a3", "a_3", 1.8)
       ),
       column(width = 2, helpText('Discriminação 4'),
              numericInput("a4", "a_4", 1.8)
       ),
       column(width = 2, helpText('Discriminação 5'),
              numericInput("a5", "a_5", 1.8)
       )
       )
  ),
  
  fluidRow(
    column(width = 2, helpText('Dificuldade 1'),
           numericInput("b1", "b_1", -3)
    ),
    column(width = 2, helpText('Dificuldade 2'),
           numericInput("b2", "b_2", -1.5)
    ),
    column(width = 2, helpText('Dificuldade 3'),
           numericInput("b3", "b_3", 0)
    ),
    column(width = 2, helpText('Dificuldade 4'),
           numericInput("b4", "b_4", 1.5)
    ),
    column(width = 2, helpText('Dificuldade 5'),
           numericInput("b5", "b_5", 3)
    )
  ),
  
  conditionalPanel(condition = "input.model == '3PL'",
       fluidRow(
       column(width = 2, helpText('Acerto ao acaso 1'),
              numericInput("c1", "c_1", 0.2)
       ),
       column(width = 2, helpText('Acerto ao acaso 2'),
              numericInput("c2", "c_2", 0.2)
       ),
       column(width = 2, helpText('Acerto ao acaso 3'),
              numericInput("c3", "c_3", 0.2)
       ),
       column(width = 2, helpText('Acerto ao acaso 4'),
              numericInput("c4", "c_4", 0.2)
       ),
       column(width = 2, helpText('Acerto ao acaso 5'),
              numericInput("c5", "c_5", 0.2)
       )
       )
  ),
  hr(),
  h3("Padrão de resposta"),
  fluidRow(
      column(width = 5,
      checkboxGroupInput('pattern', 'Quais itens o aluno(a) acertou?',
                         choices = list('Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5')))
  ),
  hr(),
  h2("Estimativa do traço latente"),
  tableOutput('score')
)

# Server logic ----
server <- function(input, output) {
  par = reactive({createParams(input)})
  
  pat = reactive({createPattern(input)})

  met = reactive({input$method})

  mod = reactive({input$model})
  
  output$score = renderTable({estimate_latent_trace(model = mod(),
                                                   params = par(),
                                                   pattern = pat(),
                                                   method = met())})
  
}

# Run app ----
shinyApp(ui, server)