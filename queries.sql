SELECT * from animals WHERE name LIKE '%mon';
SELECT name from animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name from animals WHERE neutered AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * from animals WHERE neutered;
SELECT * from animals WHERE name <> 'Gabumon';
SELECT * from animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- TRANSACIONS
BEGIN;
UPDATE animals
SET species = 'unspecified'
ROLLBACK;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

COMMIT;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;

UPDATE animals
SET weight_kg = weight_kg * -1

ROLLBACK TO SP1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;

-- QUERIES
SELECT COUNT (*) FROM animals;

SELECT COUNT (*) FROM animals 
WHERE escape_attempts = 0;

SELECT AVG (weight_kg) FROM animals;

SELECT MAX(escape_attempts) FROM animals 
WHERE neutered OR NOT neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals 
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- USING JOIN
SELECT A.name, O.full_name FROM owners O JOIN animals A ON O.id = A.owner_id
WHERE full_name = 'Melody Pond';

SELECT A.name, S.name FROM species S JOIN animals A ON S.id = A.species_id
WHERE S.name = 'Pokemon';

SELECT O.full_name, A.name FROM owners O LEFT JOIN animals A ON O.id = A.owner_id;

SELECT COUNT (*), S.name FROM animals A JOIN species S ON A.species_id = S.id
GROUP BY S.name;

SELECT O.full_name, A.name FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE A.species_id = 2 AND O.id = 2;

SELECT O.full_name, A.name FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE A.escape_attempts = 0 AND O.id = 5;

SELECT O.full_name, COUNT(*) FROM animals A
JOIN owners O ON A.owner_id = O.id
GROUP BY O.full_name
ORDER BY COUNT(*)
DESC LIMIT 1;

-- MANY TO MANY 
SELECT V.name as Vet_name, A.name as Animal_name, I.date_of_visits FROM visits I 
JOIN animals A ON I.animals_id = A.id
JOIN vets V ON I.vets_id = V.id
WHERE V.name = 'William Tatcher'
ORDER BY I.date_of_visits
DESC
LIMIT 1;

SELECT V.name as Vet_name, COUNT(*)
FROM visits I 
JOIN animals A ON I.animals_id = A.id
JOIN vets V ON I.vets_id = V.id
WHERE V.name = 'Stephanie Mendez'
GROUP BY V.name;

SELECT V.name as Vet_name, P.name as specialty
FROM specializations S 
JOIN species P ON S.species_id = P.id
RIGHT JOIN vets V ON S.vets_id = V.id;

SELECT A.name as Animal_name FROM visits I 
JOIN animals A ON I.animals_id = A.id
JOIN vets V ON I.vets_id = V.id
WHERE V.id = 3 AND I.date_of_visits BETWEEN '2020-4-1' AND '2020-8-30';

SELECT A.name as Animal_name, COUNT(*) FROM visits I 
JOIN animals A ON I.animals_id = A.id
JOIN vets V ON I.vets_id = V.id
GROUP BY A.name
ORDER BY COUNT(*)
DESC
LIMIT 1;

SELECT V.name as Vet_name, A.name as Animal_name, I.date_of_visits 
FROM visits I 
JOIN animals A ON I.animals_id = A.id
JOIN vets V ON I.vets_id = V.id
WHERE V.id = 2
ORDER BY I.date_of_visits
LIMIT 1;

SELECT V.name as Vet_name, A.name as Animal_name, I.date_of_visits 
FROM visits I 
JOIN animals A ON I.animals_id = A.id
JOIN vets V ON I.vets_id = V.id
ORDER BY I.date_of_visits
LIMIT 1;

SELECT V.name as Vet_name, COUNT(*)
FROM visits I 
JOIN animals A ON I.animals_id = A.id
JOIN vets V ON I.vets_id = V.id
JOIN specializations S ON S.vets_id = V.id
WHERE A.species_id != S.species_id AND V.id != 3
GROUP BY V.name;

SELECT A.species_id, count(*)
FROM visits I 
JOIN animals A ON I.animals_id = A.id
JOIN vets V ON I.vets_id = V.id
WHERE V.id = 2
GROUP BY A.species_id
LIMIT 1;