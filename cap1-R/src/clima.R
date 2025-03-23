# Carregar pacotes necessários
library(httr)
library(jsonlite)

# Função para obter latitude e longitude de um local
get_lat_lon <- function(local) {
  url <- paste0("https://nominatim.openstreetmap.org/search?q=", URLencode(local), "&format=json&limit=1")
  resposta <- httr::GET(url, config = httr::config(ssl_verifypeer = FALSE))
  
  if (status_code(resposta) == 200) {
    dados <- tryCatch(jsonlite::fromJSON(content(resposta, "text")), error = function(e) NULL)
    
    if (is.null(dados) || length(dados) == 0) {
      print("Nenhum resultado encontrado para o local informado.")
      return(NULL)
    }
    
    lat <- as.numeric(dados$lat[1])
    lon <- as.numeric(dados$lon[1])
    
    # Exibir informações adicionais sobre o local
    print(paste("Local encontrado:", dados$display_name[1]))
    print(paste("Tipo de local:", dados$class[1]))
    print(paste("Latitude:", lat))
    print(paste("Longitude:", lon))
    
    return(c(lat, lon))
  } else {
    print("Erro na solicitação da API Nominatim.")
    return(NULL)
  }
}

# Função para obter previsão do tempo
get_weather <- function(latitude, longitude) {
  url_meteo <- paste0("https://api.open-meteo.com/v1/forecast?latitude=", latitude,
                      "&longitude=", longitude,
                      "&hourly=temperature_2m,precipitation,wind_speed_10m&daily=temperature_2m_max,temperature_2m_min,precipitation_sum,wind_speed_10m_max&language=pt")
  
  resposta_meteo <- httr::GET(url_meteo, config = httr::config(ssl_verifypeer = FALSE))
  
  if (status_code(resposta_meteo) == 200) {
    dados_meteorologicos <- fromJSON(content(resposta_meteo, "text"))
    return(dados_meteorologicos)
  } else {
    print("Erro na solicitação da OpenMeteo.")
    return(NULL)
  }
}

# Função para exibir previsão do tempo para os próximos X dias
show_weather_for_days <- function(dados, dias) {
  cat("### Previsão para os próximos", dias, "dias ###\n")
  for (i in 1:min(dias, length(dados$daily$time))) {
    cat(paste("Data:", dados$daily$time[i], "\n"))
    cat(paste("Temperatura Máxima:", dados$daily$temperature_2m_max[i], "°C\n"))
    cat(paste("Temperatura Mínima:", dados$daily$temperature_2m_min[i], "°C\n"))
    cat(paste("Precipitação:", dados$daily$precipitation_sum[i], "mm\n"))
    cat(paste("Velocidade máxima do vento:", dados$daily$wind_speed_10m_max[i], "km/h\n"))
    cat("\n")
  }
}

# Função para exibir status do tempo atual
show_current_weather <- function(dados) {
  cat("### Status Atual do Tempo ###\n")
  cat(paste("Temperatura:", dados$hourly$temperature_2m[1], "°C\n"))
  cat(paste("Precipitação:", dados$hourly$precipitation[1], "mm\n"))
  cat(paste("Velocidade do Vento:", dados$hourly$wind_speed_10m[1], "km/h\n"))
  cat("\n")
}

# Função para conversão de temperatura (Celsius para Fahrenheit)
convert_temperature <- function(temperatura_celsius) {
  temperatura_fahrenheit <- (temperatura_celsius * 9/5) + 32
  return(temperatura_fahrenheit)
}

# Função para o menu principal
menu_principal <- function() {
  cat("### Menu Principal ###\n")
  cat("1. Buscar previsão do tempo por nome de local\n")
  cat("2. Sair\n")
  opcao <- readline("Escolha uma opção (1/2): ")
  opcao <- as.integer(opcao)  # Garantir que a entrada seja convertida para número
  
  # Verificar se a entrada é válida (não NAs)
  if (is.na(opcao)) {
    print("Opção inválida! Tente novamente.")
    return(NULL)
  }
  
  return(opcao)
}

# Função para o menu de opções de previsão
menu_previsao <- function() {
  cat("### O que você deseja fazer? ###\n")
  cat("1. Visualizar previsão para os próximos X dias\n")
  cat("2. Exibir status atual do tempo\n")
  cat("3. Converter temperatura de Celsius para Fahrenheit\n")
  cat("4. Voltar ao Menu Principal\n")
  opcao <- readline("Escolha uma opção (1/2/3/4): ")
  opcao <- as.integer(opcao)
  
  if (is.na(opcao)) {
    print("Opção inválida! Tente novamente.")
    return(NULL)
  }
  
  return(opcao)
}

# Função para gerenciar a entrada de dados e mostrar a previsão
gerenciar_previsao <- function() {
  while (TRUE) {
    opcao <- menu_principal()
    
    if (is.null(opcao)) next  # Se a opção for inválida, tenta novamente
    
    if (opcao == 1) {  # Buscar previsão por nome de local
      local <- readline("Digite o nome do local: ")
      coordenadas <- get_lat_lon(local)
      
      if (!is.null(coordenadas)) {
        latitude <- coordenadas[1]
        longitude <- coordenadas[2]
        dados_meteorologicos <- get_weather(latitude, longitude)
        
        if (!is.null(dados_meteorologicos)) {
          while (TRUE) {
            opcao_previsao <- menu_previsao()
            
            if (is.null(opcao_previsao)) next  # Se a opção for inválida, tenta novamente
            
            if (opcao_previsao == 1) {
              dias <- as.integer(readline("Quantos dias de previsão você deseja ver? "))
              show_weather_for_days(dados_meteorologicos, dias)
            } else if (opcao_previsao == 2) {
              show_current_weather(dados_meteorologicos)
            } else if (opcao_previsao == 3) {
              temperatura_celsius <- as.numeric(readline("Digite a temperatura em Celsius: "))
              temperatura_fahrenheit <- convert_temperature(temperatura_celsius)
              print(paste("Temperatura em Fahrenheit:", temperatura_fahrenheit, "°F"))
            } else if (opcao_previsao == 4) {
              break  # Voltar ao Menu Principal
            } else {
              print("Opção inválida!")
            }
          }
        }
      }
      
    } else if (opcao == 2) {  # Sair
      print("Saindo...")
      break
      
    } else {
      print("Opção inválida! Tente novamente.")
    }
  }
}

# Executando o gerenciamento da previsão
gerenciar_previsao()
