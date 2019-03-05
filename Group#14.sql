CREATE DATABASE Snow_Gallery;

--Tables's Creation--

--Engy Samir 139394--
CREATE TABLE Client
(
C_ID int IDENTITY,
C_Fname varchar(20) NOT NULL,
C_Midname varchar(20) ,
C_Lname varchar(20) NOT NULL,
C_num varchar(20) NOT NULL,
C_mail varchar(40) ,
C_address varchar(40),

CONSTRAINT Client_pk PRIMARY KEY (C_ID),
CONSTRAINT unique_num UNIQUE (C_num)
);

CREATE TABLE Receipt
(
R_code int NOT NULL,
R_time time,
R_date date,
Num_of_paintings int,
tax int,
total int,
paid int,
change int,
CID int,

CONSTRAINT Receipt_pk PRIMARY KEY (R_code),
CONSTRAINT recieved_by FOREIGN KEY (CID) REFERENCES Client (C_ID),
CONSTRAINT unique_foreignKey UNIQUE (CID)
);

--Meran Sharawy 148358--
create table Artist  
(
Fname varchar (20) not null,
Midname varchar (20) not null,
Lname varchar (20) not null,
Anum int not null,
DateOfBirth date,
Biography varchar (100),
Nationality varchar (20),
NumOfPainting int,
TypeOfArts varchar (20),

CONSTRAINT Artist_pk PRIMARY KEY (Lname)
);

create table Painting 
(
Ptitle varchar (20) not null,
Pprice int not null,
Pgenre varchar (20),
YearOfDrawing int,
Aname varchar (20),
Client_ID int,

CONSTRAINT Painting_pk PRIMARY KEY (Ptitle),
CONSTRAINT Painted_by FOREIGN KEY (Aname) REFERENCES Artist (Lname),
CONSTRAINT Sold_to FOREIGN KEY (Client_ID) REFERENCES Client (C_ID)
);

--Gloria Ezzat 150753--
CREATE TABLE Show
(
Sh_code int NOT NULL,
Sh_theme varchar(20),
Sh_name varchar(20),
Sh_date date NOT NULL,
Sh_time time NOT NULL,
Sh_location varchar(30),
Aname varchar(20),

CONSTRAINT Show_PK PRIMARY KEY (Sh_code),
CONSTRAINT Unique_name UNIQUE (Sh_name),
CONSTRAINT Presented_by FOREIGN KEY (Aname) REFERENCES Artist (Lname)
);

CREATE TABLE Sponsor
(
Sp_ID int NOT NULL,
Sp_name varchar(30) NOT NULL,
Sp_mail varchar(30) NOT NULL,
Sp_company varchar(20) NOT NULL,
Sp_num varchar(14),

CONSTRAINT Sponsor_PK PRIMARY KEY (Sp_ID),
CONSTRAINT Unique_number UNIQUE (Sp_mail)
);

CREATE TABLE Sponsored_by
(
Spon_ID int NOT NULL,
Show_code int NOT NULL,
Cost int,

CONSTRAINT Sponsored_by_PK PRIMARY KEY (Spon_ID, Show_code),
CONSTRAINT Show_Sponsored_by FOREIGN KEY (Show_code) REFERENCES Show(Sh_code),
CONSTRAINT Sponsor_sponsors FOREIGN KEY (Spon_ID) REFERENCES Sponsor (Sp_ID)
);

--Lorina Medhat 139974--
CREATE TABLE Exhibition
(
E_title  VARCHAR(20) NOT NULL,
Nun_of_paintings int,
E_street VARCHAR(40),
E_building INT,
E_city VARCHAR(20),

CONSTRAINT Exhibition_PK PRIMARY KEY(E_title)
);

CREATE TABLE Exhibited_in
(
Paint_title VARCHAR(20) NOT NULL,
Ex_title  VARCHAR(20) NOT NULL,
Start_date date,
End_date date,

CONSTRAINT exhibited_in_PK PRIMARY KEY (Paint_title,Ex_title),
CONSTRAINT exhibited_in_FK FOREIGN KEY (Ex_title) REFERENCES Exhibition (E_title),
CONSTRAINT exhibits FOREIGN KEY (Paint_title) REFERENCES Painting (Ptitle)
);

CREATE TABLE ReceiptAuditing
(
R_code int NOT NULL,
R_time time,
R_date date,
Num_of_paintings int,
tax int,
total int,
paid int,
change int,
CID int,
Audit_msg VARCHAR(50),
Audit_date Date
);

--Triggers' Creation--

CREATE TRIGGER ReceiptTrig
ON Receipt 
FOR INSERT
AS
declare @R_code int
declare @R_time time
declare @pR_date date
declare @Num_of_paintings int
declare @tax int
declare @total int
declare @paid int
declare @change int
declare @CID int
declare @paudit VARCHAR(50);
select @R_code = i.R_code from inserted i;
select @R_time = i.R_time from inserted i;
select @pR_date = i.R_date from inserted i;
select @Num_of_paintings = i.Num_of_paintings from inserted i;
select @tax = i.tax from inserted i;
select @total = i.total from inserted i;
select @paid = i.paid from inserted i;
select @change = i.change from inserted i;
select @CID = i.CID from inserted i;
select @paudit = 'Insert trigger executed';
INSERT INTO ReceiptAuditing
VALUES ('4444','5:30', '6/2/2016', '2','150', '200', '200','0','10','Message',getdate());
PRINT 'Trigger successfully executed'
GO

CREATE TRIGGER Trigg
on Client
after update , insert
as
begin
print 'Hello world from my trigger'
end
go
Select * 
from Client
update Client
set C_mail= 'engyelshaer@hotmail.com'
where C_Fname ='Engy';

--Views' Creation--

CREATE VIEW [Number of Paintings for an artist] AS
SELECT Count(Ptitle) as 'Number of paintings'
FROM Painting,Artist
WHERE Aname=Lname
group by Lname;

CREATE VIEW [Shows on 10/10/2016] AS
SELECT DISTINCT Sum(Sh_code) AS 'Total of shows on 10/10/2016'
FROM Show
where Sh_date='10/10/2016';

--Stored Procedures' Creation--

USE Snow_Gallery;  
GO  
CREATE PROCEDURE .ShowData
    @ShowName nvarchar(50),   
    @ShowTheme nvarchar(50)   
AS   

    SET NOCOUNT ON;  
    SELECT Sh_name,Sh_theme  
    FROM Show
    WHERE Sh_name = @ShowName AND Sh_theme = @ShowTheme 
    AND Sh_date IS NULL;  
GO  

Create Procedure p_client
As
SET nocount on
Select * 
From Client
execute p_client

Create proc proce
@var varchar (50)
As
Set nocount on
Select *
From Client
Where C_Fname= @var
exec proce @var ='Ahmed'

--Tables' Insertion--

--Engy Samir 139394--
INSERT INTO Client VALUES ('Engy','Samir','Elshaer','01273539889','engysamir@hotmail.com','Cairo');
INSERT INTO Client VALUES ('Gloria','Ezzat', 'Salib','01245681212','gloriaezzat@hotmail.com','Giza');
INSERT INTO Client VALUES ('Lorina','Medhat','Mekhael','01267890908','lorinamedhat@hotmail.com','Giza');
INSERT INTO Client VALUES ('Meran','Sharawy', 'Noman','01289888985','meransharawy@hotmail.com','Alexandria');
INSERT INTO Client VALUES ('Mina','Sameh', 'Ghobrial','01297650988','minasameh@hotmail.com','Cairo');
INSERT INTO Client VALUES ('Wafaa','Emad', 'Alaa','01123408765','wafaaemad@hotmail.com','Cairo');
INSERT INTO Client VALUES ('Nada','Emad','Gouda','012457898768','nadaemad@hotmail.com','Alexandria');
INSERT INTO Client VALUES ('David','Samy','Zakaria','01278903456','davidsamy@hotmail.com','Cairo');
INSERT INTO Client VALUES ('Anas','Mohamed','Younis','01266890356','anasmohamed@hotmail.com','Giza');
INSERT INTO Client VALUES ('Ahmed','','Ismail','01187820999','ahmedismail@hotmail.com','Cairo');

INSERT INTO Receipt VALUES ('123','1:00', '1/3/2016', '3','100', '200', '300','100','1');
INSERT INTO Receipt VALUES ('456','3:00', '2/6/2016', '5','150', '500', '600','100','2');
INSERT INTO Receipt VALUES ('789','8:00', '4/1/2016', '1','50', '100', '200','100','3');
INSERT INTO Receipt VALUES ('1000','6:30', '4/1/2016', '4','120', '300', '200','100','4');
INSERT INTO Receipt VALUES ('9000','6:30', '4/1/2016', '4','120', '300', '200','100','5');
INSERT INTO Receipt VALUES ('2000','7:30', '5/1/2016', '6','170', '400', '200','200','6');
INSERT INTO Receipt VALUES ('3000','2:30', '4/1/2016', '1','120', '100', '200','100','7');
INSERT INTO Receipt VALUES ('4000','5:30', '5/8/2016', '1','120', '100', '100','0','8');
INSERT INTO Receipt VALUES ('1111','5:30', '4/1/2016', '1','120', '100', '100','0','9');
INSERT INTO Receipt VALUES ('4444','5:30', '6/2/2016', '2','150', '200', '200','0','10');

--Meran Sharawy 148358--
insert into Artist values ('Ahmed','Mohammed','Mustafa','01011940095', '2/10/1990','Born in 1990 in Egypt famed with a free-flowing psychological-themed style','French','12','Psychological-themed');
insert into Artist values ('Mohammed','Ahmed','Elshaer','01011941595', '5/10/1991','Born in 1991 in Egypt, famed with his animaion arts','Egyptian','15','Animation');
insert into Artist values ('Ahmed','Omar','ELmonhands','01011456995', '11/5/1995','Born in 1995 in Egypt, famed with world war painting','American','6','World war paintings');
insert into Artist values ('Lili','Sameh','Hanna','01111446995', '1/8/1989','Born in 1989 in Egypt, famed with nature paintings','Italian','9','Nature paintings');
insert into Artist values ('Andrew','Hanna','Turner','01118776995', '4/7/1988','Born in 1988 in Egypt, famed with portrait paintings','Egyptian','21','Portrait');
insert into Artist values ('Hanan','Ahmed','Elsharkawy','01219876995', '5/7/1995','Born in 1995 in Egypt, famed with portrait paintings','Egyptian','12','Portrait');
insert into Artist values ('Mariam','Mustafa','Elgabry','01119976994', '7/7/1991','Born in 1991 in Egypt, famed with nature paintings','French','7','Nature paintings');
insert into Artist values ('Ann','Hanna','Sameh','01119979874', '7/4/1990','Born in 1990 in Egypt, famed with nature paintings','Egyptian','8','Nature paintings');
insert into Artist values ('Mohammed','Tarek','Elbanhawy','01219776995', '4/7/1988','Born in 1988 in Egypt, famed with Futurism paintings','Italian','6','Futurism');
insert into Artist values ('Mahmoud','Mohamed','Shawky','01219771478', '1/7/1990','Born in 1990 in Egypt, famed with pop art','American','19','Pop art');

insert into painting values ('Night','480','oil painting','1998','Elgabry','1');
insert into painting values ('Self portrait','700','waxy colors','1997','Shawky','2');
insert into painting values ('Friday afternoon','500','oil painting','2006','Elgabry','2');
insert into painting values ('Happy','450','oil painting','2001','Shawky','4');
insert into painting values ('Struggle','750','pencil drawing','2006','Elgabry','5')
insert into painting values ('Grandma and grandba','500','oil painting','2003','Elshaer','6');
insert into painting values ('WorldwarII','670','pencil drawing','2006','Shawky','5');
insert into painting values ('Flower','550','oil painting','2004','Hanna','5');
insert into painting values ('Woman','450','pencil drawing','2003','Elgabry','9');
insert into painting values ('Future','650','waxy colors','2006','Elgabry','1');

--Gloria Ezzat 150753--
INSERT INTO Show Values('10101','describing','the wind','4/10/2016','2pm','lobby','Turner');
INSERT INTO Show Values('10102','describing','the winter','10/10/2016','2pm','lobby','Hanna');
INSERT INTO Show Values('10103','presenting','the summer','4/10/2016','5pm','green area','Elshaer');
INSERT INTO Show Values('10104','signature festival','snowy','2/8/2016','8pm','first floor','Turner');
INSERT INTO Show Values('10105','signature festival','blue shadow','3/8/2016','10am','ground floor','Elshaer');
INSERT INTO Show Values('10106','signature festival','fruity','4/10/2016','6pm','green area','ELmonhands');
INSERT INTO Show Values('10107','presenting','sunny','4/10/2016','4pm','first floor','Shawky');
INSERT INTO Show Values('10108','describing','windy','4/10/2016','2pm','lobby','ELmonhands');
INSERT INTO Show Values('10109','describing','sunset','6/10/2016','5pm','lobby','Elgabry');
INSERT INTO Show Values('10110','describing','sunrise','8/12/2016','9pm','lobby','Elshaer');

INSERT INTO Sponsor Values('10050','Naguib','naguib.e@hotmail.com','orange','01200066688');
INSERT INTO Sponsor Values('10051','Mina','mina.e@hotmail.com','vodafone','01202166688');
INSERT INTO Sponsor Values('10052','Engy','engy.e@hotmail.com','orange','01200069688');
INSERT INTO Sponsor Values('10053','Lorina','lorina.e@hotmail.com','etisalat','01100066688');
INSERT INTO Sponsor Values('10054','Meran','meran.e@hotmail.com','orascom','01200866688');
INSERT INTO Sponsor Values('10055','Mostafa','mostafa.e@hotmail.com','ccc','01200566688');
INSERT INTO Sponsor Values('10056','Omar','omar.e@hotmail.com','ccc','01200066680');
INSERT INTO Sponsor Values('10057','Ismail','ismail.e@hotmail.com','orange','01290066688');
INSERT INTO Sponsor Values('10058','Cherine','cherine.e@hotmail.com','orascom','01000066688');
INSERT INTO Sponsor Values('10059','Marc','marc.e@hotmail.com','pepsi','01200066683');

INSERT INTO Sponsored_by Values ('10050','10102','1000');
INSERT INTO Sponsored_by Values ('10055','10109','6000');
INSERT INTO Sponsored_by Values ('10059','10103','500');
INSERT INTO Sponsored_by Values ('10059','10105','600');
INSERT INTO Sponsored_by Values ('10050','10107','100');
INSERT INTO Sponsored_by Values ('10054','10109','170');
INSERT INTO Sponsored_by Values ('10059','10108','800');
INSERT INTO Sponsored_by Values ('10058','10105','1000');
INSERT INTO Sponsored_by Values ('10059','10104','1500');
INSERT INTO Sponsored_by Values ('10059','10102','1700');

--Lorina Medhat 139974--
INSERT INTO EXHIBITION VALUES ('Feminisim','100','youssef wahba','1','Cairo');
INSERT INTO EXHIBITION VALUES ('Passion','90','korniche','2','Alexandria');
INSERT INTO EXHIBITION VALUES ('Pharonic','80','khan el khalily','3','Giza');
INSERT INTO EXHIBITION VALUES ('Simplicity','70','nuba','4','Giza');
INSERT INTO EXHIBITION VALUES ('Religious','60','zagazig','5','Cairo');
INSERT INTO EXHIBITION VALUES ('Braveness','50','arish','6','Giza');
INSERT INTO EXHIBITION VALUES ('Tropical','40','safaga','7','Cairo');
INSERT INTO EXHIBITION VALUES ('Colorful','30','khalig neama','8','Alexandria');
INSERT INTO EXHIBITION VALUES ('Peaceful','20','suez','9','Cairo');
INSERT INTO EXHIBITION VALUES ('Aesthetic','10','shubra el kheima','10','Giza');

INSERT INTO EXHIBITED_in VALUES ('Night','Tropical','1/12/2016','5/12/2016');
INSERT INTO EXHIBITED_in VALUES ('Self portrait','Passion','6/12/2016','10/12/2016');
INSERT INTO EXHIBITED_in VALUES ('Friday afternoon','Peaceful','10/12/2016','12/12/2016');
INSERT INTO EXHIBITED_in VALUES ('Happy','Colorful','1/12/2016','12/12/2016');
INSERT INTO EXHIBITED_in VALUES ('Night','Pharonic','1/12/2016','5/12/2016');
INSERT INTO EXHIBITED_in VALUES ('Grandma and grandba','Simplicity','6/12/2016','10/12/2016');
INSERT INTO EXHIBITED_in VALUES ('WorldwarII','Colorful','3/12/2016','4/01/2017');
INSERT INTO EXHIBITED_in VALUES ('Flower','Aesthetic','5/01/2017','9/01/2017');
INSERT INTO EXHIBITED_in VALUES ('Night','Feminisim','1/01/2017','4/01/2017');
INSERT INTO EXHIBITED_in VALUES ('Future','Feminisim','11/01/2017','1/02/2017');

--Queries--

--Engy Samir 139394--
--1--
SELECT Distinct Ptitle
From Client join Painting
on Client.C_ID=Painting.Client_ID 
where C_ID='5';
--2--
SELECT C_Fname+' '+ C_Midname+' '+ C_Lname AS 'FullName'
From Client
WHERE Client.C_ID IN ( SELECT Client_ID 
FROM Painting, Artist
WHERE Painting.Aname=Artist.Lname AND Lname='Elgabry');
--3--
SELECT SUM (total) As 'Total of sales' , Avg(total) As 'Average of sales', R_date AS 'Date'
From Receipt
Group by R_date;
--4--
SELECT C_Fname+' '+C_Midname+' '+C_Lname AS 'Client Full Name'
FROM Client 
WHERE C_ID IN ( SELECT Client_ID 
FROM Painting,Exhibited_in
WHERE  Painting.Ptitle=Exhibited_in.Paint_title and Ex_title in(select E_title from Exhibition,Exhibited_in where E_title=Ex_title and C_address=E_city) );
--5--
SELECT Distinct Client.C_Lname AS 'Client Name'
FROM Client join Painting
on Client.C_ID= Painting.Client_ID Where YearOfDrawing='2006' ;
--6--
SELECT  sum(tax) As'Total of taxes',E_city
FROM Receipt , Exhibition
Where CID IN (SELECT C_ID FROM Client , Painting Where Client.C_ID= Painting.Client_ID And Ptitle in(select Paint_title from Exhibited_in,Exhibition where Ex_title=E_title ))
Group By E_city;
--7--
SELECT Client.C_Lname, total
FROM Client, Receipt
Where C_ID=CID and total> All (Select total from Receipt where Num_of_paintings='1');
--8--
select C_Fname + ' '+ C_Lname As 'Client Name'
from Client
where exists (select R_date from Receipt where Client.C_ID=Receipt.CID and R_date='4/1/2016');
--9--
Select Lname
from Artist
Where Artist.Lname IN (select Aname from Painting, Exhibited_in where Artist.Lname =Painting.Aname and
Ptitle IN (select Paint_title from Exhibition, Exhibited_in where E_title=Ex_title));

--Meran Sharawy 148358--
--1--
SELECT COUNT(Ptitle) AS 'Number of paintings',Pgenre AS 'Genre of painting'
FROM Painting
GROUP BY Pgenre;
--2--
SELECT Artist.Lname,Painting.Ptitle, Painting.Pprice
FROM Artist 
FULL OUTER JOIN Painting
ON Artist.Lname=Painting.Aname;
--3--
SELECT Painting.Pgenre,Exhibited_in.Ex_title
FROM Painting
RIGHT OUTER JOIN Exhibited_in
ON Painting.Ptitle=Exhibited_in.Paint_title;
--4--
select Ptitle,Pprice
from Painting
where Pprice > All(select Pprice from Painting where Pprice ='500');
--5--
SELECT Fname, Lname
FROM Artist
WHERE EXISTS (SELECT * FROM Painting WHERE Lname = Aname);
--6--
SELECT a.Fname, a.Lname , a.Nationality , a.NumOfPainting , a.Biography
FROM Artist a
WHERE a.Lname IN (SELECT Aname FROM Show WHERE a.Lname =Show.Aname);
--7--
SELECT Fname+' '+ Midname+' '+ Lname AS 'Artist full name' , Sh_name as 'show name', Sh_date as 'show date'  , Sh_time as 'show time'
From artist join show
on Artist.Lname = show.Aname;
--8--
SELECT avg(Pprice) AS 'the average of paintings price', YearOfDrawing
FROM Painting
GROUP BY YearOfDrawing;

--Gloria Ezzat 150753--
--1--
select Sp_name As 'Sponsor Name'
from Sponsor
where Sp_ID IN (Select Spon_ID from Sponsored_by,Show where Show_code=Sh_code and Sh_theme='describing');
--2--
select Sh_name AS 'Show Name',Lname AS 'Artist'
from Show FULL OUTER JOIN Artist
on Aname=Lname ;
--3--
select AVG(cost) As 'Average Cost'
from Sponsored_by;
--4--
select Fname + ' '+ Midname + ' '+ Lname As 'Full Name'
from Artist
where Lname In (select Aname from Show where Sh_date='4/10/2016');
--5--
select distinct Fname + ' '+ Midname + ' '+ Lname As 'Full Name'
from Artist
where Lname In (select Aname from Show,Sponsored_by where Sh_code=Show_code and Spon_ID In (select Sp_ID from Sponsor where Sp_name='Marc'));
--6--
select p.Ptitle As 'Painting title'
from Painting p
where p.Aname In(select a.Lname from Artist a, Show s where a.Lname=s.Aname and s.Sh_location='lobby');
--7--
select count(Lname) As 'Number of Artist',Sh_theme As 'Show Theme'
from Artist JOIN Show
on Artist.Lname=Show.Aname
group by Sh_theme;
--8--
select Distinct Sh_name As'Show Name'
from Show,Sponsored_by
where Sh_code=Show_code and
Cost>All(select Cost from Sponsored_by where Cost='800');
--9--
select distinct s.Sh_theme As'Show Theme',p.Pgenre As 'Genre of painting'
from Show s FULL OUTER JOIN Painting p
on s.Aname in (select a.Lname from Artist a, Painting p where a.Lname=p.Aname);
--10--
select sum(cost) as 'Total Sponsored Cost',Pgenre as 'Painting Genre'
from Sponsored_by,Painting
where Show_code in(select Sh_code from Show, Artist where Show.Aname=Artist.Lname)
and Painting.Aname in(select Lname from Artist where Painting.Aname=Artist.Lname)
group by Pgenre;

--Lorina Medhat 139974--
--1--
select E_city as'City Name',E_title as'Exhibition Name'
from Exhibition 
where E_title in(select Ex_title from Exhibited_in,Painting where Paint_title=Ptitle and Ptitle='Night');
--2--
select count(Paint_title) as'Number of Paintings',Ex_title as'Exhibition Name'
from Exhibited_in
group by Ex_title;
--3--
select distinct C_Fname +' '+C_Midname +' '+ C_Lname As 'Full Name'
from Client join Painting
on C_ID=Client_ID
where Pgenre='oil painting' ;
--4--
select count(Ptitle) As'Painting Title',Start_date As'Start Date'
from Painting join Exhibited_in
ON painting.Ptitle = Exhibited_in.Paint_title
group by Exhibited_in.Start_date;
--5--
select Paint_title As'Painting Title',Ex_title As'Exhibition Title',E_city As 'Exhibition City'
from Exhibited_in full outer join Exhibition
on Ex_title=E_title;
--6--
select E_city
from Exhibition
where E_title in(select Ex_title from Exhibited_in,Painting where Paint_title=Ptitle and Aname in(select Lname from Artist where Nationality='French'));
--7--
select E_title
from Exhibition
where not exists (select * from Exhibited_in where E_title=Ex_title and End_date='12/12/2016');

DROP DATABASE Snow_Gallery;