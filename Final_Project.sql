INSERT INTO person (first_name, last_name)
VALUES ('Derek', 'Bomboy');

ALTER TABLE person
ADD middle_initial varchar(1);

UPDATE person SET middle_initial = 'F' WHERE person_id = 1;
UPDATE person SET middle_initial = 'G' WHERE person_id = 2;
UPDATE person SET middle_initial = 'S' WHERE person_id = 3;
UPDATE person SET middle_initial = 'M' WHERE person_id = 4;
UPDATE person SET middle_initial = 'W' WHERE person_id = 5;
UPDATE person SET middle_initial = 'L' WHERE person_id = 6;
UPDATE person SET middle_initial = 'J' WHERE person_id = 7;

DELETE FROM person WHERE first_name = 'Diana' AND last_name = 'Taurasi';

ALTER TABLE contact_list
ADD favorite varchar(10);

UPDATE contact_list SET favorite =  'y' WHERE person_id = 1;

UPDATE contact_list SET favorite = 'n' WHERE person_id <> 1;

INSERT INTO contact_list (person_id, contact_id, favorite)
VALUES (1, 7, 'y');
INSERT INTO contact_list (person_id, contact_id, favorite
VALUES (7, 3, 'y');
INSERT INTO contact_list (person_id, contact_id, favorite)
VALUES (4, 7, 'y');
                          
CREATE TABLE image(
	image_id INT(8) NOT NULL auto_increment,
	image_name VARCHAR(50) NOT NULL,
	image_location VARCHAR(250) NOT NULL,
	PRIMARY KEY (image_id)
)AUTO_INCREMENT = 1;     
                          
CREATE TABLE message_image(
	message_id INT(8) NOT NULL,
	image_id INT(8) NOT NULL,
	PRIMARY KEY(message_id, image_id),
	FOREIGN KEY(message_id) REFERENCES message(message_id),
	FOREIGN KEY(image_id) REFERENCES image(image_id)
); 
                          
INSERT INTO image(image_name, image_location) VALUES ('img1.jpg', 'Olympics');
INSERT INTO image(image_name, image_location) VALUES ('img2.jpg', 'Manitowoc County, Wisconsin');
INSERT INTO image(image_name, image_location) VALUES ('img3.jpg', 'Park Place');
INSERT INTO image(image_name, image_location) VALUES ('img4.jpg', 'Tatooine');
INSERT INTO image(image_name, image_location) VALUES ('img5.jpg', 'Atlantis');                          

                          
INSERT INTO message_image (message_id, image_id) VALUES (1, 1);
INSERT INTO message_image (message_id, image_id) VALUES (1, 5);
INSERT INTO message_image (message_id, image_id) VALUES (3, 4);
INSERT INTO message_image (message_id, image_id) VALUES (2, 3);
INSERT INTO message_image (message_id, image_id) VALUES (4, 2);
                          
SELECT 
message.message_id AS id, person.first_name AS sender_first_name, person.last_name AS sender_lastname, 
(SELECT person.first_name FROM message INNER JOIN person ON receiver_id = person.person_id WHERE message.message_id = id) AS receiver_first_name,
(SELECT person.last_name FROM message INNER JOIN person ON receiver_id = person.person_id WHERE message.message_id = id) AS receiver_last_name,
message.message, message.send_datetime 
FROM message
INNER JOIN person
ON sender_id = person.person_id
WHERE person.first_name = 'Michael' AND person.last_name = 'Phelps'; 
                          
SELECT COUNT(message_id), sender_id, person.first_name, person.last_name FROM message
RIGHT JOIN person
ON sender_id = person.person_id
WHERE sender_id >=1
GROUP BY sender_id;
                          
SELECT message.message_id, message.message, message.send_datetime, image.image_name, 
image.image_location FROM message
INNER JOIN message_image
ON message.message_id = message_image.message_id
INNER JOIN image
ON message_image.image_id = image.image_id
GROUP BY message_id;                        