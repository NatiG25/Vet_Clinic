CREATE TABLE animals (
	id	INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	date_of_birth date,
	escape_attempts INT,
	neutered BOOLEAN,
	weight_kg DECIMAL,
	PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species VARCHAR(100);

CREATE TABLE owners (
	id	INT GENERATED ALWAYS AS IDENTITY,
	full_name VARCHAR(100),
	age INT,
	PRIMARY KEY(id)
);

CREATE TABLE species (
	id	INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	PRIMARY KEY(id)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);

CREATE TABLE vets (
	id	INT GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100),
	age INT,
	date_of_graduation date,
	PRIMARY KEY(id)
);

CREATE TABLE specializations (
	id	INT GENERATED ALWAYS AS IDENTITY,
	species_id INT,
	vets_id INT,
	PRIMARY KEY(id)
);

ALTER TABLE specializations ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE specializations ADD FOREIGN KEY (vets_id) REFERENCES vets(id);

CREATE TABLE visits (
	id	INT GENERATED ALWAYS AS IDENTITY,
	animals_id INT,
	vets_id INT,
	PRIMARY KEY(id)
);

ALTER TABLE visits ADD FOREIGN KEY (animals_id) REFERENCES animals(id);
ALTER TABLE visits ADD FOREIGN KEY (vets_id) REFERENCES vets(id);