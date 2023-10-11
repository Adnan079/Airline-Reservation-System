--Create Database & use it
CREATE DATABASE Ayesha_Airlines
USE Ayesha_Airlines

--AirCrafts Table
CREATE TABLE Air_Crafts( 
AC_ID INT,
AC_Number Varchar(225) NOT NULL, 
Capacity INT NOT NULL,
Manufactured_By Varchar(225) NOT NULL,
Manufactured_On Datetime NOT NULL, Primary Key (AC_ID)
);

INSERT INTO Air_Crafts VALUES (1, 'ATR 72-500', 75, 'Alenia Aeronotica', '23 April 1998');

--Route Table
CREATE TABLE Route(
RT_ID INT,
Airport Varchar(32) NOT NULL, 
Destination Varchar(32) NOT NULL,
RouteCode Varchar(16) NOT NULL UNIQUE, PRIMARY KEY (RT_ID)
);

INSERT INTO Route Values (1,'Islamabad','Lahore','ISL-LHR')

--AirFare Table
CREATE TABLE Airfare( 
AF_ID INT,
Route INT, 
Fare Money, 
FSC Money,
PRIMARY KEY (AF_ID),
CONSTRAINT fk_Route FOREIGN KEY (Route) REFERENCES Route(RT_ID)
);

INSERT INTO Airfare VALUES (1, 1, 86, 12);

--Flight Schedule Table
CREATE TABLE Flight_Schedule(
FS_ID INT,
Flight_Date DATETIME, 
Departure DATETIME,
Arrival DATETIME, 
Air_Crafts INT,
NetFare INT, PRIMARY KEY (FS_ID),
CONSTRAINT fk_Air_Crafts FOREIGN KEY (Air_Crafts) REFERENCES Air_Crafts(AC_ID),
CONSTRAINT fk_NetFare FOREIGN KEY (NetFare) REFERENCES AirFare(AF_ID)
);

INSERT INTO Flight_Schedule VALUES (1, 'January 23 2022', '23:20', '1:20', 1, 1);

--Discounts Table
CREATE TABLE Discounts(
D_ID INT PRIMARY KEY,
Title Varchar(32), 
Amount INT,
Description Varchar (255)
)

INSERT INTO Discounts VALUES (1,'Childrens', 10, 'Discount is provide all childrens under age of 10.');

--Charges Table
CREATE TABLE Charges(
CH_ID INT PRIMARY KEY,
Title Varchar(32),
Amount INT,
Description Varchar (255)
)

INSERT INTO Charges VALUES (2,'Urgent Cancellation', 33.33, '33.3% will be charged for cancellation for booking within 11 hrs from flight take off');

--Country Table
CREATE TABLE Countries ( 
CT_ID INT PRIMARY KEY,
CountryName Varchar (32) NOT NULL
);

INSERT INTO Countries VALUES (1, 'Pakistan');

--State Table
CREATE TABLE State( 
ST_ID INT,
State_Name Varchar (32), 
Country INT, PRIMARY KEY (ST_ID),
CONSTRAINT  fk_Country  FOREIGN  KEY (Country)  REFERENCES Countries(CT_ID)
);

INSERT INTO State VALUES (1, 'Punjab', 1);

--Contact Details Table
CREATE TABLE Contact_Details( 
CD_ID INT PRIMARY KEY,
Email Varchar (80) NOT NULL, 
Cell Varchar (16) NOT NULL, 
Tel Varchar (16),
Street Varchar (64),
State INT NOT NULL,
CONSTRAINT  fk_State  FOREIGN  KEY (State)  REFERENCES  State(ST_ID)
);

INSERT INTO Contact_Details VALUES (1,'adnannaeem417@gail.com',  '+92-3097796979',  '+01-4215384',  'Iqbal Town', 1);

--Passengers Table
CREATE TABLE Passengers(
PS_ID INT PRIMARY KEY,
Name Varchar (32) NOT NULL,
Address Varchar (64) NOT NULL, 
Age INT NOT NULL,
Nationality Varchar(32) NOT NULL,
Contacts INT NOT NULL,
CONSTRAINT fk_Contacts FOREIGN KEY (Contacts) REFERENCES Contact_Details(CD_ID)
);

INSERT INTO Passengers VALUES (1,'Adnan Naeem', 'Askari X-40, LHR', 22, 'Pakistani', 1);

--Branch Table
CREATE TABLE Branches(
B_ID INT PRIMARY KEY,
Center Varchar(32) NOT NULL, 
Address Varchar(32) NOT NULL, 
State INT,
CONSTRAINT fk_StateofEmployee FOREIGN KEY (State) REFERENCES State(ST_ID)
);

INSERT INTO Branches VALUES (1, 'Islamabad', 'New Mall Road', 1);

--Employee Table
CREATE TABLE Employee
(
EMP_ID INT PRIMARY KEY,
Name Varchar (32) NOT NULL, 
Address Varchar (32) NOT NULL, 
Branch INT NOT NULL,
Designation Varchar(32) NOT NULL,
Email Varchar (80) NOT NULL, 
Tel Varchar (16) NOT NULL, 
Ext INT,
CONSTRAINT fk_Branch FOREIGN KEY (Branch) REFERENCES Branches(B_ID)
);

INSERT INTO Employee VALUES (1, 'Abdul Baaqie Khan', 'Bahria Town Sector F, ISL', 1, 'Sales Executive', 'the.one@yahoo.com', '+01-4215254', 12)

--Transactions Table
CREATE TABLE Transactions(
T_ID INT PRIMARY KEY,
BookingDate DATETIME, 
DepartureDate DATETIME, 
Passenger INT,
Flight INT, Type BIT, 
Employee INT, 
Charges INT, 
Discount INT,
CONSTRAINT fk_Passenger FOREIGN KEY (Passenger) REFERENCES Passengers(PS_ID),
CONSTRAINT fk_Flight FOREIGN KEY (Flight) REFERENCES Flight_Schedule(FS_ID),
CONSTRAINT fk_Employee FOREIGN KEY (Employee) REFERENCES Employee(EMP_ID),
CONSTRAINT fk_Charges FOREIGN KEY (Charges) REFERENCES Charges(CH_ID),
CONSTRAINT fk_Discount FOREIGN KEY (Discount) REFERENCES Discounts(D_ID)
);

INSERT INTO Transactions VALUES (1,'12 November 2021', '23 January 2022', 1, 1, 0, 1, NULL, NULL);