# Função para inserir dados
inserir_dados <- function() {
  cat("\nVocê escolheu Inserir dados.\n")
  
  cultura_nome <- readline("Informe o nome da cultura: ")
  forma_geometrica <- readline("Forma geométrica (retângulo/quadrado/círculo): ")
  largura <- as.numeric(readline("Digite a largura (m): "))
  comprimento <- as.numeric(readline("Digite o comprimento (m): "))
  area_total <- largura * comprimento
  ruas_lavoura <- as.numeric(readline("Quantas ruas tem a lavoura? "))
  
  # Insumos
  insumos <- list()
  adicionar_insumo <- TRUE
  while (adicionar_insumo) {
    insumo_nome <- readline("Informe o nome do insumo: ")
    unidade_insumo <- readline("Informe a unidade do insumo (ex: litros, kg): ")
    
    # Solicitar múltiplos valores para a quantidade por área
    quantidade_por_area_input <- readline("Quantidade do insumo por unidade de área (kg/m²). Insira múltiplos valores separados por vírgula (ex: 20, 30, 40): ")
    quantidade_por_area <- as.numeric(strsplit(quantidade_por_area_input, ",")[[1]])
    
    # Solicitar múltiplos valores para a quantidade total
    quantidade_total_input <- readline("Quantidade total necessária (kg). Insira múltiplos valores separados por vírgula (ex: 200, 300, 400): ")
    quantidade_total <- as.numeric(strsplit(quantidade_total_input, ",")[[1]])
    
    # Adiciona o insumo
    insumos <- append(insumos, list(list(nome = insumo_nome, unidade = unidade_insumo, 
                                         quantidade_por_area = quantidade_por_area, 
                                         quantidade_total = quantidade_total)))
    
    # Informa sobre a necessidade de mais de um valor para calcular média e desvio
    cat("\n** IMPORTANTE: ** Para calcular a média e o desvio padrão dos insumos, é necessário ter mais de um valor cadastrado para cada insumo.\n")
    
    # Pergunta se deseja adicionar outro insumo
    adicionar_insumo <- readline("Deseja adicionar outro insumo? (S/N): ")
    adicionar_insumo <- toupper(adicionar_insumo) == "S"  # Converte para S ou N
  }
  
  # Verificando se há mais de um valor para os insumos antes de calcular a média e desvio padrão
  if (length(insumos) > 1) {
    quantidades_por_area <- unlist(sapply(insumos, function(x) x$quantidade_por_area))
    quantidades_totais <- unlist(sapply(insumos, function(x) x$quantidade_total))
    
    if (length(quantidades_por_area) > 1) {
      media_por_area <- mean(quantidades_por_area)
      desvio_por_area <- sd(quantidades_por_area)
      cat("Média das Quantidades por Área (kg/m²): ", media_por_area, "\n")
      cat("Desvio Padrão das Quantidades por Área (kg/m²): ", desvio_por_area, "\n")
    } else {
      cat("É necessário mais de um valor para calcular a média e o desvio padrão das Quantidades por Área.\n")
    }
    
    if (length(quantidades_totais) > 1) {
      media_total <- mean(quantidades_totais)
      desvio_total <- sd(quantidades_totais)
      cat("Média das Quantidades Totais (kg): ", media_total, "\n")
      cat("Desvio Padrão das Quantidades Totais (kg): ", desvio_total, "\n")
    } else {
      cat("É necessário mais de um valor para calcular a média e o desvio padrão das Quantidades Totais.\n")
    }
  } else {
    cat("Para calcular a média e desvio padrão, é necessário mais de um insumo cadastrado.\n")
  }
  
  # Retorna os dados inseridos como uma lista
  return(list(cultura = cultura_nome, forma_geometrica = forma_geometrica, 
              area_total = area_total, ruas_lavoura = ruas_lavoura, insumos = insumos))
}

# Função para exibir os dados
exibir_dados <- function(dados) {
  if (length(dados) == 0) {
    cat("Nenhuma cultura cadastrada.\n")
    return()
  }
  
  cat("\n===== Dados das Culturas =====\n")
  for (i in 1:length(dados)) {
    cat("\nCultura: ", dados[[i]]$cultura, "\n")
    cat("Forma Geométrica: ", dados[[i]]$forma_geometrica, "\n")
    cat("Área Total: ", dados[[i]]$area_total, " m²\n")
    cat("Número de Ruas: ", dados[[i]]$ruas_lavoura, "\n")
    
    cat("Insumos:\n")
    for (j in 1:length(dados[[i]]$insumos)) {
      cat("  - Insumo: ", dados[[i]]$insumos[[j]]$nome, 
          ", Unidade: ", dados[[i]]$insumos[[j]]$unidade, 
          ", Quantidade por Área: ", dados[[i]]$insumos[[j]]$quantidade_por_area, 
          ", Quantidade Total: ", dados[[i]]$insumos[[j]]$quantidade_total, "\n")
    }
  }
}

# Função para calcular média e desvio padrão dos insumos por cultura
calcular_media_desvio_por_cultura <- function(dados) {
  if (length(dados) == 0) {
    cat("Nenhuma cultura cadastrada.\n")
    return()
  }
  
  for (i in 1:length(dados)) {
    cat("\nCultura: ", dados[[i]]$cultura, "\n")
    
    # Inicializando listas para armazenar as quantidades dos insumos
    quantidades_por_area <- numeric()
    quantidades_totais <- numeric()
    
    # Iterando sobre os insumos da cultura
    for (j in 1:length(dados[[i]]$insumos)) {
      # Adicionando as quantidades por área e totais para cada insumo
      quantidades_por_area <- c(quantidades_por_area, dados[[i]]$insumos[[j]]$quantidade_por_area)
      quantidades_totais <- c(quantidades_totais, dados[[i]]$insumos[[j]]$quantidade_total)
    }
    
    # Verificando se há mais de um valor para realizar o cálculo
    if (length(quantidades_por_area) > 1) {
      media_por_area <- mean(quantidades_por_area)
      desvio_por_area <- sd(quantidades_por_area)
      cat("Média das Quantidades por Área (kg/m²): ", media_por_area, "\n")
      cat("Desvio Padrão das Quantidades por Área (kg/m²): ", desvio_por_area, "\n")
    } else {
      cat("É necessário mais de um valor para calcular a média e o desvio padrão das Quantidades por Área.\n")
    }
    
    if (length(quantidades_totais) > 1) {
      media_total <- mean(quantidades_totais)
      desvio_total <- sd(quantidades_totais)
      cat("Média das Quantidades Totais (kg): ", media_total, "\n")
      cat("Desvio Padrão das Quantidades Totais (kg): ", desvio_total, "\n")
    } else {
      cat("É necessário mais de um valor para calcular a média e o desvio padrão das Quantidades Totais.\n")
    }
  }
}

# Função para atualizar dados pela cultura
atualizar_dados <- function(dados) {
  cat("\nVocê escolheu Atualizar dados.\n")
  
  cultura_para_atualizar <- readline("Informe o nome da cultura que deseja atualizar: ")
  
  # Verificar se a cultura existe
  cultura_encontrada <- NULL
  for (i in 1:length(dados)) {
    if (dados[[i]]$cultura == cultura_para_atualizar) {
      cultura_encontrada <- dados[[i]]
      indice_cultura <- i
      break
    }
  }
  
  if (is.null(cultura_encontrada)) {
    cat("Cultura não encontrada!\n")
    return(dados)
  }
  
  cat("Cultura encontrada. O que você deseja atualizar?\n")
  cat("[1] - Atualizar dados da cultura\n")
  cat("[2] - Atualizar insumos\n")
  opcao_atualizacao <- as.numeric(readline("Escolha a opção: "))
  
  if (opcao_atualizacao == 1) {
    # Atualizar dados da cultura
    cultura_novo_nome <- readline("Informe o novo nome da cultura: ")
    forma_geometrica_nova <- readline("Forma geométrica (retângulo/quadrado/círculo): ")
    largura_nova <- as.numeric(readline("Digite a nova largura (m): "))
    comprimento_novo <- as.numeric(readline("Digite o novo comprimento (m): "))
    area_total_nova <- largura_nova * comprimento_novo
    ruas_lavoura_novas <- as.numeric(readline("Quantas ruas tem a lavoura? "))
    
    # Atualizar os dados
    dados[[indice_cultura]]$cultura <- cultura_novo_nome
    dados[[indice_cultura]]$forma_geometrica <- forma_geometrica_nova
    dados[[indice_cultura]]$area_total <- area_total_nova
    dados[[indice_cultura]]$ruas_lavoura <- ruas_lavoura_novas
    cat("Dados da cultura atualizados com sucesso!\n")
    
  } else if (opcao_atualizacao == 2) {
    # Atualizar insumos
    cat("Escolha o insumo que deseja atualizar:\n")
    for (j in 1:length(cultura_encontrada$insumos)) {
      cat(j, "- ", cultura_encontrada$insumos[[j]]$nome, "\n")
    }
    insumo_para_atualizar <- as.numeric(readline("Escolha o número do insumo a ser atualizado: "))
    
    # Dados do insumo a ser atualizado
    insumo_nome_novo <- readline("Informe o novo nome do insumo: ")
    unidade_insumo_novo <- readline("Informe a nova unidade do insumo (ex: litros, kg): ")
    
    # Permitir múltiplos valores para a quantidade por área
    quantidade_por_area_nova <- as.numeric(strsplit(readline("Nova quantidade do insumo por unidade de área (kg/m²), insira múltiplos valores separados por vírgula (exemplo: 20, 30, 40): "), ",")[[1]])
    
    # Permitir múltiplos valores para a quantidade total
    quantidade_total_nova <- as.numeric(strsplit(readline("Nova quantidade total necessária (kg/m²), insira múltiplos valores separados por vírgula (exemplo: 200, 300, 400): "), ",")[[1]])
    
    # Atualizar o insumo
    dados[[indice_cultura]]$insumos[[insumo_para_atualizar]]$nome <- insumo_nome_novo
    dados[[indice_cultura]]$insumos[[insumo_para_atualizar]]$unidade <- unidade_insumo_novo
    dados[[indice_cultura]]$insumos[[insumo_para_atualizar]]$quantidade_por_area <- quantidade_por_area_nova
    dados[[indice_cultura]]$insumos[[insumo_para_atualizar]]$quantidade_total <- quantidade_total_nova
    
    cat("Insumo atualizado com sucesso!\n")
  } else {
    cat("Opção inválida. Retornando ao menu.\n")
  }
  
  return(dados)
}

# Função principal do menu
menu_principal <- function() {
  dados_culturas <- list()
  
  repeat {
    cat("\n===== FarmTech Solutions =====\n")
    cat("[1] - Inserir dados\n")
    cat("[2] - Exibir dados\n")
    cat("[3] - Atualizar dados\n")
    cat("[4] - Deletar dados\n")
    cat("[5] - Calcular média e desvio padrão dos insumos por cultura\n")
    cat("[6] - Sair\n")
    
    opcao <- as.numeric(readline("Escolha uma opção: "))
    
    if (opcao == 1) {
      dados_culturas <- append(dados_culturas, list(inserir_dados()))
    } else if (opcao == 2) {
      exibir_dados(dados_culturas)
    } else if (opcao == 3) {
      dados_culturas <- atualizar_dados(dados_culturas)
    } else if (opcao == 4) {
      cat("Deletar dados ainda não implementado.\n")
    } else if (opcao == 5) {
      calcular_media_desvio_por_cultura(dados_culturas)
    } else if (opcao == 6) {
      cat("Saindo... até logo!\n")
      break
    } else {
      cat("Opção inválida. Tente novamente.\n")
    }
  }
}

# Iniciar o menu
menu_principal()
