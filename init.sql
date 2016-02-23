/*Build the users and user_roles tables and insert the test data*/

DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS users;
CREATE  TABLE users (
  userid int NOT NULL AUTO_INCREMENT,
  username VARCHAR(45) NOT NULL ,
  password VARCHAR(60) NOT NULL ,
  enabled TINYINT NOT NULL DEFAULT 1 ,
  email VARCHAR(50) NOT NULL, 
  createdate DATETIME NOT NULL, 
  PRIMARY KEY (userid), 
  UNIQUE KEY uni_username (username), 
  UNIQUE KEY uni_email (email));
   
CREATE TABLE user_roles (
  user_role_id int(11) NOT NULL AUTO_INCREMENT,
  userid int NOT NULL,
  role varchar(45) NOT NULL,
  PRIMARY KEY (user_role_id),
  UNIQUE KEY uni_username_role (role,userid),
  KEY fk_username_idx (userid),
  CONSTRAINT fk_username FOREIGN KEY (userid) REFERENCES users (userid));
 
INSERT INTO users(userid,username,password,enabled,email,createdate)
VALUES (1,'ian','$2a$10$gdSAHxDBK2tZZttYvUph3.qn.3HOxyrs0KsBCUgjuyoCeA86.yPwm', true,'ian@mtgfire.com','1970-01-01');
INSERT INTO users(userid,username,password,enabled,email,createdate)
VALUES (2,'marlene','$2a$10$t6vNtfvknDI2WQdztsmVLuy.jgVkMdCni.2YNZzfhE6flw3FNeyei', true,'marlene@mtgfire.com','1970-01-01');
 
INSERT INTO user_roles (userid, role)
VALUES ('2', 'ROLE_USER');
INSERT INTO user_roles (userid, role)
VALUES ('1', 'ROLE_ADMIN');
INSERT INTO user_roles (userid, role)
VALUES ('1', 'ROLE_USER');


/*Build the cards and sets tables*/

DROP TABLE IF EXISTS cards; 
DROP TABLE IF EXISTS sets;

CREATE TABLE sets (
	id int NOT NULL AUTO_INCREMENT,
	name varchar(100) NOT NULL, 
	mciCode varchar(10) NOT NULL, 
	releaseDate DATE, 
	PRIMARY KEY (id)
);

CREATE TABLE cards (
	id varchar(50) NOT NULL, 
	mciNumber varchar(10) NOT NULL,
	imageName varchar(50) NOT NULL, 
	setCode int NOT NULL, 
	name varchar(50) NOT NULL, 
	text varchar(1000), 
	flavorText varchar(500), 
	color varchar(100), 
	convertedManaCost int DEFAULT 0, 
	manaCost varchar(100), 
	power varchar(10) DEFAULT '0', 
	toughness varchar(10) DEFAULT '0', 
	typeText varchar(50),
	types varchar(50), 
	subtypes varchar(50), 
	rarity varchar(50), 
	PRIMARY KEY (id), 
	KEY fk_setCode_idx (setCode), 
	CONSTRAINT fk_setCode FOREIGN KEY (setCode) REFERENCES sets (id)
); 

DROP TABLE IF EXISTS card_ratings; 
CREATE TABLE card_ratings (
	id int NOT NULL AUTO_INCREMENT, 
    username varchar(45) NOT NULL, 
    card_id varchar(50) NOT NULL, 
    value int NOT NULL, 
    PRIMARY KEY (id), 
    UNIQUE KEY uq_cr_userCard (username, card_id), 
    CONSTRAINT fk_cr_cardId FOREIGN KEY (card_id) REFERENCES cards (id), 
    CONSTRAINT fk_cr_username FOREIGN KEY (username) REFERENCES users (username)
); 

/*Create the comment tables*/
DROP TABLE IF EXISTS card_comments; 
CREATE TABLE card_comments (
	id int NOT NULL AUTO_INCREMENT, 
    poster int NOT NULL, 
    postdate DATETIME NOT NULL, 
    card_id varchar(50) NOT NULL, 
    body varchar(500) NOT NULL, 
    PRIMARY KEY (id), 
    CONSTRAINT fk_cardId FOREIGN KEY (card_id) REFERENCES cards (id), 
    CONSTRAINT fk_poster FOREIGN KEY (poster) REFERENCES users (userid)
); 