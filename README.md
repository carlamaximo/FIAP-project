# FIAP-project - FarmTech Solutions

O **FarmTech Solutions** é um projeto acadêmico que une **programação, análise estatística e tecnologia agrícola** para simular a gestão de culturas e insumos em propriedades rurais. A solução foi desenvolvida em duas linguagens (Python e R), promovendo uma abordagem prática e analítica para o dia a dia do produtor.

---

## 🎯 Objetivos do Projeto

- Aplicar **programação orientada a boas práticas** para resolver problemas reais da agricultura
- Calcular **área plantada e área útil** com base no formato da lavoura
- Calcular automaticamente a **quantidade total de insumos**
- Permitir **análises estatísticas** dos dados (média e desvio padrão)
- Utilizar uma **API externa** para obter dados climáticos reais
- Simular um ambiente colaborativo com versionamento no GitHub
- Relacionar o projeto com discussões sociais através de artigo acadêmico

---

## 💻 Funcionalidades - Python

✅ Cadastro de até **2 culturas agrícolas**  
✅ Cálculo da **área total, área útil de cultivo e sulcos**  
✅ Suporte a **formas geométricas**: retângulo, quadrado e círculo  
✅ Cadastro de **múltiplos insumos por cultura**  
✅ Cálculo de **quantidade total de insumo** baseada na área útil  
✅ Atualização e exclusão de culturas  
✅ Interface via terminal com **menu interativo**  
✅ Modularização: código separado por responsabilidades (`main`, `calculations`, `data_handler`, `constants`)  
✅ Testes automatizados com `unittest`

---

## 📊 Funcionalidades - R

✅ Cálculo da área total com base na geometria da lavoura  
✅ Consideração do **espaçamento entre linhas/sulcos**  
✅ Cálculo da **área útil de cultivo**, descontando sulcos  
✅ Cálculo de **quantidade total de insumos por cultura**  
✅ Cálculo da **média e desvio padrão** de insumos por área e total  
✅ Interface simples via terminal (menu interativo)

> ⚠️ O desvio padrão é calculado somente quando há **2 ou mais insumos** por cultura.

---
## ☁️ Integração com API de Clima (R)

A aplicação em R também inclui um módulo completo de **consulta meteorológica**, que se conecta a APIs públicas para fornecer dados climáticos em tempo real.

### 🌍 Funcionalidades:

- Consulta por nome de cidade/local
- Uso da API **OpenStreetMap (Nominatim)** para geocodificação (latitude/longitude)
- Consulta à **Open-Meteo** para:
  - Previsão de até X dias
  - Temperatura atual, precipitação, vento
  - Conversão de temperaturas de Celsius para Fahrenheit
- Interface interativa via terminal

> A função principal `gerenciar_previsao()` abre menus interativos para o usuário navegar entre as opções.

---

## 📚 Resumo do Artigo - Dimensão Social

O grupo analisou o artigo:  
**"Uso de veículos aéreos não tripulados(VANT) em Agricultura de Precisão"** da Embrapa.

---

## 🧰 Tecnologias Utilizadas

| Ferramenta  | Aplicação                          |
|-------------|------------------------------------|
| **Python**  | Lógica de cadastro, cálculos e CLI |
| **R**       | Análise estatística + API Clima    |
| Git/GitHub  | Versionamento e colaboração        |
| Terminal    | Interface simples de execução      |
| `unittest`  | Testes automatizados em Python     |

---

## 🚀 Como Executar

### 🔧 Python
```bash
# Requisitos: Python 3+
python main.py
