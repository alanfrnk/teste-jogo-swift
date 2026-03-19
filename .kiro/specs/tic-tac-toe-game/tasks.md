# Plano de Implementação: Jogo da Velha (Tic-Tac-Toe)

## Visão Geral

Implementação incremental do jogo da velha em Swift/SwiftUI seguindo a arquitetura MVVM. Cada tarefa constrói sobre a anterior, começando pelos modelos de dados, passando pela lógica de jogo e IA, até as views e integração final.

## Tarefas

- [x] 1. Criar estrutura do projeto e modelos de dados
  - [x] 1.1 Criar o enum `Player` e o enum `GameResult`
    - Definir `Player` com cases `.x` (jogador humano) e `.o` (IA), com `rawValue: String`
    - Definir `GameResult` com cases `.win`, `.lose`, `.draw`
    - _Requisitos: 3.1, 5.1, 5.2_

  - [x] 1.2 Criar o struct `GameBoard`
    - Implementar `cells: [Player?]` como array de 9 posições
    - Implementar constante `winPatterns` com as 8 combinações vencedoras
    - Implementar `isEmptyAt(_:)`, `availableMoves()`, `place(_:at:)`
    - Implementar `checkWinner()` que verifica todas as combinações vencedoras
    - Implementar `isDraw()` que verifica tabuleiro cheio sem vencedor
    - _Requisitos: 2.1, 2.3, 5.1, 5.2_

  - [ ]* 1.3 Escrever teste de propriedade para detecção de vencedor
    - **Propriedade 7: Detecção correta de vencedor**
    - **Valida: Requisito 5.1**

  - [ ]* 1.4 Escrever teste de propriedade para detecção de empate
    - **Propriedade 8: Detecção correta de empate**
    - **Valida: Requisito 5.2**

  - [ ]* 1.5 Escrever testes unitários para `GameBoard`
    - Testar `isEmptyAt` para células vazias e ocupadas
    - Testar `availableMoves` para tabuleiros parcialmente preenchidos
    - Testar `place` para posicionamento correto
    - Testar `checkWinner` para linhas, colunas e diagonais
    - Testar `isDraw` para tabuleiro cheio sem vencedor e tabuleiro incompleto
    - _Requisitos: 2.3, 5.1, 5.2_

- [x] 2. Implementar a lógica da IA
  - [x] 2.1 Criar o struct `AIPlayer` com método estático `bestMove(board:)`
    - Implementar estratégia de prioridade: (a) vencer, (b) bloquear vitória do jogador, (c) posição estratégica (centro > cantos > laterais)
    - Adicionar guard clause para tabuleiro sem células disponíveis
    - _Requisitos: 4.1, 4.2_

  - [ ]* 2.2 Escrever teste de propriedade para jogada válida da IA
    - **Propriedade 5: IA sempre joga em uma célula vazia válida**
    - **Valida: Requisito 4.1**

  - [ ]* 2.3 Escrever teste de propriedade para prioridade da IA
    - **Propriedade 6: IA prioriza vitória sobre bloqueio e bloqueio sobre posição estratégica**
    - **Valida: Requisito 4.2**

  - [ ]* 2.4 Escrever testes unitários para `AIPlayer`
    - Testar que a IA escolhe a jogada vencedora quando disponível
    - Testar que a IA bloqueia a vitória do jogador
    - Testar preferência por centro, cantos e laterais
    - _Requisitos: 4.1, 4.2_

- [x] 3. Checkpoint — Verificar modelos e IA
  - Garantir que todos os testes passam, perguntar ao usuário se houver dúvidas.

- [x] 4. Implementar o ScoreManager (persistência de placar)
  - [x] 4.1 Criar a classe `ScoreManager` como `ObservableObject`
    - Implementar `@AppStorage` para `wins`, `losses` e `draws`
    - Implementar `recordWin()`, `recordLoss()`, `recordDraw()` e `reset()`
    - _Requisitos: 7.1, 7.2, 7.3, 7.4, 1.4_

  - [ ]* 4.2 Escrever teste de propriedade para reset do placar
    - **Propriedade 1: Reset do placar zera todos os contadores**
    - **Valida: Requisito 1.4**

  - [ ]* 4.3 Escrever teste de propriedade para incremento correto do placar
    - **Propriedade 9: Registro de resultado incrementa apenas o contador correto**
    - **Valida: Requisitos 7.1, 7.2, 7.3**

  - [ ]* 4.4 Escrever teste de propriedade para persistência do placar
    - **Propriedade 10: Persistência do placar (round trip)**
    - **Valida: Requisito 7.4**

- [x] 5. Implementar o GameViewModel
  - [x] 5.1 Criar a classe `GameViewModel` como `ObservableObject`
    - Implementar `@Published board: GameBoard`, `@Published isPlayerTurn: Bool`, `@Published gameResult: GameResult?`
    - Receber `ScoreManager` como dependência
    - Implementar `playerMove(at:)` com validações (célula vazia, turno do jogador)
    - Implementar `aiMove()` usando `AIPlayer.bestMove` com delay para UX
    - Implementar `resetGame()` para reiniciar o tabuleiro
    - Implementar verificação de vitória/empate após cada jogada, atualizando `gameResult` e `ScoreManager`
    - _Requisitos: 3.1, 3.2, 3.3, 4.1, 4.3, 5.1, 5.2, 7.1, 7.2, 7.3, 8.1, 8.2_

  - [ ]* 5.2 Escrever teste de propriedade para jogada do jogador
    - **Propriedade 2: Jogada do jogador marca "X" em célula vazia**
    - **Valida: Requisito 3.1**

  - [ ]* 5.3 Escrever teste de propriedade para célula ocupada
    - **Propriedade 3: Toque em célula ocupada não altera o tabuleiro**
    - **Valida: Requisito 3.2**

  - [ ]* 5.4 Escrever teste de propriedade para input durante turno da IA
    - **Propriedade 4: Input do jogador é ignorado durante o turno da IA**
    - **Valida: Requisito 3.3**

  - [ ]* 5.5 Escrever teste de propriedade para estado inicial
    - **Propriedade 11: Nova partida começa com o turno do jogador**
    - **Valida: Requisito 8.1**

  - [ ]* 5.6 Escrever teste de propriedade para alternância de turnos
    - **Propriedade 12: Turnos alternam após cada jogada válida**
    - **Valida: Requisito 8.2**

  - [ ]* 5.7 Escrever testes unitários para `GameViewModel`
    - Testar fluxo completo de uma partida com vitória do jogador
    - Testar fluxo completo de uma partida com vitória da IA
    - Testar fluxo completo de uma partida com empate
    - Testar que `resetGame()` limpa o tabuleiro e define turno do jogador
    - _Requisitos: 3.1, 3.2, 3.3, 4.3, 5.1, 5.2, 8.1, 8.2_

- [x] 6. Checkpoint — Verificar lógica completa do jogo
  - Garantir que todos os testes passam, perguntar ao usuário se houver dúvidas.

- [x] 7. Implementar as Views do SwiftUI
  - [x] 7.1 Criar `CellView` para renderizar uma célula individual
    - Exibir "X", "O" ou vazio conforme o estado da célula
    - Estilizar com bordas e tamanho adequado
    - _Requisitos: 2.1, 2.3_

  - [x] 7.2 Criar `ResultOverlay` para animação de resultado
    - Exibir texto animado "You Win", "You Lose" ou "Draw" conforme `GameResult`
    - Incluir botão para retornar à tela inicial
    - Aplicar animações de entrada (scale, opacity)
    - _Requisitos: 6.1, 6.2, 6.3, 6.4_

  - [x] 7.3 Criar `GameView` com tabuleiro 3x3
    - Renderizar grade 3x3 usando `LazyVGrid` com 9 `CellView`
    - Exibir placar durante a partida (vitórias, derrotas, empates)
    - Delegar toques ao `GameViewModel.playerMove(at:)`
    - Apresentar `ResultOverlay` quando `gameResult` não for nil
    - _Requisitos: 2.1, 2.2, 2.3, 3.1, 6.1, 6.2, 6.3, 6.4_

  - [x] 7.4 Criar `HomeView` como tela inicial
    - Exibir botão "Jogar" e botão "Zerar Placar"
    - Exibir placar atual (vitórias, derrotas, empates) via `ScoreManager`
    - Navegar para `GameView` ao pressionar "Jogar"
    - Chamar `ScoreManager.reset()` ao pressionar "Zerar Placar"
    - _Requisitos: 1.1, 1.2, 1.3, 1.4_

- [x] 8. Integração e ponto de entrada do App
  - [x] 8.1 Configurar o `App` entry point com `ScoreManager` como `@StateObject`
    - Criar `TicTacToeApp` com `@main`
    - Instanciar `ScoreManager` como `@StateObject` e injetá-lo via `environmentObject`
    - Definir `HomeView` como view raiz dentro de `NavigationStack`
    - _Requisitos: 1.1, 1.2, 7.4_

  - [ ]* 8.2 Escrever testes unitários para as Views
    - Verificar que `HomeView` exibe botões "Jogar" e "Zerar Placar" (Requisito 1.1)
    - Verificar que `HomeView` exibe o placar atual (Requisito 1.2)
    - Verificar que `GameView` renderiza grade 3x3 com 9 células (Requisito 2.1)
    - Verificar textos de resultado "You Win", "You Lose", "Draw" (Requisitos 6.1, 6.2, 6.3)
    - Verificar botão de retorno na tela de resultado (Requisito 6.4)
    - _Requisitos: 1.1, 1.2, 2.1, 6.1, 6.2, 6.3, 6.4_

- [x] 9. Checkpoint final — Verificar integração completa
  - Garantir que todos os testes passam, perguntar ao usuário se houver dúvidas.

## Notas

- Tarefas marcadas com `*` são opcionais e podem ser puladas para um MVP mais rápido
- Cada tarefa referencia requisitos específicos para rastreabilidade
- Checkpoints garantem validação incremental
- Testes de propriedade validam propriedades universais de corretude
- Testes unitários validam exemplos específicos e edge cases
- A biblioteca SwiftCheck é utilizada para testes baseados em propriedades
