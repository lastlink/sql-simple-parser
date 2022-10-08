/*
sql generated using:
 * Package: @funktechno/little-mermaid-2-the-sql
 * Version: 0.0.3
 * databaseInfo: mysql
*/

CREATE TABLE `adventureworks_addresstype` (
	`AddressTypeID` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`AddressTypeID`)
);

CREATE TABLE `adventureworks_productsubcategory` (
	`ProductSubcategoryID` INT NOT NULL,
	`ProductCategoryID` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductSubcategoryID`),
	FOREIGN KEY (`ProductCategoryID`) REFERENCES `adventureworks_productcategory`(`ProductCategoryID`)
);

CREATE TABLE `adventureworks_awbuildversion` (
	`SystemInformationID` INT NOT NULL,
	`Database Version` VARCHAR NOT NULL,
	`VersionDate` DATETIME NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SystemInformationID`)
);

CREATE TABLE `adventureworks_contact` (
	`ContactID` INT NOT NULL,
	`NameStyle` BIT NOT NULL,
	`Title` VARCHAR,
	`FirstName` VARCHAR NOT NULL,
	`MiddleName` VARCHAR,
	`LastName` VARCHAR NOT NULL,
	`Suffix` VARCHAR,
	`EmailAddress` VARCHAR,
	`EmailPromotion` INT NOT NULL,
	`Phone` VARCHAR,
	`PasswordHash` VARCHAR NOT NULL,
	`PasswordSalt` VARCHAR NOT NULL,
	`AdditionalContactInfo` MEDIUMTEXT,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ContactID`)
);

CREATE TABLE `adventureworks_contacttype` (
	`ContactTypeID` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ContactTypeID`)
);

CREATE TABLE `adventureworks_countryregion` (
	`CountryRegionCode` VARCHAR NOT NULL,
	`Name` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CountryRegionCode`)
);

CREATE TABLE `adventureworks_countryregioncurrency` (
	`CountryRegionCode` VARCHAR NOT NULL,
	`CurrencyCode` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CountryRegionCode`,`CurrencyCode`)
);

CREATE TABLE `adventureworks_creditcard` (
	`CreditCardID` INT NOT NULL,
	`CardType` VARCHAR NOT NULL,
	`CardNumber` VARCHAR NOT NULL,
	`ExpMonth` TINYINT NOT NULL,
	`ExpYear` SMALLINT NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CreditCardID`)
);

CREATE TABLE `adventureworks_culture` (
	`CultureID` VARCHAR NOT NULL,
	`Name` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CultureID`)
);

CREATE TABLE `adventureworks_currency` (
	`CurrencyCode` VARCHAR NOT NULL,
	`Name` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CurrencyCode`)
);

CREATE TABLE `adventureworks_currencyrate` (
	`CurrencyRateID` INT NOT NULL,
	`CurrencyRateDate` DATETIME NOT NULL,
	`FromCurrencyCode` VARCHAR NOT NULL,
	`ToCurrencyCode` VARCHAR NOT NULL,
	`AverageRate` DOUBLE NOT NULL,
	`EndOfDayRate` DOUBLE NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CurrencyRateID`)
);

CREATE TABLE `adventureworks_databaselog` (
	`DatabaseLogID` INT NOT NULL,
	`PostTime` TIMESTAMP NOT NULL,
	`DatabaseUser` VARCHAR NOT NULL,
	`Event` VARCHAR NOT NULL,
	`Schema` VARCHAR,
	`Object` VARCHAR,
	`TSQL` MEDIUMTEXT NOT NULL,
	`XmlEvent` MEDIUMTEXT NOT NULL,
	PRIMARY KEY(`DatabaseLogID`)
);

CREATE TABLE `adventureworks_department` (
	`DepartmentID` SMALLINT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`GroupName` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`DepartmentID`)
);

CREATE TABLE `adventureworks_document` (
	`DocumentID` INT NOT NULL,
	`Title` VARCHAR NOT NULL,
	`FileName` MEDIUMTEXT NOT NULL,
	`FileExtension` VARCHAR NOT NULL,
	`Revision` VARCHAR NOT NULL,
	`ChangeNumber` INT NOT NULL,
	`Status` TINYINT NOT NULL,
	`DocumentSummary` MEDIUMTEXT,
	`Document` BLOB,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`DocumentID`)
);

CREATE TABLE `adventureworks_errorlog` (
	`ErrorLogID` INT NOT NULL,
	`ErrorTime` TIMESTAMP NOT NULL,
	`UserName` VARCHAR NOT NULL,
	`ErrorNumber` INT NOT NULL,
	`ErrorSeverity` INT,
	`ErrorState` INT,
	`ErrorProcedure` VARCHAR,
	`ErrorLine` INT,
	`ErrorMessage` MEDIUMTEXT NOT NULL,
	PRIMARY KEY(`ErrorLogID`)
);

CREATE TABLE `adventureworks_illustration` (
	`IllustrationID` INT NOT NULL,
	`Diagram` TEXT,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`IllustrationID`)
);

CREATE TABLE `adventureworks_location` (
	`LocationID` SMALLINT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`CostRate` DOUBLE NOT NULL,
	`Availability` DECIMAL NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`LocationID`)
);

CREATE TABLE `adventureworks_productcategory` (
	`ProductCategoryID` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductCategoryID`)
);

CREATE TABLE `adventureworks_productdescription` (
	`ProductDescriptionID` INT NOT NULL,
	`Description` MEDIUMTEXT NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductDescriptionID`)
);

CREATE TABLE `adventureworks_productmodel` (
	`ProductModelID` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`CatalogDescription` TEXT,
	`Instructions` TEXT,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductModelID`)
);

CREATE TABLE `adventureworks_productphoto` (
	`ProductPhotoID` INT NOT NULL,
	`ThumbNailPhoto` BLOB,
	`ThumbnailPhotoFileName` VARCHAR,
	`LargePhoto` BLOB,
	`LargePhotoFileName` VARCHAR,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductPhotoID`)
);

CREATE TABLE `adventureworks_salesreason` (
	`SalesReasonID` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`ReasonType` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SalesReasonID`)
);

CREATE TABLE `adventureworks_salestaxrate` (
	`SalesTaxRateID` INT NOT NULL,
	`StateProvinceID` INT NOT NULL,
	`TaxType` TINYINT NOT NULL,
	`TaxRate` DOUBLE NOT NULL,
	`Name` VARCHAR NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SalesTaxRateID`)
);

CREATE TABLE `adventureworks_scrapreason` (
	`ScrapReasonID` SMALLINT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ScrapReasonID`)
);

CREATE TABLE `adventureworks_shift` (
	`ShiftID` TINYINT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`StartTime` DATETIME NOT NULL,
	`EndTime` DATETIME NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ShiftID`)
);

CREATE TABLE `adventureworks_shipmethod` (
	`ShipMethodID` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`ShipBase` DOUBLE NOT NULL,
	`ShipRate` DOUBLE NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ShipMethodID`)
);

CREATE TABLE `adventureworks_specialoffer` (
	`SpecialOfferID` INT NOT NULL,
	`Description` VARCHAR NOT NULL,
	`DiscountPct` DOUBLE NOT NULL,
	`Type` VARCHAR NOT NULL,
	`Category` VARCHAR NOT NULL,
	`StartDate` DATETIME NOT NULL,
	`EndDate` DATETIME NOT NULL,
	`MinQty` INT NOT NULL,
	`MaxQty` INT,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SpecialOfferID`)
);

CREATE TABLE `adventureworks_unitmeasure` (
	`UnitMeasureCode` VARCHAR NOT NULL,
	`Name` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`UnitMeasureCode`)
);

CREATE TABLE `adventureworks_vendor` (
	`VendorID` INT NOT NULL,
	`AccountNumber` VARCHAR NOT NULL,
	`Name` VARCHAR NOT NULL,
	`CreditRating` TINYINT NOT NULL,
	`PreferredVendorStatus` BIT NOT NULL,
	`ActiveFlag` BIT NOT NULL,
	`PurchasingWebServiceURL` MEDIUMTEXT,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`VendorID`)
);

CREATE TABLE `adventureworks_contactcreditcard` (
	`ContactID` INT NOT NULL,
	`CreditCardID` INT NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ContactID`,`CreditCardID`),
	FOREIGN KEY (`ContactID`) REFERENCES `adventureworks_contact`(`ContactID`),
	FOREIGN KEY (`CreditCardID`) REFERENCES `adventureworks_creditcard`(`CreditCardID`)
);

CREATE TABLE `adventureworks_employee` (
	`EmployeeID` INT NOT NULL,
	`NationalIDNumber` VARCHAR NOT NULL,
	`ContactID` INT NOT NULL,
	`LoginID` VARCHAR NOT NULL,
	`ManagerID` INT,
	`Title` VARCHAR NOT NULL,
	`BirthDate` DATETIME NOT NULL,
	`MaritalStatus` VARCHAR NOT NULL,
	`Gender` VARCHAR NOT NULL,
	`HireDate` DATETIME NOT NULL,
	`SalariedFlag` BIT NOT NULL,
	`VacationHours` SMALLINT NOT NULL,
	`SickLeaveHours` SMALLINT NOT NULL,
	`CurrentFlag` BIT NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`EmployeeID`),
	FOREIGN KEY (`ContactID`) REFERENCES `adventureworks_contact`(`ContactID`)
);

CREATE TABLE `adventureworks_productmodelillustration` (
	`ProductModelID` INT NOT NULL,
	`IllustrationID` INT NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductModelID`,`IllustrationID`),
	FOREIGN KEY (`IllustrationID`) REFERENCES `adventureworks_illustration`(`IllustrationID`),
	FOREIGN KEY (`ProductModelID`) REFERENCES `adventureworks_productmodel`(`ProductModelID`)
);

CREATE TABLE `adventureworks_productmodelproductdescriptionculture` (
	`ProductModelID` INT NOT NULL,
	`ProductDescriptionID` INT NOT NULL,
	`CultureID` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductModelID`,`ProductDescriptionID`,`CultureID`),
	FOREIGN KEY (`CultureID`) REFERENCES `adventureworks_culture`(`CultureID`),
	FOREIGN KEY (`ProductDescriptionID`) REFERENCES `adventureworks_productdescription`(`ProductDescriptionID`),
	FOREIGN KEY (`ProductModelID`) REFERENCES `adventureworks_productmodel`(`ProductModelID`)
);

CREATE TABLE `adventureworks_salesterritory` (
	`TerritoryID` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`CountryRegionCode` VARCHAR NOT NULL,
	`Group` VARCHAR NOT NULL,
	`SalesYTD` DOUBLE NOT NULL,
	`SalesLastYear` DOUBLE NOT NULL,
	`CostYTD` DOUBLE NOT NULL,
	`CostLastYear` DOUBLE NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`TerritoryID`),
	FOREIGN KEY (`CountryRegionCode`) REFERENCES `adventureworks_countryregion`(`CountryRegionCode`)
);

CREATE TABLE `adventureworks_vendorcontact` (
	`VendorID` INT NOT NULL,
	`ContactID` INT NOT NULL,
	`ContactTypeID` INT NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`VendorID`,`ContactID`),
	FOREIGN KEY (`ContactID`) REFERENCES `adventureworks_contact`(`ContactID`)
);

CREATE TABLE `adventureworks_customer` (
	`CustomerID` INT NOT NULL,
	`TerritoryID` INT,
	`AccountNumber` VARCHAR NOT NULL,
	`CustomerType` VARCHAR NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CustomerID`),
	FOREIGN KEY (`TerritoryID`) REFERENCES `adventureworks_salesterritory`(`TerritoryID`)
);

CREATE TABLE `adventureworks_employeedepartmenthistory` (
	`EmployeeID` INT NOT NULL,
	`DepartmentID` SMALLINT NOT NULL,
	`ShiftID` TINYINT NOT NULL,
	`StartDate` DATETIME NOT NULL,
	`EndDate` DATETIME,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`EmployeeID`,`DepartmentID`,`ShiftID`,`StartDate`),
	FOREIGN KEY (`DepartmentID`) REFERENCES `adventureworks_department`(`DepartmentID`),
	FOREIGN KEY (`EmployeeID`) REFERENCES `adventureworks_employee`(`EmployeeID`),
	FOREIGN KEY (`ShiftID`) REFERENCES `adventureworks_shift`(`ShiftID`)
);

CREATE TABLE `adventureworks_employeepayhistory` (
	`EmployeeID` INT NOT NULL,
	`RateChangeDate` DATETIME NOT NULL,
	`Rate` DOUBLE NOT NULL,
	`PayFrequency` TINYINT NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`EmployeeID`,`RateChangeDate`),
	FOREIGN KEY (`EmployeeID`) REFERENCES `adventureworks_employee`(`EmployeeID`)
);

CREATE TABLE `adventureworks_jobcandidate` (
	`JobCandidateID` INT NOT NULL,
	`EmployeeID` INT,
	`Resume` TEXT,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`JobCandidateID`),
	FOREIGN KEY (`EmployeeID`) REFERENCES `adventureworks_employee`(`EmployeeID`)
);

CREATE TABLE `adventureworks_product` (
	`ProductID` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`ProductNumber` VARCHAR NOT NULL,
	`MakeFlag` BIT NOT NULL,
	`FinishedGoodsFlag` BIT NOT NULL,
	`Color` VARCHAR,
	`SafetyStockLevel` SMALLINT NOT NULL,
	`ReorderPoint` SMALLINT NOT NULL,
	`StandardCost` DOUBLE NOT NULL,
	`ListPrice` DOUBLE NOT NULL,
	`Size` VARCHAR,
	`SizeUnitMeasureCode` VARCHAR,
	`WeightUnitMeasureCode` VARCHAR,
	`Weight` DECIMAL,
	`DaysToManufacture` INT NOT NULL,
	`ProductLine` VARCHAR,
	`Class` VARCHAR,
	`Style` VARCHAR,
	`ProductSubcategoryID` INT,
	`ProductModelID` INT,
	`SellStartDate` DATETIME NOT NULL,
	`SellEndDate` DATETIME,
	`DiscontinuedDate` DATETIME,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductID`),
	FOREIGN KEY (`ProductModelID`) REFERENCES `adventureworks_productmodel`(`ProductModelID`)
);

CREATE TABLE `adventureworks_purchaseorderheader` (
	`PurchaseOrderID` INT NOT NULL,
	`RevisionNumber` TINYINT,
	`Status` TINYINT,
	`EmployeeID` INT,
	`VendorID` INT,
	`ShipMethodID` INT,
	`OrderDate` DATETIME,
	`ShipDate` DATETIME,
	`SubTotal` DOUBLE,
	`TaxAmt` DOUBLE,
	`Freight` DOUBLE,
	`TotalDue` DOUBLE,
	`ModifiedDate` DATETIME,
	PRIMARY KEY(`PurchaseOrderID`)
);

CREATE TABLE `adventureworks_salesperson` (
	`SalesPersonID` INT NOT NULL,
	`TerritoryID` INT,
	`SalesQuota` DOUBLE,
	`Bonus` DOUBLE NOT NULL,
	`CommissionPct` DOUBLE NOT NULL,
	`SalesYTD` DOUBLE NOT NULL,
	`SalesLastYear` DOUBLE NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SalesPersonID`)
);

CREATE TABLE `adventureworks_salesterritoryhistory` (
	`SalesPersonID` INT NOT NULL,
	`TerritoryID` INT NOT NULL,
	`StartDate` DATETIME NOT NULL,
	`EndDate` DATETIME,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SalesPersonID`,`TerritoryID`,`StartDate`)
);

CREATE TABLE `adventureworks_stateprovince` (
	`StateProvinceID` INT NOT NULL,
	`StateProvinceCode` VARCHAR NOT NULL,
	`CountryRegionCode` VARCHAR NOT NULL,
	`IsOnlyStateProvinceFlag` BIT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`TerritoryID` INT NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`StateProvinceID`)
);

CREATE TABLE `adventureworks_address` (
	`AddressID` INT NOT NULL,
	`AddressLine1` VARCHAR NOT NULL,
	`AddressLine2` VARCHAR,
	`City` VARCHAR NOT NULL,
	`StateProvinceID` INT NOT NULL,
	`PostalCode` VARCHAR NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`AddressID`)
);

CREATE TABLE `adventureworks_billofmaterials` (
	`BillOfMaterialsID` INT NOT NULL,
	`ProductAssemblyID` INT,
	`ComponentID` INT NOT NULL,
	`StartDate` DATETIME NOT NULL,
	`EndDate` DATETIME,
	`UnitMeasureCode` VARCHAR NOT NULL,
	`BOMLevel` SMALLINT NOT NULL,
	`PerAssemblyQty` DECIMAL NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`BillOfMaterialsID`)
);

CREATE TABLE `adventureworks_individual` (
	`CustomerID` INT NOT NULL,
	`ContactID` INT NOT NULL,
	`Demographics` TEXT,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CustomerID`)
);

CREATE TABLE `adventureworks_productcosthistory` (
	`ProductID` INT NOT NULL,
	`StartDate` DATETIME NOT NULL,
	`EndDate` DATETIME,
	`StandardCost` DOUBLE NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductID`,`StartDate`)
);

CREATE TABLE `adventureworks_productdocument` (
	`ProductID` INT NOT NULL,
	`DocumentID` INT NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductID`,`DocumentID`)
);

CREATE TABLE `adventureworks_productinventory` (
	`ProductID` INT NOT NULL,
	`LocationID` SMALLINT NOT NULL,
	`Shelf` VARCHAR NOT NULL,
	`Bin` TINYINT NOT NULL,
	`Quantity` SMALLINT NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductID`,`LocationID`)
);

CREATE TABLE `adventureworks_productlistpricehistory` (
	`ProductID` INT NOT NULL,
	`StartDate` DATETIME NOT NULL,
	`EndDate` DATETIME,
	`ListPrice` DOUBLE NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductID`,`StartDate`)
);

CREATE TABLE `adventureworks_productproductphoto` (
	`ProductID` INT NOT NULL,
	`ProductPhotoID` INT NOT NULL,
	`Primary` BIT NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductID`,`ProductPhotoID`)
);

CREATE TABLE `adventureworks_productreview` (
	`ProductReviewID` INT NOT NULL,
	`ProductID` INT NOT NULL,
	`ReviewerName` VARCHAR,
	`ReviewDate` TIMESTAMP NOT NULL,
	`EmailAddress` VARCHAR,
	`Rating` INT NOT NULL,
	`Comments` MEDIUMTEXT,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductReviewID`)
);

CREATE TABLE `adventureworks_productvendor` (
	`ProductID` INT NOT NULL,
	`VendorID` INT NOT NULL,
	`AverageLeadTime` INT NOT NULL,
	`StandardPrice` DOUBLE NOT NULL,
	`LastReceiptCost` DOUBLE,
	`LastReceiptDate` DATETIME,
	`MinOrderQty` INT,
	`MaxOrderQty` INT NOT NULL,
	`OnOrderQty` INT,
	`UnitMeasureCode` VARCHAR NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ProductID`,`VendorID`)
);

CREATE TABLE `adventureworks_purchaseorderdetail` (
	`PurchaseOrderID` INT NOT NULL,
	`PurchaseOrderDetailID` INT NOT NULL,
	`DueDate` DATETIME NOT NULL,
	`OrderQty` SMALLINT NOT NULL,
	`ProductID` INT NOT NULL,
	`UnitPrice` DOUBLE NOT NULL,
	`LineTotal` DOUBLE NOT NULL,
	`ReceivedQty` DECIMAL NOT NULL,
	`RejectedQty` DECIMAL NOT NULL,
	`StockedQty` DECIMAL NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`PurchaseOrderID`,`PurchaseOrderDetailID`)
);

CREATE TABLE `adventureworks_salespersonquotahistory` (
	`SalesPersonID` INT NOT NULL,
	`QuotaDate` DATETIME NOT NULL,
	`SalesQuota` DOUBLE NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SalesPersonID`,`QuotaDate`)
);

CREATE TABLE `adventureworks_shoppingcartitem` (
	`ShoppingCartItemID` INT NOT NULL,
	`ShoppingCartID` VARCHAR NOT NULL,
	`Quantity` INT NOT NULL,
	`ProductID` INT NOT NULL,
	`DateCreated` TIMESTAMP NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`ShoppingCartItemID`)
);

CREATE TABLE `adventureworks_specialofferproduct` (
	`SpecialOfferID` INT NOT NULL,
	`ProductID` INT NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SpecialOfferID`,`ProductID`)
);

CREATE TABLE `adventureworks_store` (
	`CustomerID` INT NOT NULL,
	`Name` VARCHAR NOT NULL,
	`SalesPersonID` INT,
	`Demographics` TEXT,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CustomerID`)
);

CREATE TABLE `adventureworks_storecontact` (
	`CustomerID` INT NOT NULL,
	`ContactID` INT NOT NULL,
	`ContactTypeID` INT NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CustomerID`,`ContactID`)
);

CREATE TABLE `adventureworks_transactionhistory` (
	`TransactionID` INT NOT NULL,
	`ProductID` INT NOT NULL,
	`ReferenceOrderID` INT NOT NULL,
	`ReferenceOrderLineID` INT NOT NULL,
	`TransactionDate` TIMESTAMP NOT NULL,
	`TransactionType` VARCHAR NOT NULL,
	`Quantity` INT NOT NULL,
	`ActualCost` DOUBLE NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`TransactionID`)
);

CREATE TABLE `adventureworks_transactionhistoryarchive` (
	`TransactionID` INT NOT NULL,
	`ProductID` INT NOT NULL,
	`ReferenceOrderID` INT NOT NULL,
	`ReferenceOrderLineID` INT NOT NULL,
	`TransactionDate` TIMESTAMP NOT NULL,
	`TransactionType` VARCHAR NOT NULL,
	`Quantity` INT NOT NULL,
	`ActualCost` DOUBLE NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`TransactionID`)
);

CREATE TABLE `adventureworks_workorder` (
	`WorkOrderID` INT NOT NULL,
	`ProductID` INT NOT NULL,
	`OrderQty` INT NOT NULL,
	`StockedQty` INT NOT NULL,
	`ScrappedQty` SMALLINT NOT NULL,
	`StartDate` DATETIME NOT NULL,
	`EndDate` DATETIME,
	`DueDate` DATETIME NOT NULL,
	`ScrapReasonID` SMALLINT,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`WorkOrderID`)
);

CREATE TABLE `adventureworks_customeraddress` (
	`CustomerID` INT NOT NULL,
	`AddressID` INT NOT NULL,
	`AddressTypeID` INT NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`CustomerID`,`AddressID`)
);

CREATE TABLE `adventureworks_employeeaddress` (
	`EmployeeID` INT NOT NULL,
	`AddressID` INT NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`EmployeeID`,`AddressID`)
);

CREATE TABLE `adventureworks_salesorderheader` (
	`SalesOrderID` INT NOT NULL,
	`RevisionNumber` TINYINT NOT NULL,
	`OrderDate` TIMESTAMP NOT NULL,
	`DueDate` DATETIME NOT NULL,
	`ShipDate` DATETIME NOT NULL,
	`Status` TINYINT NOT NULL,
	`OnlineOrderFlag` BIT NOT NULL,
	`SalesOrderNumber` VARCHAR NOT NULL,
	`PurchaseOrderNumber` VARCHAR,
	`AccountNumber` VARCHAR,
	`CustomerID` INT NOT NULL,
	`ContactID` INT NOT NULL,
	`SalesPersonID` INT,
	`TerritoryID` INT,
	`BillToAddressID` INT NOT NULL,
	`ShipToAddressID` INT NOT NULL,
	`ShipMethodID` INT NOT NULL,
	`CreditCardID` INT,
	`CreditCardApprovalCode` VARCHAR,
	`CurrencyRateID` INT,
	`SubTotal` DOUBLE NOT NULL,
	`TaxAmt` DOUBLE NOT NULL,
	`Freight` DOUBLE NOT NULL,
	`TotalDue` DOUBLE NOT NULL,
	`Comment` VARCHAR,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SalesOrderID`)
);

CREATE TABLE `adventureworks_vendoraddress` (
	`VendorID` INT NOT NULL,
	`AddressID` INT NOT NULL,
	`AddressTypeID` INT NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`VendorID`,`AddressID`)
);

CREATE TABLE `adventureworks_workorderrouting` (
	`WorkOrderID` INT NOT NULL,
	`ProductID` INT NOT NULL,
	`OperationSequence` SMALLINT NOT NULL,
	`LocationID` SMALLINT NOT NULL,
	`ScheduledStartDate` DATETIME NOT NULL,
	`ScheduledEndDate` DATETIME NOT NULL,
	`ActualStartDate` DATETIME,
	`ActualEndDate` DATETIME,
	`ActualResourceHrs` DECIMAL,
	`PlannedCost` DOUBLE NOT NULL,
	`ActualCost` DOUBLE,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`WorkOrderID`,`ProductID`,`OperationSequence`)
);

CREATE TABLE `adventureworks_salesorderdetail` (
	`SalesOrderID` INT NOT NULL,
	`SalesOrderDetailID` INT NOT NULL,
	`CarrierTrackingNumber` VARCHAR,
	`OrderQty` SMALLINT NOT NULL,
	`ProductID` INT NOT NULL,
	`SpecialOfferID` INT NOT NULL,
	`UnitPrice` DOUBLE NOT NULL,
	`UnitPriceDiscount` DOUBLE NOT NULL,
	`LineTotal` DOUBLE NOT NULL,
	`rowguid` VARBINARY NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SalesOrderID`,`SalesOrderDetailID`)
);

CREATE TABLE `adventureworks_salesorderheadersalesreason` (
	`SalesOrderID` INT NOT NULL,
	`SalesReasonID` INT NOT NULL,
	`ModifiedDate` TIMESTAMP NOT NULL,
	PRIMARY KEY(`SalesOrderID`,`SalesReasonID`)
);

