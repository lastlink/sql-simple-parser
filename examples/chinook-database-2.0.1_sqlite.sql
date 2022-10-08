/*
sql generated using:
 * Package: @funktechno/little-mermaid-2-the-sql
 * Version: 0.0.3
 * databaseInfo: sqlite
*/

CREATE TABLE "Artist" (
	"ArtistId" INTEGER NOT NULL,
	"Name" NVARCHAR(120),
	PRIMARY KEY("ArtistId")
);

CREATE TABLE "Employee" (
	"EmployeeId" INTEGER NOT NULL,
	"LastName" NVARCHAR(20) NOT NULL,
	"FirstName" NVARCHAR(20) NOT NULL,
	"Title" NVARCHAR(30),
	"ReportsTo" INTEGER,
	"BirthDate" DATETIME,
	"HireDate" DATETIME,
	"Address" NVARCHAR(70),
	"City" NVARCHAR(40),
	"State" NVARCHAR(40),
	"Country" NVARCHAR(40),
	"PostalCode" NVARCHAR(10),
	"Phone" NVARCHAR(24),
	"Fax" NVARCHAR(24),
	"Email" NVARCHAR(60),
	PRIMARY KEY("EmployeeId")
);

CREATE TABLE "Genre" (
	"GenreId" INTEGER NOT NULL,
	"Name" NVARCHAR(120),
	PRIMARY KEY("GenreId")
);

CREATE TABLE "MediaType" (
	"MediaTypeId" INTEGER NOT NULL,
	"Name" NVARCHAR(120),
	PRIMARY KEY("MediaTypeId")
);

CREATE TABLE "Playlist" (
	"PlaylistId" INTEGER NOT NULL,
	"Name" NVARCHAR(120),
	PRIMARY KEY("PlaylistId")
);

CREATE TABLE "Album" (
	"AlbumId" INTEGER NOT NULL,
	"Title" NVARCHAR(160) NOT NULL,
	"ArtistId" INTEGER NOT NULL,
	PRIMARY KEY("AlbumId"),
	FOREIGN KEY ("ArtistId") REFERENCES "Artist"("ArtistId")
);

CREATE TABLE "Customer" (
	"CustomerId" INTEGER NOT NULL,
	"FirstName" NVARCHAR(40) NOT NULL,
	"LastName" NVARCHAR(20) NOT NULL,
	"Company" NVARCHAR(80),
	"Address" NVARCHAR(70),
	"City" NVARCHAR(40),
	"State" NVARCHAR(40),
	"Country" NVARCHAR(40),
	"PostalCode" NVARCHAR(10),
	"Phone" NVARCHAR(24),
	"Fax" NVARCHAR(24),
	"Email" NVARCHAR(60) NOT NULL,
	"SupportRepId" INTEGER,
	PRIMARY KEY("CustomerId"),
	FOREIGN KEY ("SupportRepId") REFERENCES "Employee"("EmployeeId")
);

CREATE TABLE "test_table" (
	"id" INTEGER NOT NULL,
	"Field 2_2" TEXT,
	"Artist Id" INTEGER,
	PRIMARY KEY("id"),
	FOREIGN KEY ("Artist Id") REFERENCES "Artist"("ArtistId")
);

CREATE TABLE "Invoice" (
	"InvoiceId" INTEGER NOT NULL,
	"CustomerId" INTEGER NOT NULL,
	"InvoiceDate" DATETIME NOT NULL,
	"BillingAddress" NVARCHAR(70),
	"BillingCity" NVARCHAR(40),
	"BillingState" NVARCHAR(40),
	"BillingCountry" NVARCHAR(40),
	"BillingPostalCode" NVARCHAR(10),
	"Total" NUMERIC(10,2) NOT NULL,
	PRIMARY KEY("InvoiceId"),
	FOREIGN KEY ("CustomerId") REFERENCES "Customer"("CustomerId")
);

CREATE TABLE "Track" (
	"TrackId" INTEGER NOT NULL,
	"Name" NVARCHAR(200) NOT NULL,
	"AlbumId" INTEGER,
	"MediaTypeId" INTEGER NOT NULL,
	"GenreId" INTEGER,
	"Composer" NVARCHAR(220),
	"Milliseconds" INTEGER NOT NULL,
	"Bytes" INTEGER,
	"UnitPrice" NUMERIC(10,2) NOT NULL,
	PRIMARY KEY("TrackId"),
	FOREIGN KEY ("AlbumId") REFERENCES "Album"("AlbumId"),
	FOREIGN KEY ("GenreId") REFERENCES "Genre"("GenreId"),
	FOREIGN KEY ("MediaTypeId") REFERENCES "MediaType"("MediaTypeId")
);

CREATE TABLE "InvoiceLine" (
	"InvoiceLineId" INTEGER NOT NULL,
	"InvoiceId" INTEGER NOT NULL,
	"TrackId" INTEGER NOT NULL,
	"UnitPrice" NUMERIC(10,2) NOT NULL,
	"Quantity" INTEGER NOT NULL,
	PRIMARY KEY("InvoiceLineId"),
	FOREIGN KEY ("InvoiceId") REFERENCES "Invoice"("InvoiceId"),
	FOREIGN KEY ("TrackId") REFERENCES "Track"("TrackId")
);

CREATE TABLE "PlaylistTrack" (
	"PlaylistId" INTEGER NOT NULL,
	"TrackId" INTEGER NOT NULL,
	PRIMARY KEY("PlaylistId","TrackId"),
	FOREIGN KEY ("PlaylistId") REFERENCES "Playlist"("PlaylistId"),
	FOREIGN KEY ("TrackId") REFERENCES "Track"("TrackId")
);

