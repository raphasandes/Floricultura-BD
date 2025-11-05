# 🌸 Modelagem de Banco de Dados: Floricultura Flores Belas

## 🎯 Objetivo

Desenvolver a modelagem de um banco de dados relacional para gerenciar clientes, produtos e encomendas da floricultura "Flores Belas", visando agilizar o processo de vendas e entregas.

## 🗃️ Conteúdo do Repositório

Este projeto está dividido em duas partes essenciais da modelagem de dados:

| Pasta | Arquivo Principal | Tipo de Conteúdo |
| :--- | :--- | :--- |
| **`sql/`** | `MODELAGEM FLORICULTURA COMPLETO.sql` | **Script DDL e DML** (Criação de Tabelas e Inserções). |
| **`docs/`** | `Floricultura_114 - Conceitual.brM3` | **Modelo Conceitual** (Diagrama Entidade-Relacionamento). |

---

## ⚠️ Nota Importante sobre o Modelo Conceitual

O arquivo `Floricultura_114 - Conceitual.brM3` é o modelo conceitual em seu formato nativo.

* O GitHub não consegue renderizar o arquivo.
* Para visualizá-lo, é necessário utilizar o software **BRModelo**.

## 💡 Estrutura da Modelagem (Resumida pelo SQL)

O modelo foi construído com base nas seguintes entidades principais (Tabelas, conforme o script SQL):

* `Cliente`
* `Produto`
* `Encomenda`
* `LocalEntrega`
* `TipoProduto`

O relacionamento **N:N** (uma Encomenda com vários Produtos) foi resolvido com o uso de chaves estrangeiras na tabela `Encomenda`, conforme visível no script.
