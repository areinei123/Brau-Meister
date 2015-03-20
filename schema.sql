DROP TABLE recipes IF EXISTS; #variable

CREATE TABLE  recipes
(
  recipe_name varchar (100),
  grain_id integer REFERENCES grains(id),
  hop_id integer REFERENCES hops(id),
  yeast_id integer REFERENCES yeast(id)
);

CREATE TABLE grains
(
  grain_name varchar (255),
  grain_weight float,
  id SERIAL primary key
);

CREATE TABLE hops
(
  hop_name varchar (255),
  hop_weight varchar (255)
  id SERIAL primary key
);

CREATE TABLE yeast
(
  yeast_name varchar
  id SERIAL primary key
);

CREATE TABLE instructions
(
  step text
);
