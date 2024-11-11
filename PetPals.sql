--1. Provide a SQL script that initializes the database for the Pet Adoption Platform ”PetPals”
--4. Ensure the script handles potential errors, such as if the database or tables already exist.

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'PetPals')
BEGIN
    CREATE DATABASE PetPals
END

use PetPals

--2. Create tables for pets, shelters, donations, adoption events, and participants.
--3. Define appropriate primary keys, foreign keys, and constraints

Create table Pets
(
PetID int primary key,
[Name] varchar(30),
Age int,
Breed varchar(30),
[Type] varchar(30),
AvailableForAdoption bit not null default 1,
ShelterID int
constraint FK_Pets
foreign key (ShelterID) references Shelters(ShelterID)
)

drop table Pets
select * from Pets
insert into Pets (PetID, [Name], Age, Breed, [Type], AvailableForAdoption, ShelterID) values 
(1, 'Buddy', 3, 'Golden Retriever', 'Dog', 1, 1),
(2, 'Mittens', 2, 'Siamese', 'Cat', 1, 2),
(3, 'Charlie', 5, 'Beagle', 'Dog', 0, 2),
(4, 'Whiskers', 1, 'Persian', 'Cat', 1, 3),
(5, 'Max', 4, 'Labrador', 'Dog', 1, 4)

Create table Shelters
(
ShelterID int primary key,
[Name] varchar(30),
[Location] varchar(30)
)

select * from Shelters
insert into Shelters (ShelterID, [Name], [Location])
values 
    (1, 'Happy Tails Shelter', 'Chennai, India'),
    (2, 'Paws and Claws Shelter', 'Bangalore, India'),
    (3, 'The Animal Haven', 'Mumbai, India'),
    (4, 'Furry Friends Shelter', 'Delhi, India')

Create table Donations
(
DonationID int primary key,
DonorName varchar(50),
DonationType varchar(20),
DonationAmount decimal(10, 2) default 0,
DonationItem varchar(50),
DonationDate date,
ShelterID int,
constraint FK_ShelterID
foreign key (ShelterID) references Shelters(ShelterID)
)

select * from Donations
insert into Donations (DonationID, DonorName, DonationType, DonationAmount, DonationItem, DonationDate, ShelterID)
values 
    (1, 'John Doe', 'Cash', 500.00, NULL, '2024-11-01', 1),
    (2, 'Jane Smith', 'Item', NULL, 'Dog Food', '2024-11-02', 2),
    (3, 'Michael Johnson', 'Cash', 1000.00, NULL, '2024-11-03', 1),
    (4, 'Sarah Brown', 'Item', NULL, 'Cat Toys', '2024-11-05', 3),
    (5, 'Emily White', 'Cash', 300.00, NULL, '2024-11-06', 4)

Create table AdoptionEvents
(
EventID int primary key,
EventName varchar(50),
EventDate date,
[Location] varchar(30),
ShelterID int
constraint FK_AdoptionEvents
foreign key (ShelterID) references Shelters(ShelterID)
)

select * from AdoptionEvents
insert into AdoptionEvents (EventID, EventName, EventDate, [Location], ShelterID)
values 
    (1, 'Pet Adoption Drive', '2024-11-10', 'Chennai, India', 2),
    (2, 'Adopt a Furry Friend', '2024-11-12', 'Bangalore, India', 1),
    (3, 'Paws for Adoption', '2024-11-15', 'Delhi, India', 3),
    (4, 'Adoption Awareness Event', '2024-11-18', 'Mumbai, India', 4)


Create table Participants 
(
ParticipantID int primary key,
ParticipantName varchar(50),
ParticipantType varchar(20),
EventID int,
foreign key (EventID) references AdoptionEvents(EventID)
)

select * from Participants
insert into Participants (ParticipantID, ParticipantName, ParticipantType, EventID)
values
    (1, 'Happy Tails Shelter', 'Shelter', 1),
    (2, 'Paws and Claws Shelter', 'Shelter', 2),
    (3, 'The Animal Haven', 'Shelter', 3),
    (4, 'Furry Friends Shelter', 'Shelter', 4),
    (5, 'John Doe', 'Adopter', 1),
    (6, 'Jane Smith', 'Adopter', 2),
    (7, 'Michael Johnson', 'Adopter', 3),
    (8, 'Sarah Brown', 'Adopter', 4)



-- 5. Write an SQL query that retrieves a list of available pets (those marked as available for adoption)
--from the "Pets" table. Include the pet's name, age, breed, and type in the result set. Ensure that
--the query filters out pets that are not available for adoption.

select [Name], Age, Breed, [Type]
from Pets
where AvailableForAdoption = 1

--6. Write an SQL query that retrieves the names of participants (shelters and adopters) registered
--for a specific adoption event. Use a parameter to specify the event ID. Ensure that the query
--joins the necessary tables to retrieve the participant names and types.

declare @EventID int = 1 
select ParticipantName, ParticipantType
from Participants
where EventID = @EventID

--8. Write an SQL query that calculates and retrieves the total donation amount for each shelter (by
--shelter name) from the "Donations" table. The result should include the shelter name and the
--total donation amount. Ensure that the query handles cases where a shelter has received no donations.

select s.Name AS ShelterName, 
ISNULL(SUM(d.DonationAmount), 0) AS TotalDonationAmount
from Shelters s
LEFT JOIN Donations d ON s.ShelterID = d.ShelterID
Group By s.Name
Order By ShelterName

--9. Write an SQL query that retrieves the names of pets from the "Pets" table that do not have an
--owner (i.e., where "OwnerID" is null). Include the pet's name, age, breed, and type in the result set

alter table Pets
add OwnerID int null

Update Pets set OwnerID = 111 where PetID in (111, 115)
Update Pets set OwnerID = 112 where PetID in (112)
select * from Pets

select [Name], Age, Breed, [Type]
from Pets
where OwnerID IS NULL

--10. Write an SQL query that retrieves the total donation amount for each month and year (e.g.,January 2023) from the "Donations" table. 
--The result should include the month-year and the corresponding total donation amount. 
--Ensure that the query handles cases where no donations were made in a specific month-year.

select convert (VARCHAR(7), DonationDate, 120) AS MonthYear, sum(DonationAmount) as TotalDonationAmount
from Donations
Group By convert(varchar(7), DonationDate, 120)
Order By MonthYear

--11. Retrieve a list of distinct breeds for all pets that are either aged between 1 and 3 years or older than 5 years.

select distinct Breed from Pets
where (Age between 1 and 3) or Age > 5

--12. Retrieve a list of pets and their respective shelters where the pets are currently available for adoption.

select * from Pets p
join Shelters s on p.ShelterID = s.ShelterID
where p.AvailableForAdoption = 1 

--13. Find the total number of participants in events organized by shelters located in specific city. Example: City=Chennai.

select count(p.ParticipantID) as TotalParticipants
FROM Participants p
join AdoptionEvents ae on p.EventID = ae.EventID
join Shelters s on ae.ShelterID = s.ShelterID
where s.[Location] = 'Chennai, India'

--14. Retrieve a list of unique breeds for pets with ages between 1 and 5 years.

select distinct Breed from Pets
where Age between 1 and 5

--15. Find the pets that have not been adopted by selecting their information from the 'Pet' table.
select PetID, [Name], Age, Breed, [Type]
from Pets
where OwnerID is null

--16. Retrieve the names of all adopted pets along with the adopter's name from the 'Adoption' and 'User' tables.

SELECT 
    p.[Name] AS PetName, 
    u.UserName AS AdopterName
FROM 
    Pets p
JOIN 
    Users u ON p.OwnerID = u.UserID
WHERE 
    p.OwnerID IS NOT NULL;

--17. Retrieve a list of all shelters along with the count of pets currently available for adoption in each shelter.

select s.[Name] as ShelterName, count(p.PetID) as AvailablePetsCount
from Shelters s
left join Pets p ON s.ShelterID = p.ShelterID AND p.AvailableForAdoption = 1
Group By s.[Name]

--18. Find pairs of pets from the same shelter that have the same breed.

select p1.Name as Pet1Name, p2.Name as Pet2Name, p1.Breed as Breed, p1.ShelterID
from Pets p1
join Pets p2 ON p1.ShelterID = p2.ShelterID AND p1.Breed = p2.Breed AND p1.PetID < p2.PetID

--19. List all possible combinations of shelters and adoption events.

select s.[Name] as ShelterName, 
    e.EventName as AdoptionEventName
from Shelters s
cross join AdoptionEvents e

--20. Determine the shelter that has the highest number of adopted pets

select s.[Name] as ShelterName, count(p.PetID) as AdoptedPetsCount
from Shelters s
JOIN 
    Pets p on s.ShelterID = p.ShelterID
WHERE 
    p.OwnerID is not null
GROUP BY 
    s.[Name]
ORDER BY 
    AdoptedPetsCount DESC



