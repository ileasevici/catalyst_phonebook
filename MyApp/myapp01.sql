--
-- Create a very simple database to hold book and author information
--
PRAGMA foreign_keys = ON;
CREATE TABLE phonebook (
        id    INTEGER PRIMARY KEY,
        first_name  TEXT(20),
        last_name   TEXT(30),
        phone VARCHAR(15)
);
---
--- Load some sample data
---
INSERT INTO phonebook VALUES (1, 'Victor', 'Ileasevici', 4526553461);
INSERT INTO phonebook VALUES (2, 'Victor', 'Ileasevici', 4526553462);
INSERT INTO phonebook VALUES (3, 'Victor', 'Ileasevici', 4526553463);
INSERT INTO phonebook VALUES (4, 'Victor', 'Ileasevici', 4526553464);
INSERT INTO phonebook VALUES (5, 'Victor', 'Ileasevici', 4526553465);