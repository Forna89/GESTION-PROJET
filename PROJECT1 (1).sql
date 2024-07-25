CREATE DATABASE [GESTION_PROJET]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GESTION_PROJET', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.INSTANCE_01\MSSQL\DATA\GESTION_PROJET.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'GESTION_PROJET_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.INSTANCE_01\MSSQL\DATA\GESTION_PROJET_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [GESTION_PROJET] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [GESTION_PROJET] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET ARITHABORT OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [GESTION_PROJET] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GESTION_PROJET] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GESTION_PROJET] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GESTION_PROJET] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GESTION_PROJET] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GESTION_PROJET] SET  READ_WRITE 
GO
ALTER DATABASE [GESTION_PROJET] SET RECOVERY FULL 
GO
ALTER DATABASE [GESTION_PROJET] SET  MULTI_USER 
GO
ALTER DATABASE [GESTION_PROJET] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GESTION_PROJET] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [GESTION_PROJET] SET DELAYED_DURABILITY = DISABLED 
GO
USE [GESTION_PROJET]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [GESTION_PROJET]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [GESTION_PROJET] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO
CREATE TABLE Service
(
    Num_serv INT IDENTITY PRIMARY KEY,
    Nom_serv VARCHAR(50),
    Date_creation DATE,
    CONSTRAINT CK_Nom_serv CHECK (Nom_serv IN (
        'Reparation',
        'Formation',
        'Securite informatique',
        'Maintenance',
        'Recuperation de donnees',
        'Securite Informatique',
        'Decodage',
        'Accompagnement dans l achat d orinateur',
        'Copie et impression  de documents',
        'Vente de materiels'
    ))
);
INSERT INTO Service
VALUES
('Reparation','2024-03-12'),
('Formation','2024-03-12'),
('Securite informatique','2024-03-12'),
('Maintenance','2024-03-12'),
('Recuperation de donnees','2024-03-12'),
('Securite Informatique','2024-03-12'),
('Decodage','2024-03-12'),
('Accompagnement dans l achat d orinateur','2024-03-12'),
('Copie et impression  de documents','2024-03-12'),
('Vente de materiels','2024-03-12')
GO


CREATE TABLE Employe (
    Matricule INT IDENTITY PRIMARY KEY,
    Nom VARCHAR(50),
    Prenom VARCHAR(50), 
    DateNaissance DATE,
    Adresse VARCHAR(100),
    Salaire INT, 
    Grade VARCHAR(50), 
    Num_serv INT,
    CONSTRAINT CK_Employe_dateNaissance CHECK (DATEDIFF(YEAR, DateNaissance, GETDATE()) > 18),
    CONSTRAINT FK_Num_serv FOREIGN KEY (Num_serv) REFERENCES Service(Num_serv)
);
INSERT INTO Employe (Nom, Prenom, DateNaissance, Adresse, Salaire, Grade, Num_serv)
VALUES
    ('ElDupont', 'Jean', '1990-05-15', '123 Rue de la République', 2500, 'Ingénieur', 1),
    ('elDurand', 'Marie', '1985-07-20', '456 Avenue des Fleurs', 2800, 'Développeur', 2),
    ('elMartin', 'Sophie', '1992-11-10', '789 Boulevard des Champs', 2300, 'Technicien', 3),
    ('Dubois', 'Pierre', '1988-03-25', '101 Rue du Commerce', 2600, 'Analyste', 1),
    ('Elfebvre', 'Luc', '1991-09-05', '202 Avenue du Progrès', 2700, 'Chef de projet', 2),
    ('Moreau', 'Anna', '1987-12-12', '303 Boulevard des Arts', 2400, 'Développeur', 3),
    ('Elroy', 'Thomas', '1993-06-30', '404 Rue des Écoles', 2900, 'Ingénieur', 1),
    ('ElGarcia', 'Julie', '1984-04-18', '505 Avenue des Sports', 2700, 'Analyste', 2),
    ('ElRouf', 'Emma', '1990-08-22', '606 Boulevard des Sciences', 2600, 'Technicien', 3),
    ('Bonnet', 'Nicolas', '1986-02-08', '707 Rue des Technologies', 2800, 'Chef de projet', 1);
	GO

	

CREATE TABLE Projet (
    Num_proj INT IDENTITY PRIMARY KEY ,
    Nom_proj NVARCHAR(100) COLLATE FRENCH_CI_AS,
    Lieu VARCHAR(50),
    nbr_limite_taches INT, 
    Num_serv INT,
    CONSTRAINT FK_Num_serv_Projet FOREIGN KEY (Num_serv) REFERENCES Service(Num_serv)
);

INSERT INTO Projet 
VALUES
    ('Projet A', 'Salle 1', 5, 1),
    ('Projet B', 'Salle 2', 6, 2),
    ('Projet C', 'Salle 3', 7, 3),
    ('Projet D', 'Salle 4', 8, 1),
    ('Projet E', 'Salle 5', 9, 2),
    ('Projet F', 'Salle 6', 10, 3),
    ('Projet G', 'Salle 7', 11, 1),
    ('Projet H', 'Salle 8', 12, 2),
    ('Projet I', 'Salle 9', 13, 3),
    ('Projet J', 'Salle 10', 14, 1);


CREATE TABLE Tache (
    Num_tach INT PRIMARY KEY,
    Nom_tach VARCHAR(50),
    Date_debut DATE,
    Date_fin DATE,
    Cout INT,
    Num_proj INT,
    Dure INT,
    CONSTRAINT CK_Tache_duree CHECK (DATEDIFF(DAY, Date_debut, Date_fin) >= 3),
    CONSTRAINT CK_Tache_cout CHECK (DATEDIFF(DAY, Date_debut, Date_fin) * Cout >= 1000),
    CONSTRAINT FK_Num_proj_Tache FOREIGN KEY (Num_proj) REFERENCES Projet(Num_proj)
);
INSERT INTO Tache --(Num_tach, Nom_tach, Date_debut, Date_fin, Cout, Num_proj, Dure)
VALUES
    (11, 'tâche 1', '2024-04-01', '2024-03-05', 2000, 1, 70),
    (12, 'tâche 2', '2024-05-02', '2010-10-06', 1500, 2, 20),
    (13, 'tâche 3', '2024-7-03', '2024-12-07', 1800, 3, 17),
    (14, 'Tâche 4', '2024-03-04', '2025-03-08', 2200, 4, 69),
    (15, 'Tâche 5', '2024-03-05', '2024-05-09', 1700, 5, 60),
    (6, 'Tâche 6', '2024-08-06', '2027-02-10', 1900, 6, 8),
    (7, 'tâche 7', '2024-03-07', '2025-03-11', 2500, 7, 9),
    (8, 'Tâche 8', '2024-03-08', '2024-03-12', 2100, 8, 10),
    (9, 'Tâche 9', '2024-03-09', '2024-03-13', 2300, 9, 11),
    (10, 'tâche 10', '2024-03-10', '2024-03-14', 2400, 10, 12);

CREATE TABLE Travaille (
    Matricule INT,
    Num_tach INT,
    Nombre_heure DATE,
    CONSTRAINT FK_Matricule_Travaille FOREIGN KEY (Matricule) REFERENCES Employe(Matricule),
    CONSTRAINT FK_Num_tach_Travaille FOREIGN KEY (Num_tach) REFERENCES Tache (Num_tach)
);
INSERT INTO Travaille (Matricule, Num_tach, Nombre_heure)
VALUES
    (1, 1, '2024-03-01'),
    (2, 2, '2024-03-02'),
    (3, 3, '2024-03-03'),
    (4, 4, '2024-03-04'),
    (5, 5, '2024-03-05'),
    (6, 6, '2024-03-06'),
    (7, 7, '2024-03-07'),
    (8, 8, '2024-03-08'),
    (9, 9, '2024-03-09'),
    (10, 10, '2024-03-10');

	SELECT * FROM [Employe] WHERE
	NOM LIKE 'EL%' 
	AND NOT Nom LIKE 'El%[a-f]'
	ORDER BY DateNaissance

	SELECT UPPER(Nom_tach) AS Nom_tach
	FROM Tache 
	WHERE MONTH(Date_fin)=MONTH(GETDATE())
	SELECT * FROM Tache

	--Compter le nombre de grades différents de l’entreprise.
	SELECT COUNT(DISTINCT Grade) AS Nombre_de_grades_different
FROM Employe;
--Afficher les employés qui ont participé à un projet qui est affecté à un service différent où il travaille

SELECT DISTINCT e.*
FROM Employe e
INNER JOIN Travaille t ON e.Matricule = t.Matricule
INNER JOIN Tache ta ON t.Num_tach = ta.Num_tach
INNER JOIN Projet p ON ta.Num_proj = p.Num_proj
INNER JOIN Service s ON e.Num_serv <> p.Num_serv
--Les projets avec une tache de durée inférieur à 30 jours et une autre 
--supérieure à 60 jours Durée d’une tache=Date de findate de début
SELECT DISTINCT p.*
FROM Projet p
WHERE EXISTS (
    SELECT 1
    FROM Tache t
    WHERE t.Num_proj = p.Num_proj
    AND DATEDIFF(DAY, t.Date_debut, t.Date_fin) < 30
) AND EXISTS (
    SELECT 1
    FROM Tache t
    WHERE t.Num_proj = p.Num_proj
    AND DATEDIFF(DAY, t.Date_debut, t.Date_fin) > 60
);
--Afficher la masse horaire travaillée cette année 
--(travaille débuter et terminer cette année) 
--par projet. Masse horaire=somme (nombre_heure)
SELECT p.Num_proj, p.Nom_proj, DATEDIFF(HOUR, t.Date_debut, t.Date_fin) AS Masse_horaire_travaillee
FROM Projet p
JOIN Tache ta ON p.Num_proj = ta.Num_proj
JOIN Travaille tr ON ta.Num_tach = tr.Num_tach
JOIN Tache t ON tr.Num_tach = t.Num_tach
WHERE YEAR(t.Date_debut) = YEAR(GETDATE()) AND YEAR(t.Date_fin) = YEAR(GETDATE());
---------------
SELECT DISTINCT e.Matricule, e.Nom
FROM Employe e
WHERE e.Matricule IN (
    SELECT Matricule
    FROM Travaille
    GROUP BY Matricule
    HAVING COUNT(DISTINCT Num_tach) > 1
);


