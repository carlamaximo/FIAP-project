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

# Função para deletar dados pela cultura
deletar_dados <- function(dados) {
  cat("\nVocê escolheu Deletar dados.\n")
  
  cultura_para_deletar <- readline("Informe o nome da cultura que deseja deletar: ")
  
  # Verificar se a cultura existe
  cultura_encontrada <- NULL
  for (i in 1:length(dados)) {
    if (dados[[i]]$cultura == cultura_para_deletar) {
      cultura_encontrada <- dados[[i]]
      indice_cultura <- i
      break
    }
  }
  
  if (is.null(cultura_encontrada)) {
    cat("Cultura não encontrada!\n")
  } else {
    cat("Cultura encontrada. Deletando os dados...\n")
    dados <- dados[-indice_cultura]
    cat("Cultura e seus dados deletados com sucesso!\n")
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
      dados_culturas[[length(dados_culturas) + 1]] <- inserir_dados()
    } else if (opcao == 2) {
      exibir_dados(dados_culturas)
    } else if (opcao == 3) {
      dados_culturas <- atualizar_dados(dados_culturas)
    } else if (opcao == 4) {
      dados_culturas <- deletar_dados(dados_culturas)
    } else if (opcao == 5) {
      calcular_media_desvio_por_cultura(dados_culturas)
    } else if (opcao == 6) {
      cat("Saindo do sistema...\n")
      break
    } else {
      cat("Opção inválida. Tente novamente.\n")
    }
  }
}

# Iniciar o menu principal
menu_principal()
