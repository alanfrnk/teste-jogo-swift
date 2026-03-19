# Documento de Requisitos

## Introdução

Este documento descreve os requisitos para um jogo da velha (Tic-Tac-Toe) desenvolvido em Swift com SwiftUI. O jogo é para um único jogador que compete contra a máquina (IA). O sistema inclui rastreamento de pontuação (vitórias, derrotas e empates), uma tela inicial com opções de jogar e zerar o placar, e animações de resultado ao final de cada partida.

## Glossário

- **App**: A aplicação do jogo da velha construída em SwiftUI
- **Tabuleiro**: A grade 3x3 onde o jogador e a IA fazem suas jogadas
- **Jogador**: O usuário humano que interage com o jogo, representado pelo símbolo "X"
- **IA**: O oponente controlado pela máquina, representado pelo símbolo "O"
- **Célula**: Uma posição individual dentro do Tabuleiro (total de 9 células)
- **Placar**: O registro persistente de vitórias, derrotas e empates do Jogador
- **Tela_Inicial**: A tela apresentada ao abrir a App, contendo os botões de ação e o Placar
- **Tela_Jogo**: A tela onde a partida acontece, exibindo o Tabuleiro
- **Animação_Resultado**: A animação exibida ao final de cada partida indicando o resultado

## Requisitos

### Requisito 1: Tela Inicial

**User Story:** Como Jogador, eu quero ver uma tela inicial ao abrir o aplicativo, para que eu possa escolher jogar ou zerar o placar.

#### Critérios de Aceitação

1. WHEN a App é iniciada, THE Tela_Inicial SHALL exibir um botão "Jogar" e um botão "Zerar Placar"
2. WHEN a App é iniciada, THE Tela_Inicial SHALL exibir o Placar atual do Jogador (vitórias, derrotas e empates)
3. WHEN o Jogador pressiona o botão "Jogar", THE App SHALL navegar para a Tela_Jogo com o Tabuleiro vazio
4. WHEN o Jogador pressiona o botão "Zerar Placar", THE App SHALL redefinir o Placar para zero vitórias, zero derrotas e zero empates

### Requisito 2: Tabuleiro do Jogo

**User Story:** Como Jogador, eu quero ver um tabuleiro 3x3 claro e interativo, para que eu possa fazer minhas jogadas.

#### Critérios de Aceitação

1. THE Tela_Jogo SHALL exibir o Tabuleiro como uma grade 3x3 com 9 Células interativas
2. THE Tela_Jogo SHALL exibir o Placar atual (vitórias, derrotas e empates) durante a partida
3. WHEN uma Célula está ocupada, THE Tela_Jogo SHALL exibir o símbolo correspondente ("X" para o Jogador, "O" para a IA) na Célula

### Requisito 3: Jogada do Jogador

**User Story:** Como Jogador, eu quero tocar em uma célula vazia para fazer minha jogada, para que eu possa competir contra a IA.

#### Critérios de Aceitação

1. WHEN o Jogador toca em uma Célula vazia durante o turno do Jogador, THE App SHALL marcar a Célula com o símbolo "X"
2. WHEN o Jogador toca em uma Célula já ocupada, THE App SHALL ignorar o toque e manter o estado atual do Tabuleiro
3. WHILE a IA está processando sua jogada, THE App SHALL ignorar toques do Jogador no Tabuleiro

### Requisito 4: Jogada da IA

**User Story:** Como Jogador, eu quero que a máquina faça sua jogada automaticamente após a minha, para que o jogo flua de forma contínua.

#### Critérios de Aceitação

1. WHEN o Jogador completa sua jogada e o jogo não terminou, THE IA SHALL selecionar uma Célula vazia e marcá-la com o símbolo "O"
2. THE IA SHALL escolher sua jogada utilizando uma estratégia que priorize: (a) vencer, (b) bloquear a vitória do Jogador, (c) ocupar uma posição estratégica disponível
3. WHEN a IA completa sua jogada, THE App SHALL passar o turno para o Jogador

### Requisito 5: Detecção de Vitória

**User Story:** Como Jogador, eu quero que o jogo detecte automaticamente quando alguém venceu, para que o resultado seja claro.

#### Critérios de Aceitação

1. WHEN um participante (Jogador ou IA) completa uma linha, coluna ou diagonal com três símbolos iguais, THE App SHALL declarar esse participante como vencedor e encerrar a partida
2. WHEN todas as 9 Células estão ocupadas e nenhum participante completou uma linha, coluna ou diagonal, THE App SHALL declarar a partida como empate

### Requisito 6: Animação de Resultado

**User Story:** Como Jogador, eu quero ver uma animação ao final da partida indicando o resultado, para que a experiência seja mais envolvente.

#### Critérios de Aceitação

1. WHEN o Jogador vence a partida, THE Animação_Resultado SHALL exibir o texto "You Win" com uma animação visível
2. WHEN a IA vence a partida, THE Animação_Resultado SHALL exibir o texto "You Lose" com uma animação visível
3. WHEN a partida termina em empate, THE Animação_Resultado SHALL exibir o texto "Draw" com uma animação visível
4. WHEN a Animação_Resultado é exibida, THE App SHALL fornecer uma opção para o Jogador retornar à Tela_Inicial

### Requisito 7: Rastreamento de Placar

**User Story:** Como Jogador, eu quero que minhas vitórias, derrotas e empates sejam contabilizados, para que eu possa acompanhar meu desempenho.

#### Critérios de Aceitação

1. WHEN o Jogador vence uma partida, THE App SHALL incrementar o contador de vitórias do Placar em 1
2. WHEN a IA vence uma partida, THE App SHALL incrementar o contador de derrotas do Placar em 1
3. WHEN a partida termina em empate, THE App SHALL incrementar o contador de empates do Placar em 1
4. THE App SHALL persistir o Placar entre sessões da aplicação utilizando armazenamento local

### Requisito 8: Fluxo do Jogo

**User Story:** Como Jogador, eu quero que o Jogador sempre comece a partida, para que o fluxo do jogo seja previsível.

#### Critérios de Aceitação

1. WHEN uma nova partida é iniciada, THE App SHALL atribuir o primeiro turno ao Jogador
2. WHEN a partida está em andamento, THE App SHALL alternar os turnos entre o Jogador e a IA após cada jogada válida
