-- ORDEM DE CRIAÇÃO: DE CIMA PARA BAIXO

CREATE DATABASE "BankSQL";

  ↓ ↓ ↓

CREATE TABLE customers (id serial NOT NULL PRIMARY KEY, "fullName" text NOT NULL, cpf varchar(11) NOT NULL UNIQUE, email text NOT NULL UNIQUE, password text NOT NULL);

  ↓ ↓ ↓

CREATE TABLE "customerPhones" (id serial NOT NULL PRIMARY KEY, "customerId" integer REFERENCES customers(id), number integer NOT NULL, type PHONE_TYPE);

  ↓ ↓ ↓

CREATE TABLE states (id serial NOT NULL PRIMARY KEY, name text NOT NULL);

  ↓ ↓ ↓

CREATE TABLE cities (id serial NOT NULL PRIMARY KEY, name text NOT NULL, "stateId" integer REFERENCES states(id));
 
  ↓ ↓ ↓

CREATE TABLE "customerAddresses" (id serial NOT NULL PRIMARY KEY, "customerId" integer REFERENCES customers(id), street text NOT NULL, number integer NOT NULL, complement text, "postalCode" integer NOT NULL, "cityId" integer REFERENCES cities(id));

  ↓ ↓ ↓

CREATE TABLE "bankAccount" (id serial NOT NULL PRIMARY KEY, "customerId" integer REFERENCES customers(id), "accountNumber" integer NOT NULL, agency integer NOT NULL, "openDate" timestamp NOT NULL DEFAULT NOW(), "closeDate" timestamp DEFAULT NULL);

  ↓ ↓ ↓

CREATE TABLE transactions (id serial NOT NULL PRIMARY KEY, "bankAccountId" integer REFERENCES "bankAccount"(id), amount integer NOT NULL DEFAULT 0, type TRANSACTIONS_TYPE, time timestamp NOT NULL DEFAULT NOW(), description text, cancelled boolean NOT NULL DEFAULT false);

  ↓ ↓ ↓

CREATE TABLE "creditCards" (id serial NOT NULL PRIMARY KEY, "bankAccountId" integer REFERENCES "bankAccount"(id), name text NOT NULL, number integer NOT NULL, "securityCode" text NOT NULL, "expirationMounth" timestamp NOT NULL DEFAULT NOW() + interval '1 month', "expirationYear" timestamp NOT NULL DEFAULT NOW() + interval '1 year', password text NOT NULL, "limit" integer NOT NULL DEFAULT 0);
