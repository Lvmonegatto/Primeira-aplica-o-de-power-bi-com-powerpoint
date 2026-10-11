-- Modelo dimensional estrela para análise de professores e ofertas de disciplinas.
-- Execute em uma base de desenvolvimento. Este script cria apenas a estrutura;
-- os dados e datas de oferta não vieram no documento de referência.

CREATE DATABASE IF NOT EXISTS universidade_dw
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE universidade_dw;

CREATE TABLE IF NOT EXISTS dim_data (
    data_key INT NOT NULL COMMENT 'Formato YYYYMMDD',
    data_completa DATE NOT NULL,
    dia TINYINT NOT NULL,
    mes TINYINT NOT NULL,
    nome_mes VARCHAR(20) NOT NULL,
    trimestre TINYINT NOT NULL,
    semestre TINYINT NOT NULL,
    ano SMALLINT NOT NULL,
    PRIMARY KEY (data_key),
    UNIQUE KEY uq_dim_data_completa (data_completa)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dim_professor (
    professor_key INT NOT NULL AUTO_INCREMENT,
    id_professor INT NOT NULL,
    nome_professor VARCHAR(120) NULL COMMENT 'Preencher somente se existir na origem',
    PRIMARY KEY (professor_key),
    UNIQUE KEY uq_dim_professor_origem (id_professor)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dim_disciplina (
    disciplina_key INT NOT NULL AUTO_INCREMENT,
    id_disciplina INT NOT NULL,
    nome_disciplina VARCHAR(120) NULL COMMENT 'Preencher somente se existir na origem',
    PRIMARY KEY (disciplina_key),
    UNIQUE KEY uq_dim_disciplina_origem (id_disciplina)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dim_curso (
    curso_key INT NOT NULL AUTO_INCREMENT,
    id_curso INT NOT NULL,
    nome_curso VARCHAR(120) NULL COMMENT 'Preencher somente se existir na origem',
    PRIMARY KEY (curso_key),
    UNIQUE KEY uq_dim_curso_origem (id_curso)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS dim_departamento (
    departamento_key INT NOT NULL AUTO_INCREMENT,
    id_departamento INT NOT NULL,
    nome VARCHAR(45) NULL,
    campus VARCHAR(45) NULL,
    id_professor_coordenador INT NULL COMMENT 'Identificador de origem do coordenador',
    PRIMARY KEY (departamento_key),
    UNIQUE KEY uq_dim_departamento_origem (id_departamento)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS fato_oferta_disciplina (
    oferta_key BIGINT NOT NULL AUTO_INCREMENT,
    data_key INT NOT NULL,
    professor_key INT NOT NULL,
    disciplina_key INT NOT NULL,
    curso_key INT NOT NULL,
    departamento_professor_key INT NOT NULL,
    departamento_curso_key INT NOT NULL,
    quantidade_ofertas TINYINT NOT NULL DEFAULT 1,
    PRIMARY KEY (oferta_key),
    UNIQUE KEY uq_fato_granularidade (
        data_key,
        professor_key,
        disciplina_key,
        curso_key
    ),
    KEY ix_fato_professor (professor_key),
    KEY ix_fato_disciplina (disciplina_key),
    KEY ix_fato_curso (curso_key),
    KEY ix_fato_departamento_professor (departamento_professor_key),
    KEY ix_fato_departamento_curso (departamento_curso_key),
    CONSTRAINT fk_fato_data
        FOREIGN KEY (data_key) REFERENCES dim_data (data_key),
    CONSTRAINT fk_fato_professor
        FOREIGN KEY (professor_key) REFERENCES dim_professor (professor_key),
    CONSTRAINT fk_fato_disciplina
        FOREIGN KEY (disciplina_key) REFERENCES dim_disciplina (disciplina_key),
    CONSTRAINT fk_fato_curso
        FOREIGN KEY (curso_key) REFERENCES dim_curso (curso_key),
    CONSTRAINT fk_fato_departamento_professor
        FOREIGN KEY (departamento_professor_key) REFERENCES dim_departamento (departamento_key),
    CONSTRAINT fk_fato_departamento_curso
        FOREIGN KEY (departamento_curso_key) REFERENCES dim_departamento (departamento_key),
    CONSTRAINT chk_fato_quantidade_ofertas
        CHECK (quantidade_ofertas = 1)
) ENGINE=InnoDB;
