-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = "alumno" ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
-- 2. Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" AND telefono IS NULL;
-- 3. Retorna el llistat dels alumnes que van néixer en 1999.
SELECT * FROM persona WHERE tipo = "alumno" AND fecha_nacimiento LIKE "1999%";
-- 4. Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT * FROM persona WHERE tipo = "profesor" AND telefono IS NULL AND nif LIKE "%K";
-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT apellido1, apellido2, persona.nombre, departamento.nombre AS departamento FROM persona JOIN profesor ON profesor.id_profesor = persona.id JOIN departamento ON departamento.id = profesor.id_departamento ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;  
-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM asignatura JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id JOIN persona ON alumno_se_matricula_asignatura.id_alumno = persona.id WHERE persona.nif = "26902806M";
-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT departamento.nombre FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor JOIN grado ON asignatura.id_grado = grado.id WHERE grado.nombre = "Grado en Ingeniería Informática (Plan 2015)";
-- 9. Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT persona.nombre FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE curso_escolar.anyo_inicio = 2018; 

/* Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN. */
-- 1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT departamento.nombre AS departamento, persona.apellido1, persona.apellido2, persona.nombre FROM departamento RIGHT JOIN  profesor ON departamento.id = profesor.id_departamento RIGHT JOIN persona ON profesor.id_profesor = persona.id  WHERE persona.tipo = "profesor" ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;
-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT departamento.nombre AS departamento, persona.apellido1, persona.apellido2, persona.nombre FROM departamento RIGHT JOIN  profesor ON departamento.id = profesor.id_departamento RIGHT JOIN persona ON profesor.id_profesor = persona.id  WHERE persona.tipo = "profesor" AND departamento.nombre IS NULL ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;
-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT departamento.nombre AS departamento, persona.apellido1, persona.apellido2, persona.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN persona ON profesor.id_profesor = persona.id WHERE persona.nombre IS NULL ORDER BY departamento.nombre ASC, persona.apellido1 ASC, persona.apellido2 ASC, persona.nombre ASC;
-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT persona.apellido1, persona.apellido2, persona.nombre, asignatura.nombre AS asignatura FROM asignatura RIGHT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor RIGHT JOIN persona ON profesor.id_profesor = persona.id WHERE persona.tipo = "profesor" AND asignatura.nombre IS NULL;
-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT persona.apellido1, persona.apellido2, persona.nombre, asignatura.nombre AS asignatura FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor LEFT JOIN persona ON profesor.id_profesor = persona.id WHERE asignatura.id_profesor IS NULL;  
-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;

/* Consultes resum */
-- 1. Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(nombre) AS Total_Alumnos FROM persona WHERE tipo = "alumno"; 
-- 2. Calcula quants alumnes van néixer en 1999.
SELECT COUNT(nombre) AS Total_Alumnos FROM persona WHERE tipo = "alumno" AND fecha_nacimiento LIKE "1999%"; 
-- 3. Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT departamento.nombre, COUNT(profesor.id_profesor) AS Número_profesores FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY Número_profesores DESC; 
-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT departamento.nombre, COUNT(profesor.id_profesor) AS Número_profesores FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre ORDER BY Número_profesores DESC; 
-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT grado.nombre, COUNT(asignatura.nombre) AS Número_asignaturas FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY Número_asignaturas DESC; 
-- 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT grado.nombre, COUNT(asignatura.nombre) AS Número_asignaturas FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING Número_asignaturas > 40 ORDER BY Número_asignaturas DESC; 
-- 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT grado.nombre, asignatura.tipo, SUM(asignatura.creditos) AS Créditos FROM asignatura JOIN grado ON grado.id = asignatura.id_grado GROUP BY grado.nombre, asignatura.tipo;
-- 8. Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT curso_escolar.anyo_inicio, COUNT(alumno_se_matricula_asignatura.id_alumno) AS Alumnos FROM curso_escolar LEFT JOIN alumno_se_matricula_asignatura ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar GROUP BY curso_escolar.anyo_inicio;
-- 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT profesor.id_profesor, persona.nombre, persona.apellido1, persona.apellido2, COUNT(asignatura.id_profesor) AS Número_asignaturas FROM profesor LEFT JOIN persona ON profesor.id_profesor = persona.id LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor GROUP BY profesor.id_profesor;
-- 10. Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona WHERE tipo = "alumno" AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona);
-- 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT DISTINCT persona.nombre, persona.apellido1, persona.apellido2 FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL AND persona.tipo = "profesor";
