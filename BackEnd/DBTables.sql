use Covid_Stats;
DROP TABLE IF EXISTS Deaths;
DROP TABLE IF EXISTS Cases;
DROP TABLE IF EXISTS Recoveries;
DROP TABLE IF EXISTS Counties;

CREATE TABLE Counties
(
	id INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(60),
	PRIMARY KEY (id)
);
CREATE TABLE Deaths
(
	Date VARCHAR(20) NOT NULL,
	CountyID 	INT NOT NULL,
	Count		INT,
	CONSTRAINT PK_Deaths PRIMARY KEY (Date, CountyID),
	CONSTRAINT FK_Deaths_Counties FOREIGN KEY (CountyID) REFERENCES Counties(id)
);
CREATE TABLE Cases
(
		Date VARCHAR(20) NOT NULL,
		CountyID 	INT NOT NULL,
		Count		INT,
		CONSTRAINT PK_Cases PRIMARY KEY (Date, CountyID),
		CONSTRAINT FK_Cases_Counties FOREIGN KEY (CountyID) REFERENCES Counties(id)
);
CREATE TABLE Recoveries
(
	Date VARCHAR(20) NOT NULL,
	CountyID 	INT NOT NULL,
	Count		INT,
	CONSTRAINT PK_Recoveries PRIMARY KEY (Date, CountyID),
	CONSTRAINT FK_Recoveries_Counties FOREIGN KEY (CountyID) REFERENCES Counties(id)
);
