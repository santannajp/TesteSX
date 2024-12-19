import pandas as pd

def main():
    # 1. Ler o CSV
    df = pd.read_csv(
        "data/microdados_enem_2020/DADOS/MICRODADOS_ENEM_2020.csv",
        sep=';',  # Verifique se realmente é ';'
        encoding='latin-1',
        low_memory=False
    )

    # 2. Definir colunas
    col_dim_aluno = ["TP_SEXO", "TP_COR_RACA"]
    col_dim_escola = [
        "CO_MUNICIPIO_ESC",
        "NO_MUNICIPIO_ESC",
        "CO_UF_ESC",
        "SG_UF_ESC",
        "TP_DEPENDENCIA_ADM_ESC",
        "TP_LOCALIZACAO_ESC",
        "TP_SIT_FUNC_ESC"
    ]
    col_fact_notas = [
        "NU_NOTA_CN", "NU_NOTA_CH", "NU_NOTA_LC", "NU_NOTA_MT",
        "NU_NOTA_REDACAO",
        "TP_PRESENCA_CN", "TP_PRESENCA_CH", "TP_PRESENCA_LC", "TP_PRESENCA_MT"
    ]

    # 3. Criar subset
    df_subset = df[col_dim_aluno + col_dim_escola + col_fact_notas].copy()

    # 4. Dimensão Aluno
    df_dim_aluno = (
        df_subset[col_dim_aluno]
        .drop_duplicates()
        .reset_index(drop=True)
    )
    df_dim_aluno["ID_ALUNO"] = df_dim_aluno.index + 1

    # 5. Dimensão Escola/Localidade
    df_dim_escola = (
        df_subset[col_dim_escola]
        .drop_duplicates()
        .reset_index(drop=True)
    )
    df_dim_escola["ID_ESCOLA"] = df_dim_escola.index + 1

    # 6. Construir tabela fato (sem dropna ainda)
    df_fato = df_subset.merge(df_dim_aluno, on=col_dim_aluno, how="left")
    df_fato = df_fato.merge(df_dim_escola, on=col_dim_escola, how="left")

    # Selecionar colunas finais
    df_fato = df_fato[[
        "ID_ALUNO", "ID_ESCOLA",
        "NU_NOTA_CN", "NU_NOTA_CH", "NU_NOTA_LC", "NU_NOTA_MT", "NU_NOTA_REDACAO",
        "TP_PRESENCA_CN", "TP_PRESENCA_CH", "TP_PRESENCA_LC", "TP_PRESENCA_MT"
    ]].copy()
    df_fato.rename(columns={"ID_ALUNO": "FK_ALUNO", "ID_ESCOLA": "FK_ESCOLA"}, inplace=True)

    # 7. Excluir linhas com valores vazios *apenas* na tabela fato
    df_fato.dropna(how='any', inplace=True)

    # 8. Exportar para CSV
    df_dim_aluno.to_csv("data/DIM_ALUNO.csv", index=False)
    df_dim_escola.to_csv("data/DIM_ESCOLA.csv", index=False)
    df_fato.to_csv("data/FATO_NOTAS_ENEM.csv", index=False)

    print("ETL concluído. FATO_NOTAS_ENEM gerado sem linhas vazias.")

if __name__ == "__main__":
    main()
