# Função auxiliar para entrada numérica
input_numeric <- function(prompt) {
  repeat {
    valor <- as.numeric(readline(prompt))
    if (!is.na(valor) && valor > 0) return(valor)
    cat("Entrada inválida. Digite um valor numérico positivo.\n")
  }
}

# Calcula área
calcular_area <- function(forma) {
  if (forma == "retângulo") {
    largura <- input_numeric("Largura (m): ")
    comprimento <- input_numeric("Comprimento (m): ")
    area <- largura * comprimento
  } else if (forma == "quadrado") {
    lado <- input_numeric("Lado (m): ")
    area <- lado ^ 2
  } else if (forma == "círculo") {
    raio <- input_numeric("Raio (m): ")
    area <- pi * (raio ^ 2)
  } else {
    stop("Forma geométrica inválida.")
  }
  return(area)
}

# Função para inserir dados
inserir_dados <- function() {
  cat("\nInserindo dados de nova cultura:\n")
  cultura_nome <- readline("Nome da cultura: ")
  repeat {
    forma_geometrica <- tolower(readline("Forma geométrica (retângulo/quadrado/círculo): "))
    if (forma_geometrica %in% c("retângulo", "quadrado", "círculo")) break
    cat("Forma inválida. Tente novamente.\n")
  }

  area_total <- calcular_area(forma_geometrica)
  espacamento <- input_numeric("Espaçamento entre linhas/sulcos (m): ")
  ruas_lavoura <- as.integer(area_total / espacamento)
  area_sulcos <- ruas_lavoura * espacamento * 0.25
  area_cultivo <- area_total - area_sulcos


  insumos <- list()
  repeat {
    insumo_nome <- readline("Nome do insumo: ")
    unidade_insumo <- readline("Unidade do insumo (litros/kg): ")
    quantidade_por_area <- input_numeric(paste0("Quantidade por área (", unidade_insumo, "/m²): "))

    quantidade_total <- quantidade_por_area * area_cultivo

    insumos <- append(insumos, list(list(
      nome = insumo_nome,
      unidade = unidade_insumo,
      quantidade_por_area = quantidade_por_area,
      quantidade_total = quantidade_total
    )))

    mais_insumos <- toupper(readline("Adicionar outro insumo? (S/N): "))
    if (mais_insumos != "S") break
  }

  return(list(
      cultura = cultura_nome,
      forma_geometrica = forma_geometrica,
      area_total = area_total,
      espacamento = espacamento,
      ruas_lavoura = ruas_lavoura,
      area_cultivo = area_cultivo,
      area_sulcos = area_sulcos,
      insumos = insumos
  ))
}

# Exibição dos dados cadastradoss
exibir_dados <- function(dados) {
  if (length(dados) == 0) {
    cat("Nenhuma cultura cadastrada.\n")
    return()
  }

  for (cultura in dados) {
    cat("\nCultura: ", cultura$cultura,
        "\nForma Geométrica: ", cultura$forma_geometrica,
        "\nÁrea Total: ", cultura$area_total, "m²",
        "\nÁrea de cultivo útil: ", cultura$area_cultivo, "m²",
        "\nÁrea ocupada pelos sulcos: ", cultura$area_sulcos, "m²",
        "\nEspaçamento entre linhas/sulcos: ", cultura$espacamento, "m",
        "\nNúmero de linhas/sulcos: ", cultura$ruas_lavoura,

        "\nInsumos:\n")

    for (insumo in cultura$insumos) {
      cat("- Insumo: ", insumo$nome,
          ", Unidade: ", insumo$unidade,
          ", Quantidade por Área: ", insumo$quantidade_por_area, insumo$unidade, "/m²",
          ", Quantidade Total: ", insumo$quantidade_total, insumo$unidade, "\n")
    }
  }
}

# Calcular média e desvio padrão dos insumos por cultura
calcular_media_desvio <- function(dados) {
  if (length(dados) == 0) {
    cat("Nenhuma cultura cadastrada para cálculo.\n")
    return()
  }

  for (cultura in dados) {
    quantidades_por_area <- sapply(cultura$insumos, function(x) x$quantidade_por_area)
    quantidades_totais <- sapply(cultura$insumos, function(x) x$quantidade_total)

    cat("\nCultura: ", cultura$cultura)
    cat("\nMédia Quantidade por Área: ", mean(quantidades_por_area))
    cat("\nDesvio Padrão Quantidade por Área: ", sd(quantidades_por_area))
    cat("\nMédia Quantidade Total: ", mean(quantidades_totais))
    cat("\nDesvio Padrão Quantidade Total: ", sd(quantidades_totais), "\n")
  }
}

# Menu Principal
menu_principal <- function() {
  dados_culturas <- list()

  repeat {
    cat("\n===== FarmTech Solutions =====\n")
    cat("[1] Inserir dados\n")
    cat("[2] Exibir dados\n")
    cat("[3] Calcular média e desvio padrão\n")
    cat("[4] Sair\n")

    opcao <- readline("Escolha uma opção: ")

    if (opcao == "1") {
      if (length(dados_culturas) >= 2) {
        cat("Limite máximo de 2 culturas alcançado!\n")
      } else {
        nova_cultura <- inserir_dados()
        dados_culturas <- append(dados_culturas, list(nova_cultura))
        cat("Cultura cadastrada com sucesso!\n")
      }
    } else if (opcao == "2") {
      exibir_dados(dados_culturas)
    } else if (opcao == "3") {
      calcular_media_desvio(dados_culturas)
    } else if (opcao == "4") {
      cat("Encerrando aplicação... Até logo!\n")
      break
    } else {
      cat("Opção inválida. Tente novamente.\n")
    }
  }
}

# Iniciar o menu
menu_principal()