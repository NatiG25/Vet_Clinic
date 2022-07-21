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

CREATE TABLE invoices (
	id	INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	total_amount DECIMAL,
	generated_at TIMESTAMP,
    payed_at VARCHAR(100),
    medical_history_id INT REFERENCES medical_histories(id)
);

CREATE TABLE invoice_items (
	id	INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    unit_price DECIMAL,
	quantity INT,
	total_price DECIMAL,
    invoice_id  INT REFERENCES invoices(id),
    treatment_id INT REFERENCES treatments(id)
);
