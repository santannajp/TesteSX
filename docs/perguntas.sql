--1. Qual a escola com a maior média de notas?
--Se considerarmos que não temos o nome da escola, mas sim NO_MUNICIPIO_ESC como representação da dimensão escola):

SELECT e.NO_MUNICIPIO_ESC AS escola,
       AVG((f.NU_NOTA_CN + f.NU_NOTA_CH + f.NU_NOTA_LC + f.NU_NOTA_MT)/4) AS media_escola
FROM FATO_NOTAS_ENEM f
JOIN DIM_ESCOLA e ON f.FK_ESCOLA = e.ID_ESCOLA
GROUP BY e.NO_MUNICIPIO_ESC
ORDER BY media_escola DESC
LIMIT 1;
--Isso retorna a localidade (como proxy de “escola”) com maior média. Se você tivesse NO_ESCOLA real, bastaria substituir NO_MUNICIPIO_ESC por NO_ESCOLA.

--2. Qual o aluno com a maior média de notas e o valor dessa média?
SELECT f.FK_ALUNO,
       AVG((f.NU_NOTA_CN + f.NU_NOTA_CH + f.NU_NOTA_LC + f.NU_NOTA_MT)/4) AS media_aluno
FROM FATO_NOTAS_ENEM f
GROUP BY f.FK_ALUNO
ORDER BY media_aluno DESC
LIMIT 1;
--Se quiser também o valor dessa média, já está no SELECT.

--3. Qual a média geral?
SELECT AVG((NU_NOTA_CN + NU_NOTA_CH + NU_NOTA_LC + NU_NOTA_MT)/4) AS media_geral
FROM FATO_NOTAS_ENEM;
--4. Qual o % de Ausentes?
--Assumindo que TP_PRESENCA_X = 0 (presente), 1 (eliminado), 2 (ausente). Ajuste conforme a documentação:

SELECT 
  (SUM(
    CASE WHEN TP_PRESENCA_CN = 2 OR TP_PRESENCA_CH = 2 OR TP_PRESENCA_LC = 2 OR TP_PRESENCA_MT = 2
    THEN 1 ELSE 0 END
  ) / COUNT(*)) * 100 AS percentual_ausentes
FROM FATO_NOTAS_ENEM;
--Isso calcula a porcentagem de inscritos que foram ausentes em pelo menos uma prova.

--5. Qual o número total de Inscritos?
SELECT COUNT(*) AS total_inscritos
FROM FATO_NOTAS_ENEM;
--Dependendo do nível de granularidade (cada linha = 1 inscrito), isso dá o total. Se houver duplicatas, ajuste a lógica (provavelmente não há duplicatas se a fato é por aluno-inscrição).

--6. Qual a média por disciplina?
SELECT 
   AVG(NU_NOTA_CN) AS media_cn,
   AVG(NU_NOTA_CH) AS media_ch,
   AVG(NU_NOTA_LC) AS media_lc,
   AVG(NU_NOTA_MT) AS media_mt
FROM FATO_NOTAS_ENEM;

--Se incluir redação também:

SELECT 
   AVG(NU_NOTA_CN) AS media_cn,
   AVG(NU_NOTA_CH) AS media_ch,
   AVG(NU_NOTA_L