-- Questão 1 
-- Utilizando uma query, obtenha a quantidade de experiências
-- (experiences) atuais, ou seja, com “endDate” diferente de NULL.
--
-- A resposta deve vir no formato:
-- |---currentExperiences---|
--             80
--            ...

-- RESPOSTA do questão 1

SELECT COUNT("endDate") AS "currentExperiences" 
	FROM experiences;

--
--
--

--
-- Questão 2 
-- Utilizando uma query, obtenha a quantidade de graduações
-- (educations) por usuário, incluindo o seu id.
--
-- A resposta deve vir no formato:
-- |---id---|---educations---|
--    110	     2
--    ...           ...

-- RESPOSTA da questão 2

SELECT "userId" AS id, COUNT("courseId") AS educations 
	FROM educations
GROUP BY "userId"
ORDER BY "userId";

--
--
--

--
-- Questão 3 
-- Utilizando uma query, obtenha a quantidade de depoimentos
-- (testimonials) que o usuário com id 435 efetuou, incluindo
-- o seu nome. 
--
-- A resposta deve vir no formato:
-- |---writer---|---testimonailCount---|
--     Jesus               3
--      ...               ...

-- RESPOSTA da questão 3

SELECT users.name AS writer, COUNT("writerId") AS testimonailCount
	FROM testimonials
	JOIN users 
		ON users.id = testimonials."writerId"
	WHERE "writerId" = 435
	GROUP BY "writerId", users.name;

--
--
--

--
-- Questão 4 
-- Utilizando uma query, obtenha o maior salário das vagas
-- (jobs) ativas (active = true) e o nome das posições (roles)
-- dessas vagas ordenadas de forma ascendente.
--
-- A resposta deve vir no formato:
-- |---maximumSalary---|-------------role--------------|
--        107981	   Junior Software Engineer
--          ...                       ...

-- RESPOSTA da questão 4

SELECT MAX(salary) AS "maximumSalary", roles.name AS role
	FROM jobs
	JOIN roles 
		ON roles.id = jobs."roleId"
	WHERE active IS true
	GROUP BY roles.name
	ORDER BY "maximumSalary";
	
--
--
--

--
-- Questão 5 - BONUS ! 
-- Utilizando uma query, obtenha os 3 cursos (courses) e escolas
-- (schools) com a maior quantidade de alunos (educations) que estão
-- cursando (status='ongoing' ) ou finalizaram (status='finished') 
--
-- A resposta deve vir no formato:
-- |--------------school--------------|-----course------|----studentsCount----|----role-----|
--        Universidad de Los Andes        Linguistics	           7	          ongoing
--                 ...                        ...                 ...               ...

-- RESPOSTA da questão 5 BONUS

SELECT schools.name AS school, courses.name AS course, COUNT(educations."courseId") AS "studentsCount", educations.status AS role
	FROM educations
	JOIN courses 
		ON educations."courseId" = courses.id
	JOIN schools
		ON educations."schoolId" = schools.id
	WHERE educations.status = 'ongoing' OR educations.status = 'finished'
	GROUP BY educations.status, schools.name, courses.name
	ORDER BY "studentsCount" DESC
	LIMIT 3;

--
--
--