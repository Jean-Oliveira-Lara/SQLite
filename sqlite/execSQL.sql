.mode table 
.echo off

select count(*) as 'QUANTIDADE DE PESSOAS CADASTRADAS' from pessoa;

select count(*) as 'QUANTIDADE DE TURMAS CADASTRADAS' from turma;

select count(*) as 'QUANTIDADE DE TURMAS ATIVAS' from turma where dt_encerramento IS NULL;

select s.status as 'STATUS', count(*) 'QUANTIDADE DE TURMAS'
from turma t, status_turma st, status s
where t.turma_id = st.turma_id
and   st.status_id = s.status_id
and   st.dt_status = (select max(dt_status) from status_turma st2
                      where st.turma_id = st2.turma_id)

group by 1;

select sum(valor_gasto) as 'TOTAL DE GASTOS'     from gasto_turma;
select sum(valor_pago)  as 'TOTAL DE PAGAMENTOS' from pagamento_turma;

SELECT
    COALESCE((SELECT SUM(valor_pago) FROM pagamento_turma), 0)
  - COALESCE((SELECT SUM(valor_gasto) FROM gasto_turma), 0) as 'SALDO'

SELECT
    t.turma_id,
    t.nome,
    COALESCE(p.total_pago, 0) - COALESCE(g.total_gasto, 0) AS saldo
FROM turma t
LEFT JOIN (
    SELECT turma_id, SUM(valor_pago) AS total_pago
    FROM pagamento_turma
    GROUP BY turma_id
) p ON p.turma_id = t.turma_id
LEFT JOIN (
    SELECT turma_id, SUM(valor_gasto) AS total_gasto
    FROM gasto_turma
    GROUP BY turma_id
) g ON g.turma_id = t.turma_id;

WITH pagos AS (
    SELECT turma_id, SUM(valor_pago) AS total_pago
    FROM pagamento_turma
    GROUP BY turma_id
),
gastos AS (
    SELECT turma_id, SUM(valor_gasto) AS total_gasto
    FROM gasto_turma
    GROUP BY turma_id
)
SELECT
    t.turma_id,
    t.nome,
    COALESCE(p.total_pago, 0) - COALESCE(g.total_gasto, 0) AS saldo
FROM turma t
LEFT JOIN pagos p ON p.turma_id = t.turma_id
LEFT JOIN gastos g ON g.turma_id = t.turma_id;
