# Modelagem Dimensional - ENEM 2020

## Ferramentas
- Diagramas criados via draw.io ou MySQL Workbench.

## Esquema Estrela

### Tabela Fato: FATO_NOTAS_ENEM
- NU_NOTA_CN, NU_NOTA_CH, NU_NOTA_LC, NU_NOTA_MT, NU_NOTA_REDACAO
- TP_PRESENCA_CN, TP_PRESENCA_CH, TP_PRESENCA_LC, TP_PRESENCA_MT
- FK_ALUNO, FK_ESCOLA, (etc.)

### Dimensões
#### DIM_ALUNO
- ID_ALUNO (PK)
- TP_SEXO
- TP_COR_RACA
- ... outros atributos

#### DIM_ESCOLA
- ID_ESCOLA (PK)
- CO_ESCOLA
- NO_ESCOLA
- TP_DEPENDENCIA_ADM_ESC

#### DIM_SOCIOECONOMICO
- ID_SOCIOECO (PK)
- Q001, Q002, etc.

## Diagrama
![alt text](<modelo estrela.png>)



