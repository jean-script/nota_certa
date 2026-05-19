# ml_nota_certa

Aplicativo Flutter para gerenciamento e análise de avaliações escolares com suporte a leitura de cartão resposta via câmera e armazenamento offline.

---

# ✨ Funcionalidades

## 📚 Gestão Escolar

- Seleção de escolas
- Seleção de turmas
- Seleção de avaliações
- Listagem de alunos
- Navegação modular por contexto escolar

---

## 📝 Lançamento de Respostas

### Manual

- Preenchimento manual das respostas
- Salvamento automático por aluno
- Recuperação de respostas salvas
- Persistência local offline
- Interface otimizada para celular e tablet

### Via câmera

- Captura de cartão resposta
- Leitura das marcações
- Detecção de alternativas preenchidas
- Armazenamento da imagem escaneada

---

## 📷 Scanner OMR

O aplicativo possui um sistema de leitura de cartão resposta utilizando:

- Camera plugin
- Processamento de imagem
- Detecção de marcações
- Análise por intensidade

Fluxo:

1. Captura da imagem
2. Processamento do cartão
3. Detecção das respostas
4. Persistência local do scan

---

# 🖼️ Gabarito Utilizado

A imagem base utilizada para o processamento e leitura do cartão resposta está disponível em:

```bash
assets/imgs/gabarito_usando.png
```

Essa imagem é utilizada como referência visual para:

- Posicionamento das alternativas
- Detecção das marcações
- Processamento OMR
- Leitura do cartão resposta

---

## 📊 Dashboard

- Média da turma
- Maior nota
- Menor nota
- Ranking de alunos
- Quantidade de alunos corrigidos
- Questões com maior índice de erro
- Estatísticas da avaliação
- Indicadores de desempenho

---

## 💾 Persistência Local

Utilizando Hive para:

- Respostas dos alunos
- Scans realizados
- Cache local
- Funcionamento offline
- Dados das avaliações

---

## 📄 Exportação

- Exportação em PDF
- Relatórios da turma
- Ranking de alunos
- Estatísticas da avaliação
- Resultado individual por aluno

---

# 🏗️ Arquitetura

O projeto utiliza:

- Clean Architecture
- GetX
- Modularização por feature
- Repository Pattern
- UseCases
- Persistência local com Hive

---

# 📂 Estrutura do Projeto

```bash
lib/
 ├── app/
 │    ├── modules/
 │    │     ├── school/
 │    │     ├── camera/
 │    │     ├── dashboard/
 │    │     └── shared/
 │    │
 │    ├── services/
 │    ├── routes/
 │    ├── utils/
 │    └── pages/
 │
 └── main.dart
```

---

# 🔍 Monitoramento e Logs

O aplicativo possui monitoramento de erros e crashes utilizando:

- Firebase Crashlytics
- Logs customizados da aplicação
- Rastreamento de falhas em produção
- Monitoramento de erros não tratados

Isso permite identificar problemas em produção, acompanhar falhas e melhorar a estabilidade da aplicação.

---

---

# 📦 Principais Dependências

## Estado e arquitetura

- get
- dartz

## Persistência

- hive
- hive_flutter

## Câmera e imagem

- camera
- image

## Exportação

- pdf
- printing

## UI

- flutter_screenutil
- google_fonts

---

# 🚀 Como executar

## 1. Clonar projeto

```bash
git clone <repo>
```

---

## 2. Instalar dependências

```bash
flutter pub get
```

---

## 3. Rodar aplicação

```bash
flutter run
```

---

# 📱 Plataformas

- Android
- iOS
- Tablet Android
- Celular Android

---

# 🔥 Diferenciais

- Funciona offline
- Leitura via câmera
- Arquitetura escalável
- Modularização por feature
- Persistência local
- Responsivo para tablet
- Processamento OMR em Flutter

---

# 🧠 Tecnologias

- Flutter
- Dart
- GetX
- Hive
- CameraX
- OMR
- Clean Architecture
- Firebase Crashlytics

---

# 📌 Roadmap

- [ ] Sincronização online
- [ ] Backup em nuvem
- [ ] Dashboard web
- [ ] Exportação Excel
- [ ] Correção em lote
- [ ] Reconhecimento por IA
- [ ] Geração dinâmica de cartões resposta

---

# 👨‍💻 Autor

Jean Carlos Aires
