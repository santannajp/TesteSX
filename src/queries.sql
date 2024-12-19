-- 1. Escola com a maior média de notas
SELECT e.NO_ESCOLA,
       AVG((f.NU_NOTA_CN + f.NU_NOTA_CH + f.NU_NOTA_LC + f.NU_NOTA_MT)/4) AS media_escola
FROM FATO_NOTAS_ENEM f
JOIN DIM_ESCOLA e ON f.FK_ESCOLA = e.ID_ESCOLA
GROUP BY e.NO_ESCOLA
ORDER BY media_escola DESC
LIMIT 1;

-- 2. Aluno com a maior média de notas
SELECT FK_ALUNO,
       AVG((NU_NOTA_CN + NU_NOTA_CH + NU_NOTA_LC + NU_NOTA_MT)/4) AS media_aluno
FROM FATO_NOTAS_ENEM
GROUP BY FK_ALUNO
ORDER BY media_aluno DESC
LIMIT 1;

-- 3. Média geral
SELECT AVG((NU_NOTA_CN + NU_NOTA_CH + NU_NOTA_LC + NU_NOTA_MT)/4) AS media_geral
FROM FATO_NOTAS_ENEM;

-- 4. % de Ausentes
SELECT 
  (SUM(
    CASE WHEN TP_PRESENCA_CN = 2 OR TP_PRESENCA_CH = 2 OR TP_PRESENCA_LC = 2 OR TP_PRESENCA_MT = 2
    THEN 1 ELSE 0 END
  ) / COUNT(*)) * 100 AS percentual_ausentes
FROM FATO_NOTAS_ENEM;

-- 5. Número total de Inscritos
SELECT COUNT(*) AS total_inscritos
FROM FATO_NOTAS_ENEM;

-- 6. Média por disciplina
SELECT 
   AVG(NU_NOTA_CN) AS media_cn,
   AVG(NU_NOTA_CH) AS media_ch,
   AVG(NU_NOTA_LC) AS media_lc,
   AVG(NU_NOTA_MT) AS media_mt
FROM FATO_NOTAS_ENEM;

-- 7. Média por Sexo
SELECT a.TP_SEXO, 
       AVG((f.NU_NOTA_CN + f.NU_NOTA_CH + f.NU_NOTA_LC + f.NU_NOTA_MT)/4) AS media_sexo
FROM FATO_NOTAS_ENEM f
JOIN DIM_ALUNO a ON f.FK_ALUNO = a.ID_ALUNO
GROUP BY a.TP_SEXO;

-- 8. Média por Etnia
SELECT a.TP_COR_RACA,
       AVG((f.NU_NOTA_CN + f.NU_NOTA_CH + f.NU_NOTA_LC + f.NU_NOTA_MT)/4) AS media_etnia
FROM FATO_NOTAS_ENEM f
JOIN DIM_ALUNO a ON f.FK_ALUNO = a.ID_ALUNO
GROUP BY a.TP_COR_RACA;
