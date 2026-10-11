-- DADOS 100% SIMULADOS para demonstrar o modelo dimensional da universidade.
-- Não representam registros reais do curso ou de uma instituição.
-- Execute modelo_estrela.sql antes deste arquivo.
USE universidade_dw;

INSERT INTO dim_data
    (data_key, data_completa, dia, mes, nome_mes, trimestre, semestre, ano)
VALUES
    (20250210, '2025-02-10', 10, 2, 'Fevereiro', 1, 1, 2025),
    (20250212, '2025-02-12', 12, 2, 'Fevereiro', 1, 1, 2025),
    (20250213, '2025-02-13', 13, 2, 'Fevereiro', 1, 1, 2025),
    (20250214, '2025-02-14', 14, 2, 'Fevereiro', 1, 1, 2025),
    (20250217, '2025-02-17', 17, 2, 'Fevereiro', 1, 1, 2025),
    (20250804, '2025-08-04', 4, 8, 'Agosto', 3, 2, 2025),
    (20250805, '2025-08-05', 5, 8, 'Agosto', 3, 2, 2025),
    (20250806, '2025-08-06', 6, 8, 'Agosto', 3, 2, 2025),
    (20250807, '2025-08-07', 7, 8, 'Agosto', 3, 2, 2025),
    (20250808, '2025-08-08', 8, 8, 'Agosto', 3, 2, 2025),
    (20260209, '2026-02-09', 9, 2, 'Fevereiro', 1, 1, 2026),
    (20260210, '2026-02-10', 10, 2, 'Fevereiro', 1, 1, 2026);

INSERT INTO dim_departamento
    (departamento_key, id_departamento, nome, campus, id_professor_coordenador)
VALUES
    (1, 1, 'Computação', 'Campus Central', 101),
    (2, 2, 'Matemática', 'Campus Norte', 103),
    (3, 3, 'Administração', 'Campus Central', 105);

INSERT INTO dim_professor (professor_key, id_professor, nome_professor)
VALUES
    (1, 101, 'Ana Silva'),
    (2, 102, 'Bruno Costa'),
    (3, 103, 'Carla Souza'),
    (4, 104, 'Diego Lima'),
    (5, 105, 'Elisa Martins');

INSERT INTO dim_curso (curso_key, id_curso, nome_curso)
VALUES
    (1, 201, 'Desenvolvimento de Sistemas'),
    (2, 202, 'Banco de Dados'),
    (3, 203, 'Estatística'),
    (4, 204, 'Cálculo Aplicado'),
    (5, 205, 'Gestão de Projetos'),
    (6, 206, 'Ciência de Dados');

INSERT INTO dim_disciplina (disciplina_key, id_disciplina, nome_disciplina)
VALUES
    (1, 301, 'Programação I'),
    (2, 302, 'Banco de Dados I'),
    (3, 303, 'Estatística Aplicada'),
    (4, 304, 'Cálculo I'),
    (5, 305, 'Gestão de Projetos'),
    (6, 306, 'Inteligência Artificial');

-- Granularidade: uma linha por professor + disciplina + curso + data de oferta.
-- Há ofertas interdepartamentais para permitir analisar os dois papéis de departamento.
INSERT INTO fato_oferta_disciplina
    (data_key, professor_key, disciplina_key, curso_key,
     departamento_professor_key, departamento_curso_key, quantidade_ofertas)
VALUES
    (20250210, 1, 1, 1, 1, 1, 1),
    (20250804, 1, 1, 6, 1, 1, 1),
    (20260209, 1, 6, 6, 1, 1, 1),
    (20250212, 2, 2, 2, 1, 1, 1),
    (20250805, 2, 2, 1, 1, 1, 1),
    (20260210, 2, 2, 6, 1, 1, 1),
    (20250213, 3, 3, 3, 2, 2, 1),
    (20250806, 3, 3, 6, 2, 1, 1),
    (20250214, 4, 4, 1, 2, 1, 1),
    (20250807, 4, 4, 4, 2, 2, 1),
    (20250217, 5, 5, 5, 3, 3, 1),
    (20250808, 5, 5, 6, 3, 1, 1);

-- Conferência simples do volume carregado.
SELECT 'dim_data' AS tabela, COUNT(*) AS registros FROM dim_data
UNION ALL SELECT 'dim_departamento', COUNT(*) FROM dim_departamento
UNION ALL SELECT 'dim_professor', COUNT(*) FROM dim_professor
UNION ALL SELECT 'dim_curso', COUNT(*) FROM dim_curso
UNION ALL SELECT 'dim_disciplina', COUNT(*) FROM dim_disciplina
UNION ALL SELECT 'fato_oferta_disciplina', COUNT(*) FROM fato_oferta_disciplina;
