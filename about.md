# About

This is a practice of SQL language, simulating a database for a service order maintenance system. SQL is  inside the discipline of databases 1, belonging to the course of Computer Engineering.

## content

- DDL
  - create table
  - primary key
  - foreign key
  - alter table
  - insert

- DML
  - equi-join
  - inner-join
  - equi-join
  - inner-join
  - like
  - %
  - _
  - in
  - group by
  - having

---

## Descrição

### Cenário

O cenário a ser abordado descreve um banco de dados de um sistema de ordens de manutenção.

### Database

#### Ordens de manutenção

A solicitação de serviço é gerada por um solicitante, sendo aprovada pelo administrador é gerada a ordem de serviço. A ordem de serviço pode ser realizada por um ou mais mantenedores e utilizar mais de uma peça para reposição. Ao ser utilizado algum material deverá ser gerado uma requisição de serviço para o setor de almoxarifado para controle. Na ordem de serviço são contabilizados as peças e horas de trabalho a fim de ratear os custos de manutenção por setor. Os valores para horas de serviço e peças seguem tabelas pré-fixadas fornecidas pelo sistema do cliente. As datas de abertura da solicitação e aprovação da mesma são necessárias para medição do tempo de atendimento.

---

## Modelo Conceitual

![Modelo Conceitual database Ordens de Serviço de Manutenção](/model.jpg)

---
