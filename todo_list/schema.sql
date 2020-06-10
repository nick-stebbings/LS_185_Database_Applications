CREATE TABLE lists(
  PRIMARY KEY(id),
  id SERIAL,
  name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE todos(
  PRIMARY KEY(id),
  id SERIAL,
  name VARCHAR(50) NOT NULL,
  completed BOOLEAN NOT NULL DEFAULT false,
  list_id INT NOT NULL REFERENCES lists(id)
);