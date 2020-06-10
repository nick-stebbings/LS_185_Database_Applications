CREATE TABLE expenses(
  PRIMARY KEY (id),
        id SERIAL,
    amount DECIMAL(6,2) NOT NULL,
      memo TEXT         NOT NULL,
created_on DATE         NOT NULL
);