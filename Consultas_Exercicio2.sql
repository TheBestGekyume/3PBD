-- 1. Encontre os nomes de todos os empregados que
-- trabalham para o departamento de Engenharia Civil.

SELECT Nome 
FROM EMPREGADO 
WHERE Depto = (SELECT Numero FROM DEPARTAMENTO WHERE Nome = 'Engenharia Civil');

-- 2. Para todos os projetos localizados em “São Paulo”,
-- listar os números dos projetos, os números dos departamentos, 
-- e o nome do gerente do departamento.

SELECT PROJETO.Numero AS Projeto_Numero, 
       DEPARTAMENTO.Numero AS Departamento_Numero, 
       EMPREGADO.Nome AS Gerente_Nome
FROM PROJETO
JOIN DEPARTAMENTO_PROJETO ON PROJETO.Numero = DEPARTAMENTO_PROJETO.Numero_Projeto
JOIN DEPARTAMENTO ON DEPARTAMENTO.Numero = DEPARTAMENTO_PROJETO.Numero_Depto
JOIN EMPREGADO ON DEPARTAMENTO.RG_Gerente = EMPREGADO.RG
WHERE PROJETO.Localizacao = 'São Paulo';

-- 3. Encontre os empregados que trabalham em todos os
-- projetos controlados pelo departamento número 3.

SELECT *
FROM EMPREGADO E
WHERE NOT EXISTS (
    SELECT 1 
    FROM DEPARTAMENTO_PROJETO DP
    WHERE DP.Numero_Depto = 3
    AND NOT EXISTS (
        SELECT 1 
        FROM EMPREGADO_PROJETO EP
        WHERE EP.RG_Empregado = E.RG 
        AND EP.Numero_Projeto = DP.Numero_Projeto
    )
);

-- 4. Faça uma lista dos números dos projetos que envolvem um empregado 
-- chamado “Fernando” como um trabalhador ou como um gerente
-- do departamento que controla o projeto.

SELECT DISTINCT Numero_Projeto
FROM EMPREGADO_PROJETO
WHERE RG_Empregado = (SELECT RG FROM EMPREGADO WHERE Nome = 'Fernando')
UNION
SELECT Numero_Projeto
FROM DEPARTAMENTO_PROJETO
WHERE Numero_Depto = (SELECT Depto FROM EMPREGADO WHERE Nome = 'Fernando');


-- 5. Liste os nomes dos empregados que não possuem dependentes.

SELECT Nome 
FROM EMPREGADO
WHERE RG NOT IN (SELECT RG_Responsavel FROM DEPENDENTES);


-- 6. Liste os nomes dos gerentes que têm pelo menos um dependente.

SELECT DISTINCT E.Nome
FROM EMPREGADO E
JOIN DEPARTAMENTO D ON E.RG = D.RG_Gerente
WHERE E.RG IN (SELECT RG_Responsavel FROM DEPENDENTES);



-- 7. Selecione o número do departamento que controla
-- projetos localizados em Rio Claro.

SELECT DISTINCT Numero_Depto
FROM DEPARTAMENTO_PROJETO DP
JOIN PROJETO P ON DP.Numero_Projeto = P.Numero
WHERE P.Localizacao = 'Rio Claro';


-- 8. Selecione o nome e o RG de todos os funcionários que são supervisores.

SELECT DISTINCT E.Nome, E.RG
FROM EMPREGADO E
WHERE E.RG IN (SELECT RG_Supervisor FROM EMPREGADO);


-- 9. Selecione todos os empregados com salário maior ou igual a 2000,00.

SELECT * 
FROM EMPREGADO
WHERE Salario >= 2000;


-- 10. Selecione todos os empregados cujo nome começa com ‘J’.

SELECT * 
FROM EMPREGADO
WHERE Nome LIKE 'J%';


-- 11. Mostre todos os empregados que têm ‘Luiz’ ou ‘Luis’ no nome.

SELECT * 
FROM EMPREGADO
WHERE Nome LIKE '%Luiz%' OR Nome LIKE '%Luis%';


-- 12. Mostre todos os empregados do departamento de ‘Engenharia Civil’.

SELECT * 
FROM EMPREGADO
WHERE Depto = (SELECT Numero FROM DEPARTAMENTO WHERE Nome = 'Engenharia Civil');


-- 13. Mostre todos os nomes dos departamentos envolvidos
-- com o projeto ‘Motor 3’.

SELECT DISTINCT D.Nome
FROM DEPARTAMENTO D
JOIN DEPARTAMENTO_PROJETO DP ON D.Numero = DP.Numero_Depto
JOIN PROJETO P ON DP.Numero_Projeto = P.Numero
WHERE P.Nome = 'Motor 3';


-- 14. Liste o nome dos empregados envolvidos com o projeto ‘Financeiro 1’.

SELECT DISTINCT E.Nome
FROM EMPREGADO E
JOIN EMPREGADO_PROJETO EP ON E.RG = EP.RG_Empregado
JOIN PROJETO P ON EP.Numero_Projeto = P.Numero
WHERE P.Nome = 'Financeiro 1';


-- 15. Mostre os funcionários cujo supervisor ganha entre 2000 e 2500.

SELECT *
FROM EMPREGADO
WHERE RG_Supervisor IN (
    SELECT RG
    FROM EMPREGADO
    WHERE Salario BETWEEN 2000 AND 2500
);


-- 16. liste o nome dos gerentes que têm ao menos um dependente.

SELECT DISTINCT E.Nome
FROM EMPREGADO E
JOIN DEPARTAMENTO D ON E.RG = D.RG_Gerente
WHERE E.RG IN (SELECT RG_Responsavel FROM DEPENDENTES);


-- 17. Atualize o salário de todos os empregados que trabalham 
-- no departamento 2 para R$3.000,00.

UPDATE EMPREGADO
SET Salario = 3000
WHERE Depto = 2;


-- 18. Fazer um comando SQL para ajustar o salário 
-- de todos os funcionários da empresa em 10%.

UPDATE EMPREGADO
SET Salario = Salario * 1.10;


-- 19. Mostre a média salarial dos empregados da empresa.

SELECT AVG(Salario) AS Media_Salarial
FROM EMPREGADO;


-- 20. Mostre os nomes dos empregados (em ordem alfabética) 
-- com salário maior que a média.

SELECT Nome
FROM EMPREGADO
WHERE Salario > (SELECT AVG(Salario) FROM EMPREGADO)
ORDER BY Nome;
