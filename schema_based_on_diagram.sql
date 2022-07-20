CREATE DATABASE clinic;

CREATE TABLE patients (
	id	INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(100),
	date_of_birth INT
);

CREATE TABLE medical_histories (
	id	INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	admitted_at timestamp,
	patient_id INT REFERENCES patients(id),
    status VARCHAR(100)
);

CREATE TABLE treatments (
	id	INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(100),
	type VARCHAR(100)
);
