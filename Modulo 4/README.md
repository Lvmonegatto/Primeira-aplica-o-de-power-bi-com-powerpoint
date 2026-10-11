# Análise de dados da Company com MySQL e Power BI

Projeto desenvolvido como prática de análise de dados com o banco de exemplo **Company**. Os dados são consultados no MySQL, preparados no Power Query e apresentados em um relatório interativo no Power BI.

## Objetivo

Explorar a estrutura da empresa e apresentar informações sobre colaboradores, gerentes, departamentos e horas registradas em projetos. O trabalho também verifica situações que merecem atenção, como colaboradores sem gerente e projetos sem horas atribuídas.

## Ferramentas

- **MySQL** — armazenamento e consulta dos dados.
- **Power BI Desktop** — preparação dos dados e criação do relatório.
- **Power Query** — ajustes de tipos, combinações, divisão de colunas e agrupamentos.

## Relatório

A página **Visão Geral** reúne:

- colaboradores por gerente;
- colaboradores por departamento;
- horas registradas por projeto;
- observações sobre as anomalias encontradas.

## Preparação dos dados

No Power Query, foram realizadas as principais etapas abaixo:

- conferência dos tipos de dados e dos valores nulos;
- combinação dos dados de colaboradores com departamentos;
- combinação da tabela de colaboradores com ela mesma para identificar os nomes dos gerentes;
- combinação de departamentos com suas localizações;
- separação de informações de endereço em campos mais úteis;
- agrupamento de colaboradores por gerente e de horas por projeto;
- remoção de colunas que não eram necessárias para os visuais.

As combinações foram usadas quando era necessário acrescentar informações relacionadas lado a lado, como o nome do gerente ou a localização do departamento.

## Principais resultados

- **8 colaboradores** distribuídos em **3 departamentos**.
- **1 colaborador sem gerente:** James Borg, que ocupa o topo da hierarquia apresentada nos dados.
- **0 departamentos sem gerente.**
- Horas registradas: projeto 1 — **52,5 h**; projeto 2 — **52,5 h**; projeto 3 — **65 h**; projeto 10 — **65 h**.
- Os projetos 20 e 30 não apresentam horas atribuídas na tabela de alocação.

## Como abrir o projeto

1. Abra o arquivo `.pbix` no Power BI Desktop.
2. Para visualizar os dados já salvos no relatório, abra a página **Visão Geral**.
3. Para atualizar as consultas em outro computador, instale o MySQL e o conector MySQL compatível com o Power BI.
4. Importe o banco de dados de exemplo para o MySQL e ajuste, no Power BI, o servidor, o banco e as credenciais da conexão.
5. Atualize as consultas. A conexão usada neste projeto aponta para `localhost:3306` e para o banco `company_constraints`; em outro ambiente, esses valores podem precisar de alteração.

> O arquivo `.pbix` guarda o relatório e as consultas, mas a fonte MySQL é externa. Para atualizar os dados, o banco precisa estar disponível e acessível no computador usado.

## Arquivos do repositório

- `projeto_company_tratado.pbix` — relatório do Power BI.
- `README.md` — descrição do projeto e instruções de uso.
- Arquivo de criação ou carga do banco MySQL, caso seja incluído no repositório.

## Observação

Este é um projeto de estudo baseado em dados de exemplo. As conclusões descrevem apenas os registros disponíveis no banco utilizado.
