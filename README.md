# 🎟️ Sistema Distribuído de Reserva de Ingressos

## 📌 Descrição

Este projeto implementa um sistema distribuído de venda de ingressos utilizando:

* Servidor em Julia
* Clientes concorrentes simulando compradores
* Docker e Docker Compose para orquestração

O objetivo é demonstrar **concorrência, sincronização e comunicação em rede**.

---

## 🧠 Conceitos Aplicados

* Concorrência com múltiplas requisições simultâneas
* Seção crítica protegida com **Mutex (ReentrantLock)**
* Comunicação via HTTP
* Execução distribuída com containers Docker

---

## 🏗️ Arquitetura

* **Servidor**

  * Gerencia os ingressos disponíveis
  * Recebe requisições HTTP (`/reservar`)
  * Controla concorrência com mutex

* **Clientes**

  * Simulam usuários comprando ingressos
  * Disparam múltiplas requisições simultâneas

* **Docker Compose**

  * 1 container do servidor
  * 3 containers de clientes

---

## ⚙️ Tecnologias Utilizadas

* Julia 1.10
* HTTP.jl
* Docker
* Docker Compose

---

## 🚀 Como Executar

### 1. Clonar o projeto

```bash
git clone <repo>
cd <pasta>
```

### 2. Subir os containers

```bash
docker compose up --build
```

---

## 🌐 Endpoint

```
GET /reservar
```

### Respostas possíveis:

* `Reserva Confirmada`
* `Ingressos Esgotados`

---

# 📊 Visualização de Logs

## 📌 Logs do Servidor

Para visualizar apenas os logs do servidor:

```bash
docker compose logs server
```

---

## 📌 Logs em tempo real

```bash
docker compose logs -f server
```

👉 Mostra os logs conforme o sistema executa.

---

## 📌 Logs de todos os serviços

```bash
docker compose logs
```

---

## 📌 Filtrar apenas clientes

```bash
docker compose logs client1
docker compose logs client2
docker compose logs client3
```

---

## 🔍 O que observar nos logs

### ✔ Funcionamento correto:

```
Ingressos restantes: 99
Ingressos restantes: 98
Ingressos restantes: 97
...
```

---

### ✔ Após esgotar:

```
Resposta: Ingressos Esgotados
```

---

### ⚠️ Logs misturados (normal):

```
Ingressos restantes: 86rmada
```

👉 Isso ocorre por múltiplas threads escrevendo simultaneamente.

---

## 🧪 Teste de concorrência

* Múltiplos clientes fazem requisições ao mesmo tempo
* O servidor responde sem inconsistência
* Não há valores negativos ou duplicados

---

## 🧹 Limpeza de containers

Se houver erro de conflito:

```bash
docker compose down
docker rm -f server
```

---

## 🚀 Dica

Use:

```bash
docker compose logs -f server
```

para acompanhar a execução em tempo real durante a apresentação.
