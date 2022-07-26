-- Questão 1 
-- Utilizando uma query, obtenha todos os usuários (users) que vivem na 
-- cidade (cities) cujo nome seja "Rio de janeiro"
--
-- A resposta deve vir no formato:
-- |--id--|--name--|------city------|
--    1      juca    Rio de Janeiro
--   ...     ...    	  ...

-- RESPOSTA do questão 1

SELECT users.id, users.name, cities.name AS city 
FROM users 
	JOIN cities ON users."cityId" = cities.id 
WHERE cities.name = 'Rio de Janeiro'
ORDER BY id ASC;

--
--
--

--
-- Questão 2 
-- Utilizando umas query, obtenha todos os depoimentos (testimonials) 
-- cadastrados, incluindo o nome do remetente e do destinatário.
--
-- A resposta deve vir no formato:
-- |---id---|---writer---|---recipient---|-------message-------|
--     1        João           Maria        Foi ótimo Maria...
--   ...        ...            ...                 ...

-- RESPOSTA da questão 2

SELECT testimonials.id, u1.name as writer, u2.name as recipient, testimonials.message
FROM testimonials 
    JOIN users as u1 ON testimonials."writerId" = u1.id 
    JOIN users as u2 ON testimonials."recipientId" = u2.id 
ORDER BY id ASC;

--
--
--

--
-- Questão 3 
-- Utilizando uma query, obtenha todos os cursos (courses) que o
-- usuário com id 30 já finalizou, incluindo o nome da escola. 
-- O que indica que um usuário terminou um curso é o campo status
-- da tabela educations, que deve estar como "finished".
--
-- A resposta deve vir no formato:
-- |---id---|---name---|---course---|----school----|---endDate---|
--     30       João      HTML/CSS       Driven       2021-12-0
--     ...       ...         ...           ...           ...

-- RESPOSTA da questão 3

SELECT users.id, users.name, courses.name AS course, schools.name AS school, educations."endDate"
FROM users
	JOIN educations ON educations."userId" = users.id
	JOIN courses ON educations."courseId" = courses.id
	JOIN schools ON educations."schoolId" = schools.id
WHERE users.id = 30 AND educations.status = 'finished'
ORDER BY users.id ASC, "endDate" ASC;

--
--
--

--
-- Questão 4 
-- Utilizando uma query, obtenha as empresas (companies) para as 
-- quais o usuário com id 50 trabalha atualmente. Para filtrar
-- quem trabalha atualmente, utilize o campo endDate da tabela
-- experiences. Se ele estiver null (IS NULL), significa que a
-- pessoa ainda não encerrou a experiência dela na empresa, ou
-- seja, está trabalhando lá.
--
-- A resposta deve vir no formato:
-- |---id---|---name---|--------role--------|----company----|---startDate---|
--     50       João     Software Engineer         OLX          2020-06-01
--    ...       ...             ...                ...             ...

-- RESPOSTA da questão 4

SELECT users.id, users.name, roles.name AS role, companies.name AS company, experiences."startDate"
FROM experiences
	JOIN users ON experiences."userId" = users.id
	JOIN roles ON experiences."roleId" = roles.id
	JOIN companies ON experiences."companyId" = companies.id
WHERE users.id = 50 AND experiences."endDate" IS NULL
ORDER BY users.id ASC, "startDate" ASC;

--
--
--

--
-- Questão 5 - BONUS ! 
-- Utilizando uma query, obtenha a lista das diferentes escolas
-- (schools) e cursos (courses) onde estudaram as pessoas que
-- estão aplicando pra posição de “Software Engineer” na empresa
-- com id 10. Só devem ser consideradas as vagas que estiverem
-- ativas, ou seja, quando o campo active da tabela jobs estiver true.
--
-- A resposta deve vir no formato:
-- |---id---|---school---|--------course--------|----company----|--------role-------|
--      1       Driven       Software Engineer        OLX         Software Engineer
--     ...       ...               ...                 ...               ...

-- RESPOSTA da questão 5 BONUS

SELECT schools.id, schools.name, courses.name, companies.name, roles.name
FROM applicants
	JOIN jobs ON applicants."jobId" = jobs.id --me da role e company
	JOIN users ON applicants."userId" = users.id
	JOIN educations ON users.id = educations."userId" -- me da school e course
	JOIN schools ON educations."schoolId" = schools.id
	JOIN courses ON educations."courseId" = courses.id
	JOIN companies ON jobs."companyId" = companies.id
	JOIN roles ON jobs."roleId" = roles.id
WHERE jobs.active IS TRUE AND roles.name = 'Software Engineer'
ORDER BY schools.id ASC;

--
--
--