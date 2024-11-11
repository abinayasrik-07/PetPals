-- 05 Nov 2024

create database OnlineBookSale
use OnlineBookSale

--Book Table

create table Book
(
ISBN int primary key,
Title varchar(50),
Genre varchar(40),
PublicationDate date not null,
Price decimal(8,2),
PublisherID int,
constraint FK_Book 
foreign key (PublisherId) references Publisher(PublisherId)
)

select * from Book
insert into Book(ISBN, Title, Genre, PublicationDate, Price, PublisherID)
values(1111, 'AI','Technology','1999-02-27', 420, 101),
	  (1112, 'Siddhartha','Philosophy','1992-10-21',90, 103),
	  (1113, 'Weekly News Paper','News','2024-10-11',15, 107),
	  (1114, 'Harry Potter','Fantasy','1997-06-27',500, 107),
	  (1115, 'Psychology Of Money','Self-Help','2020-09-08',350, 104),
	  (1116, 'The Power of Habit','Motivation','2006-12-20',700, 105),
	  (1117, 'The Innovators','Technology','2024-02-01',550, 106),
	  (1118, 'Data Structure Algorithms','Technology','2022-05-10',999, 109),
	  (1119, 'The Alchemist','Technology','2020-09-08', 1200, 108),
	  (1120, 'The Changeling','Fantasy','2017-11-18', 700, 104)

--Author Table

create table Author
(
AuthorId int primary key,
AuthorName varchar(30)
)

select * from Author
insert into Author values (501, 'Melanie Mitchell'),
						  (502, 'Hermann Hesse'),
						  (503, 'News Channel'),
						  (504, 'J.K. Rowling'),
						  (505, 'Morgan Housel'),
						  (506, 'Charles Duhigg'),
						  (507, 'Walter Isaacson'),
						  (508, 'Narasimha Karumanchi'),
						  (509, 'Paulo Coelho'),
						  (510, 'Victor LaValle')

--BookAuthor Table

create table Book_Author
(
ISBN int,
AuthorId int,
constraint FK_BookAuthor
foreign key (ISBN) references Book(ISBN) on delete cascade on update cascade,
foreign key (AuthorId) references Author(AuthorId) on delete cascade on update cascade
)
drop table Book_Author
select * from Author
select * from Book
select * from Publisher
select * from Book_Author
insert into Book_Author values (1111, 501),
							   (1112, 502),
							   (1113, 501),
							   (1114, 504),
							   (1115, 505),
							   (1116, 506),
							   (1117, 502),
							   (1118, 508),
							   (1119, 508),
							   (1120, 509)

--Publisher Table

create table Publisher
(
PublisherId int primary key,
PublisherName varchar(15),
PublisherAddress varchar(30),
Contact bigint unique 
)

alter table Publisher
add Contact bigint default null

select * from Publisher
insert into Publisher values(101,'publisher1','Chennai', 2034567890),
							(102,'publisher2','Banglore', 9012345670),
							(103,'publisher3','Coimbatore', 1523456789),
							(104,'publisher4','Delhi', 5678910112),
							(105,'publisher5','Hyderabad', 9876543211),
							(106,'publisher6','Hyderabad', 9786543211),
							(107,'publisher7','Chennai', 9875443211),
							(108,'publisher8','Thanjavur', 9875443221),
							(109,'publisher9','Bengalure', 9875443231),
							(110,'publisher10','Namakkal', 9875443241)



--Users Table

create table Users
(
UserId int primary key not null,
Email varchar(50) not null,
ContactNo bigint,
)

select * from Users
insert into Users values (201, 'user1@gmail.com', 1234567890),
						 (202, 'user2@gmail.com', 1345678901),
						 (203, 'user3@gmail.com', 1456789012),
						 (204, 'user4@gmail.com', 1567890123),
						 (205, 'user5@gmail.com', 1678901234),
						 (206, 'user6@gmail.com', 1678902134),
						 (207, 'user7@gmail.com', 1678901243),
						 (208, 'user8@gmail.com', 1678912344),
						 (209, 'user9@gmail.com', 1678002134),
						 (210, 'user10@gmail.com', 1668902134)


--Orders Table

create table Orders
(
OrderId int primary key,
OrderDate date,
TotalAmount int default 0,
OrderStatus varchar(20),
constraint FK_Orders
foreign key (OrderId) references Users(UserId)
)

select * from Orders
insert into Orders(OrderId, OrderDate, OrderStatus)
values (207, '2024-03-07', 'Pending'),
	   (202, '2024-04-22', 'Delivered'),
	   (203, '2024-05-28', 'Pending'),
	   (204, '2024-06-06', 'Pending'),
	   (205, '2024-07-07', 'Delivered'),
	   (206, '2024-07-08', 'Pending'),
	   (201, '2023-02-18', 'Delivered'),
	   (210, '2023-06-22', 'Delivered'),
	   (209, '2023-12-25', 'Delivered'),
	   (208, '2024-11-17', 'Delivered')


--OrderDetails Table

create table OrderDetails
(
OrderId int,
ISBN int,
Quantity int,
constraint PK_OrderDetails primary key(OrderId),
constraint FK1_OrderDetails 
foreign key (OrderId) references Orders(OrderId),
constraint FK2_OrderDetails 
foreign key (ISBN) references Book(ISBN)
)

select * from OrderDetails
insert into OrderDetails(OrderId, ISBN, Quantity)
values (201, 1111, 2),
	   (202, 1112, 1),
	   (203, 1113, 2),
	   (204, 1116, 1),
	   (205, 1115, 3),
	   (206, 1116, 1),
	   (207, 1117, 10),
	   (209, 1112, 5),
	   (208, 1117, 1),
	   (210, 1117, 3)


--1. Write a query to list all books where price is greater than 20
Select * from Book where Price > 90

--2. List all books where PublisherId is 103
Select * from Book where PublisherId = 107

--3. Orders where OrderStatus is Pending
Select * from Orders where OrderStatus = 'Pending'

--4. Change the price of the book to 300 with ISBN 1 
--set identity_insert Book on
Update Book set Price = 920 where ISBN = 1114
select * from Book

--5. Increase the price of all books in the specific genre by 10%
Update Book set Price = Price*1.10 where Genre = 'Technology'

--6. Delete from Book where ISBN = 001
delete from Book where ISBN = 1111

--7. Get details of books published on or after 2024-01-01
select * from Book
where PublicationDate >= '2024-01-01'

--8. All book where the genre is not art
select * from Book where Genre != 'News'

--9. All customers with contactNo that are not null
select * from Users where ContactNo is not null


-- 07 Nov 2024

--1. Count the total number of books in bookstore
select count(*) as BookCount
from Book

--2. Avg price of all books in the 'Fantasy' genre.
select Avg(Price) as TechnologyAvgPrice
from Book
where Genre = 'Technology'

--3. Total Revenue generated from all Orders.
select sum(B.Price * OD.Quantity) as TotalRevenue
from Orders O
join OrderDetails OD on O.OrderId = OD.OrderId
join Book B on OD.ISBN = B.ISBN

--On each customer
select O.OrderId, sum(B.Price * OD.Quantity) as TotalRevenue
from Orders O
join OrderDetails OD on O.OrderId = OD.OrderId
join Book B on OD.ISBN = B.ISBN
Group by O.OrderId

--4. Find the min and max price of books in the any specific genre.
select min(Price) as [Minimum of Technology], max(Price) as [Maximum of Technology] 
from Book
where Genre ='Technology'

--5. Count the no of orders for each status
select OrderStatus, count(OrderStatus) as StatusCount
from Orders
Group By OrderStatus

--6. Get the month when each order was placed.
select DateName(MONTH, OrderDate) as OrderPlacedMonths
from Orders

--7. Calculate total revenue for each month.
select  
DateName(MONTH, OrderDate) as OrderMonth, 
sum(B.Price * OD.Quantity) as MonthTotal
from Orders O
join OrderDetails OD on O.OrderId = OD.OrderId
join Book B on OD.ISBN = B.ISBN
Group by DateName(MONTH, OrderDate)
Order by OrderMonth

--8. All books along with their publisher names.
select B.Title, P.PublisherName
from Book B
join Publisher P on B.PublisherId = P.PublisherId

--9. Retrieve all orders along with the names of the customers who placed them.
select U.Email, O.OrderId
from Orders O
join Users U on O.OrderId = U.UserId

--10. Find all books that have been ordered at least once.
select B.Title 
from Book B
join OrderDetails OD on B.ISBN = OD.ISBN
Group by Title

--11. Retrieve a list of authors along with the titles of books they have written.
select A.AuthorName, B.Title
from Author A
JOIN Book_Author BA ON A.AuthorId = BA.AuthorId
JOIN Book B ON BA.ISBN = B.ISBN

--12. List all books along with their publisher names, including books with no publisher information.
select B.Title, P.PublisherName
from Book B
left join Publisher P on  B.PublisherId = P.PublisherId

--13. Retrieve all orders with their details, including orders with no items.
select O.OrderId, O.OrderDate, O.TotalAmount, O.OrderStatus, OD.ISBN, OD.Quantity
from Orders O
left join OrderDetails OD on O.OrderId = OD.OrderId

--14. Find all pairs of customers from the same city.
alter table Users
add UserCity varchar(30)

drop table Users
Update Users set UserCity = 'Chennai' where UserId in (201, 207)
Update Users set UserCity = 'Madurai' where UserId = 202
Update Users set UserCity = 'Pondicherry' where UserId in (203, 206)
Update Users set UserCity = 'Karnataka' where UserId = 204
Update Users set UserCity = 'Coimbature' where UserId = 205

select u1.UserId as User1, u1.UserCity, u2.UserId as User2, u1.UserCity
from Users u1
join Users u2 on u1.UserCity = u2.UserCity and u1.UserId < u2.UserId
order by u1.UserCity, User1, User2


-- 08 Nov 2024

--1. Find the title of the book with the highest price.
select Title from Book
where Price = (select max(Price) from Book)

--2. List all authors who have written books in the specific genre.
select A.AuthorName, B.Genre
from Author A
join Book_Author BA on A.AuthorId = BA.AuthorId
join Book B on B.ISBN = BA.ISBN
where B.Genre = 'Technology'

--3. Find the title of the books that have never been ordered.
select B.Title
from Book B
left join OrderDetails OD on OD.ISBN = B.ISBN
where OD.ISBN is null

--4. Get the names of the customers who have placed orders totaling more then amount as per values you have in db.
select U.Email from Users U
where U.UserId in
(
select O.OrderId from Orders O
join OrderDetails OD on O.OrderId = OD.OrderId
join Book B on OD.ISBN = B.ISBN
Group by O.OrderId, O.TotalAmount 
Having sum(OD.Quantity * B.Price) > O.TotalAmount
)

--5. List all books that cost more than the average price of all books.
select B.Title, B.Price
from Book B
where B.Price >
(
select avg(Price)
from Book
)

--6. Retrieve books published by the publisher with the fewest books.
select P.PublisherName
from Publisher P
left join Book B on P.PublisherId = B.PublisherID
where B.PublicationDate is null

--7. Find the avg quantity of books per order
select OD.OrderId, avg(OD.Quantity) as AvgQuantity
from OrderDetails OD
group by OrderId

--8. Display each book's title and its rank by price (highest to lowest).
select B.Title, B.Price
from Book B
Order by Price desc

--9. Find the customers who have placed more orders than the average orders per customer.
select U.UserId, U.Email from Users U
where (select count(*) from Orders O
where O.OrderId = U.UserId) >
(select avg(OrderCount) from 
(select count(*) as OrderCount from Orders
Group By OrderId) as UserOrder)

--10. List all books along with the number of orders.
--Use a correlated subquery to count orders for each book.
select B.Title, B.ISBN, 
(select count(*) 
from OrderDetails OD 
where OD.ISBN = B.ISBN) 
as OrderCount
from Book B


-- 09 Nov 2024

--1. Get the total sales amount by month and genre, 
--including total for each genre across all months and for each month across all genres.
select month(O.OrderDate) as SaleMonth, B.Genre,
(select sum(BS.Price * ODS.Quantity) from Orders OS, OrderDetails ODS, Book BS
where OS.OrderId = ODS.OrderId and ODS.ISBN = BS.ISBN and month(OS.OrderDate) = 
month(O.OrderDate) and BS.Genre = B.Genre) as TotalSalesAmount
from Orders O, OrderDetails OD, Book B
where O.OrderId = OD.OrderId and OD.ISBN = B.ISBN
Group By month(O.OrderDate), B.Genre

UNION ALL

select null as SaleMonth, B.Genre,(select sum(BS.Price * ODS.Quantity)
from Orders OS, OrderDetails ODS, Book BS
where OS.OrderId = ODS.OrderId and ODS.ISBN = BS.ISBN and BS.Genre = b.Genre) as TotalSalesAmount
from Book B
Group By B.Genre

UNION ALL

select month(O.OrderDate) as SaleMonth, null as Genre,
(select sum(BS.Price * ODS.Quantity)
from Orders OS, OrderDetails ODS, Book BS
where OS.OrderId = ODS.OrderId and ODS.ISBN = BS.ISBN and month(OS.OrderDate) = month(O.OrderDate)) as TotalSalesAmount
from Orders O
Group By month(O.OrderDate)

--2. Show the Total Quantity Sold and Total Sales Revenue for Each Publisher and Genre, 
--Including Totals by Publisher, by Genre, and Overall
select B.PublisherID, B.Genre, (select sum(ODS.Quantity)
from OrderDetails ODS, Book BS
where ODS.ISBN = BS.ISBN and BS.PublisherID = B.PublisherID and BS.Genre = B.Genre) as TotalQuantity,
(select sum(BS.Price * ODS.Quantity)
from OrderDetails ODS, Book BS
where ODS.ISBN = BS.ISBN and BS.PublisherID = B.PublisherID and BS.Genre = B.Genre) as TotalRevenue
from Book B
Group By B.PublisherID, B.Genre

UNION ALL

select B.PublisherID, null as Genre,
(select sum(ODS.Quantity)
from OrderDetails ODS, Book BS
where ODS.ISBN = BS.ISBN and BS.PublisherID = b.PublisherID) as TotalQuantity,
(select sum(BS.Price * ODS.Quantity)
from OrderDetails ODS, Book BS
where ODS.ISBN = BS.ISBN and BS.PublisherID = b.PublisherID) as TotalRevenue
from Book B
Group By B.PublisherID

UNION ALL

select null as PublisherID, B.Genre,
(select sum(ODS.Quantity)
from OrderDetails ODS, Book BS
where ODS.ISBN = BS.ISBN and BS.Genre = B.Genre) as TotalQuantity,
(select sum(BS.Price * ODS.Quantity)
from OrderDetails ODS, Book BS
where ODS.ISBN = BS.ISBN and BS.Genre = B.Genre) as TotalRevenue
from Book B
Group By B.Genre

UNION ALL

select null as PublisherID, null as Genre,
(select sum(ODS.Quantity) from OrderDetails ODS) as TotalQuantity,
(select sum(B.Price * ODS.Quantity) from OrderDetails ODS, Book B
where ODS.ISBN = B.ISBN) as TotalRevenue

--3. Get the Total Revenue Generated from Each Book Genre per Month, with Subtotals by Genre and by Month
Select Datepart(Month, O.Orderdate) as Salemonth, B.Genre, (Select Sum(BS.Price * ODS.Quantity)
from Orders OS, Orderdetails ODS, Book BS
where OS.OrderId = ODS.OrderId and ODS.ISBN = BS.ISBN and Datepart(Month, OS.Orderdate) = 
Datepart(Month, O.Orderdate) and BS.Genre = B.Genre) as Totalrevenue
from Orders O
join Orderdetails OD On O.Orderid = OD.Orderid
join Book B On OD.ISBN = B.ISBN
Group By Datepart(Month, O.Orderdate), B.Genre

Union All

Select null As Salemonth, B.Genre, (Select Sum(BS.Price * ODS.Quantity)
from Orders OS, Orderdetails ODS, Book BS
where OS.OrderId = ODS.OrderId and ODS.ISBN = BS.ISBN and BS.Genre = B.Genre) as Totalrevenue
From Book B
Group By B.Genre

Union All

Select Datepart(Month, O.Orderdate) as Salemonth, null as Genre,
(Select Sum(BS.Price * ODS.Quantity)
from Orders OS, Orderdetails ODS, Book BS
where OS.OrderId = ODS.OrderId and ODS.ISBN = BS.ISBN and Datepart(Month, OS.Orderdate) = Datepart(Month, O.Orderdate)) as Totalrevenue
from Orders O
Group By Datepart(Month, O.Orderdate)
