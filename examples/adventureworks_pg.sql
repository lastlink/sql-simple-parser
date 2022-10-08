/*
sql generated using:
 * Package: @funktechno/little-mermaid-2-the-sql
 * Version: 0.0.3
 * databaseInfo: postgres
*/

CREATE TABLE "humanresources_department" (
	"departmentid" serial NOT NULL,
	"name" Name NOT NULL,
	"groupname" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("departmentid")
);

CREATE TABLE "humanresources_shift" (
	"shiftid" serial NOT NULL,
	"name" Name NOT NULL,
	"starttime" time NOT NULL,
	"endtime" time NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("shiftid")
);

CREATE TABLE "person_addresstype" (
	"addresstypeid" serial NOT NULL,
	"name" Name NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("addresstypeid")
);

CREATE TABLE "person_businessentity" (
	"businessentityid" serial NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid")
);

CREATE TABLE "person_contacttype" (
	"contacttypeid" serial NOT NULL,
	"name" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("contacttypeid")
);

CREATE TABLE "person_countryregion" (
	"countryregioncode" varchar NOT NULL,
	"name" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("countryregioncode")
);

CREATE TABLE "person_phonenumbertype" (
	"phonenumbertypeid" serial NOT NULL,
	"name" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("phonenumbertypeid")
);

CREATE TABLE "production_culture" (
	"cultureid" bpchar NOT NULL,
	"name" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("cultureid")
);

CREATE TABLE "production_illustration" (
	"illustrationid" serial NOT NULL,
	"diagram" xml,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("illustrationid")
);

CREATE TABLE "production_location" (
	"locationid" serial NOT NULL,
	"name" Name NOT NULL,
	"costrate" numeric NOT NULL,
	"availability" numeric NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("locationid")
);

CREATE TABLE "production_productcategory" (
	"productcategoryid" serial NOT NULL,
	"name" Name NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productcategoryid")
);

CREATE TABLE "production_productdescription" (
	"productdescriptionid" serial NOT NULL,
	"description" varchar NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productdescriptionid")
);

CREATE TABLE "production_productmodel" (
	"productmodelid" serial NOT NULL,
	"name" Name NOT NULL,
	"catalogdescription" xml,
	"instructions" xml,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productmodelid")
);

CREATE TABLE "production_productphoto" (
	"productphotoid" serial NOT NULL,
	"thumbnailphoto" bytea,
	"thumbnailphotofilename" varchar,
	"largephoto" bytea,
	"largephotofilename" varchar,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productphotoid")
);

CREATE TABLE "production_productreview" (
	"productreviewid" serial NOT NULL,
	"productid" int(4) NOT NULL,
	"reviewername" Name NOT NULL,
	"reviewdate" timestamp NOT NULL,
	"emailaddress" varchar NOT NULL,
	"rating" int(4) NOT NULL,
	"comments" varchar,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productreviewid")
);

CREATE TABLE "production_scrapreason" (
	"scrapreasonid" serial NOT NULL,
	"name" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("scrapreasonid")
);

CREATE TABLE "production_transactionhistoryarchive" (
	"transactionid" int(4) NOT NULL,
	"productid" int(4) NOT NULL,
	"referenceorderid" int(4) NOT NULL,
	"referenceorderlineid" int(4) NOT NULL,
	"transactiondate" timestamp NOT NULL,
	"transactiontype" bpchar NOT NULL,
	"quantity" int(4) NOT NULL,
	"actualcost" numeric NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("transactionid")
);

CREATE TABLE "production_unitmeasure" (
	"unitmeasurecode" bpchar NOT NULL,
	"name" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("unitmeasurecode")
);

CREATE TABLE "purchasing_shipmethod" (
	"shipmethodid" serial NOT NULL,
	"name" Name NOT NULL,
	"shipbase" numeric NOT NULL,
	"shiprate" numeric NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("shipmethodid")
);

CREATE TABLE "sales_creditcard" (
	"creditcardid" serial NOT NULL,
	"cardtype" varchar NOT NULL,
	"cardnumber" varchar NOT NULL,
	"expmonth" int(2) NOT NULL,
	"expyear" int(2) NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("creditcardid")
);

CREATE TABLE "sales_currency" (
	"currencycode" bpchar NOT NULL,
	"name" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("currencycode")
);

CREATE TABLE "sales_salesreason" (
	"salesreasonid" serial NOT NULL,
	"name" Name NOT NULL,
	"reasontype" Name NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("salesreasonid")
);

CREATE TABLE "sales_specialoffer" (
	"specialofferid" serial NOT NULL,
	"description" varchar NOT NULL,
	"discountpct" numeric NOT NULL,
	"type" varchar NOT NULL,
	"category" varchar NOT NULL,
	"startdate" timestamp NOT NULL,
	"enddate" timestamp NOT NULL,
	"minqty" int(4) NOT NULL,
	"maxqty" int(4),
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("specialofferid")
);

CREATE TABLE "person_person" (
	"businessentityid" int(4) NOT NULL,
	"persontype" bpchar NOT NULL,
	"namestyle" NameStyle NOT NULL,
	"title" varchar,
	"firstname" Name NOT NULL,
	"middlename" Name,
	"lastname" Name NOT NULL,
	"suffix" varchar,
	"emailpromotion" int(4) NOT NULL,
	"additionalcontactinfo" xml,
	"demographics" xml,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid"),
	FOREIGN KEY ("person_person_businessentityid") REFERENCES "person_businessentity"("businessentityid")
);

CREATE TABLE "production_productmodelillustration" (
	"productmodelid" int(4) NOT NULL,
	"illustrationid" int(4) NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productmodelid","illustrationid"),
	FOREIGN KEY ("illustrationid") REFERENCES "production_illustration"("illustrationid"),
	FOREIGN KEY ("productmodelid") REFERENCES "production_productmodel"("productmodelid")
);

CREATE TABLE "production_productmodelproductdescriptionculture" (
	"productmodelid" int(4) NOT NULL,
	"productdescriptionid" int(4) NOT NULL,
	"cultureid" bpchar NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productmodelid","productdescriptionid","cultureid"),
	FOREIGN KEY ("cultureid") REFERENCES "production_culture"("cultureid"),
	FOREIGN KEY ("productdescriptionid") REFERENCES "production_productdescription"("productdescriptionid"),
	FOREIGN KEY ("productmodelid") REFERENCES "production_productmodel"("productmodelid")
);

CREATE TABLE "production_productsubcategory" (
	"productsubcategoryid" serial NOT NULL,
	"productcategoryid" int(4) NOT NULL,
	"name" Name NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productsubcategoryid"),
	FOREIGN KEY ("productcategoryid") REFERENCES "production_productcategory"("productcategoryid")
);

CREATE TABLE "purchasing_vendor" (
	"businessentityid" int(4) NOT NULL,
	"accountnumber" AccountNumber NOT NULL,
	"name" Name NOT NULL,
	"creditrating" int(2) NOT NULL,
	"preferredvendorstatus" Flag NOT NULL,
	"activeflag" Flag NOT NULL,
	"purchasingwebserviceurl" varchar,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid"),
	FOREIGN KEY ("businessentityid") REFERENCES "person_businessentity"("businessentityid")
);

CREATE TABLE "sales_countryregioncurrency" (
	"countryregioncode" varchar NOT NULL,
	"currencycode" bpchar NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("countryregioncode","currencycode"),
	FOREIGN KEY ("countryregioncode") REFERENCES "person_countryregion"("countryregioncode"),
	FOREIGN KEY ("currencycode") REFERENCES "sales_currency"("currencycode")
);

CREATE TABLE "sales_currencyrate" (
	"currencyrateid" serial NOT NULL,
	"currencyratedate" timestamp NOT NULL,
	"fromcurrencycode" bpchar NOT NULL,
	"tocurrencycode" bpchar NOT NULL,
	"averagerate" numeric NOT NULL,
	"endofdayrate" numeric NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("currencyrateid"),
	FOREIGN KEY ("fromcurrencycode") REFERENCES "sales_currency"("currencycode"),
	FOREIGN KEY ("tocurrencycode") REFERENCES "sales_currency"("currencycode")
);

CREATE TABLE "sales_salesterritory" (
	"territoryid" serial NOT NULL,
	"name" Name NOT NULL,
	"countryregioncode" varchar NOT NULL,
	"group" varchar NOT NULL,
	"salesytd" numeric NOT NULL,
	"saleslastyear" numeric NOT NULL,
	"costytd" numeric NOT NULL,
	"costlastyear" numeric NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("territoryid"),
	FOREIGN KEY ("countryregioncode") REFERENCES "person_countryregion"("countryregioncode")
);

CREATE TABLE "humanresources_employee" (
	"businessentityid" int(4) NOT NULL,
	"nationalidnumber" varchar NOT NULL,
	"loginid" varchar NOT NULL,
	"jobtitle" varchar NOT NULL,
	"birthdate" date NOT NULL,
	"maritalstatus" bpchar NOT NULL,
	"gender" bpchar NOT NULL,
	"hiredate" date NOT NULL,
	"salariedflag" Flag NOT NULL,
	"vacationhours" int(2) NOT NULL,
	"sickleavehours" int(2) NOT NULL,
	"currentflag" Flag NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	"organizationnode" varchar,
	PRIMARY KEY("businessentityid"),
	FOREIGN KEY ("businessentityid") REFERENCES "person_person"("businessentityid")
);

CREATE TABLE "person_businessentitycontact" (
	"businessentityid" int(4) NOT NULL,
	"personid" int(4) NOT NULL,
	"contacttypeid" int(4) NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid","personid","contacttypeid"),
	FOREIGN KEY ("businessentityid") REFERENCES "person_businessentity"("businessentityid"),
	FOREIGN KEY ("contacttypeid") REFERENCES "person_contacttype"("contacttypeid"),
	FOREIGN KEY ("personid") REFERENCES "person_person"("businessentityid")
);

CREATE TABLE "person_emailaddress" (
	"businessentityid" int(4) NOT NULL,
	"emailaddressid" serial NOT NULL,
	"emailaddress" varchar,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid","emailaddressid"),
	FOREIGN KEY ("businessentityid") REFERENCES "person_person"("businessentityid")
);

CREATE TABLE "person_password" (
	"businessentityid" int(4) NOT NULL,
	"passwordhash" varchar NOT NULL,
	"passwordsalt" varchar NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid"),
	FOREIGN KEY ("businessentityid") REFERENCES "person_person"("businessentityid")
);

CREATE TABLE "person_personphone" (
	"businessentityid" int(4) NOT NULL,
	"phonenumber" Phone NOT NULL,
	"phonenumbertypeid" int(4) NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid","phonenumber","phonenumbertypeid"),
	FOREIGN KEY ("businessentityid") REFERENCES "person_person"("businessentityid"),
	FOREIGN KEY ("phonenumbertypeid") REFERENCES "person_phonenumbertype"("phonenumbertypeid")
);

CREATE TABLE "person_stateprovince" (
	"stateprovinceid" serial NOT NULL,
	"stateprovincecode" bpchar NOT NULL,
	"countryregioncode" varchar NOT NULL,
	"isonlystateprovinceflag" Flag NOT NULL,
	"name" Name NOT NULL,
	"territoryid" int(4) NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("stateprovinceid"),
	FOREIGN KEY ("countryregioncode") REFERENCES "person_countryregion"("countryregioncode"),
	FOREIGN KEY ("territoryid") REFERENCES "sales_salesterritory"("territoryid")
);

CREATE TABLE "production_product" (
	"productid" serial NOT NULL,
	"name" Name NOT NULL,
	"productnumber" varchar NOT NULL,
	"makeflag" Flag NOT NULL,
	"finishedgoodsflag" Flag NOT NULL,
	"color" varchar,
	"safetystocklevel" int(2) NOT NULL,
	"reorderpoint" int(2) NOT NULL,
	"standardcost" numeric NOT NULL,
	"listprice" numeric NOT NULL,
	"size" varchar,
	"sizeunitmeasurecode" bpchar,
	"weightunitmeasurecode" bpchar,
	"weight" numeric,
	"daystomanufacture" int(4) NOT NULL,
	"productline" bpchar,
	"class" bpchar,
	"style" bpchar,
	"productsubcategoryid" int(4),
	"productmodelid" int(4),
	"sellstartdate" timestamp NOT NULL,
	"sellenddate" timestamp,
	"discontinueddate" timestamp,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productid"),
	FOREIGN KEY ("productmodelid") REFERENCES "production_productmodel"("productmodelid"),
	FOREIGN KEY ("productsubcategoryid") REFERENCES "production_productsubcategory"("productsubcategoryid"),
	FOREIGN KEY ("sizeunitmeasurecode") REFERENCES "production_unitmeasure"("unitmeasurecode"),
	FOREIGN KEY ("weightunitmeasurecode") REFERENCES "production_unitmeasure"("unitmeasurecode")
);

CREATE TABLE "sales_personcreditcard" (
	"businessentityid" int(4) NOT NULL,
	"creditcardid" int(4) NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid","creditcardid"),
	FOREIGN KEY ("businessentityid") REFERENCES "person_person"("businessentityid"),
	FOREIGN KEY ("creditcardid") REFERENCES "sales_creditcard"("creditcardid")
);

CREATE TABLE "humanresources_employeedepartmenthistory" (
	"businessentityid" int(4) NOT NULL,
	"departmentid" int(2) NOT NULL,
	"shiftid" int(2) NOT NULL,
	"startdate" date NOT NULL,
	"enddate" date,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid","departmentid","shiftid","startdate"),
	FOREIGN KEY ("businessentityid") REFERENCES "humanresources_employee"("businessentityid"),
	FOREIGN KEY ("departmentid") REFERENCES "humanresources_department"("departmentid"),
	FOREIGN KEY ("shiftid") REFERENCES "humanresources_shift"("shiftid")
);

CREATE TABLE "humanresources_employeepayhistory" (
	"businessentityid" int(4) NOT NULL,
	"ratechangedate" timestamp NOT NULL,
	"rate" numeric NOT NULL,
	"payfrequency" int(2) NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid","ratechangedate"),
	FOREIGN KEY ("businessentityid") REFERENCES "humanresources_employee"("businessentityid")
);

CREATE TABLE "humanresources_jobcandidate" (
	"jobcandidateid" serial NOT NULL,
	"businessentityid" int(4),
	"resume" xml,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("jobcandidateid"),
	FOREIGN KEY ("businessentityid") REFERENCES "humanresources_employee"("businessentityid")
);

CREATE TABLE "person_address" (
	"addressid" serial NOT NULL,
	"addressline1" varchar NOT NULL,
	"addressline2" varchar,
	"city" varchar NOT NULL,
	"stateprovinceid" int(4) NOT NULL,
	"postalcode" varchar NOT NULL,
	"spatiallocation" varchar,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("addressid"),
	FOREIGN KEY ("stateprovinceid") REFERENCES "person_stateprovince"("stateprovinceid")
);

CREATE TABLE "production_billofmaterials" (
	"billofmaterialsid" serial NOT NULL,
	"productassemblyid" int(4),
	"componentid" int(4) NOT NULL,
	"startdate" timestamp NOT NULL,
	"enddate" timestamp,
	"unitmeasurecode" bpchar NOT NULL,
	"bomlevel" int(2) NOT NULL,
	"perassemblyqty" numeric NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("billofmaterialsid"),
	FOREIGN KEY ("componentid") REFERENCES "production_product"("productid"),
	FOREIGN KEY ("productassemblyid") REFERENCES "production_product"("productid"),
	FOREIGN KEY ("unitmeasurecode") REFERENCES "production_unitmeasure"("unitmeasurecode")
);

CREATE TABLE "production_document" (
	"title" varchar NOT NULL,
	"owner" int(4) NOT NULL,
	"folderflag" Flag NOT NULL,
	"filename" varchar NOT NULL,
	"fileextension" varchar,
	"revision" bpchar NOT NULL,
	"changenumber" int(4) NOT NULL,
	"status" int(2) NOT NULL,
	"documentsummary" text,
	"document" bytea,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	"documentnode" varchar NOT NULL,
	PRIMARY KEY("documentnode"),
	FOREIGN KEY ("owner") REFERENCES "humanresources_employee"("businessentityid")
);

CREATE TABLE "production_productcosthistory" (
	"productid" int(4) NOT NULL,
	"startdate" timestamp NOT NULL,
	"enddate" timestamp,
	"standardcost" numeric NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productid","startdate"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid")
);

CREATE TABLE "production_productinventory" (
	"productid" int(4) NOT NULL,
	"locationid" int(2) NOT NULL,
	"shelf" varchar NOT NULL,
	"bin" int(2) NOT NULL,
	"quantity" int(2) NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productid","locationid"),
	FOREIGN KEY ("locationid") REFERENCES "production_location"("locationid"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid")
);

CREATE TABLE "production_productlistpricehistory" (
	"productid" int(4) NOT NULL,
	"startdate" timestamp NOT NULL,
	"enddate" timestamp,
	"listprice" numeric NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productid","startdate"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid")
);

CREATE TABLE "production_productproductphoto" (
	"productid" int(4) NOT NULL,
	"productphotoid" int(4) NOT NULL,
	"primary" Flag NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productid","productphotoid"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid"),
	FOREIGN KEY ("productphotoid") REFERENCES "production_productphoto"("productphotoid")
);

CREATE TABLE "production_transactionhistory" (
	"transactionid" serial NOT NULL,
	"productid" int(4) NOT NULL,
	"referenceorderid" int(4) NOT NULL,
	"referenceorderlineid" int(4) NOT NULL,
	"transactiondate" timestamp NOT NULL,
	"transactiontype" bpchar NOT NULL,
	"quantity" int(4) NOT NULL,
	"actualcost" numeric NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("transactionid"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid")
);

CREATE TABLE "production_workorder" (
	"workorderid" serial NOT NULL,
	"productid" int(4) NOT NULL,
	"orderqty" int(4) NOT NULL,
	"scrappedqty" int(2) NOT NULL,
	"startdate" timestamp NOT NULL,
	"enddate" timestamp,
	"duedate" timestamp NOT NULL,
	"scrapreasonid" int(2),
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("workorderid"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid"),
	FOREIGN KEY ("scrapreasonid") REFERENCES "production_scrapreason"("scrapreasonid")
);

CREATE TABLE "purchasing_productvendor" (
	"productid" int(4) NOT NULL,
	"businessentityid" int(4) NOT NULL,
	"averageleadtime" int(4) NOT NULL,
	"standardprice" numeric NOT NULL,
	"lastreceiptcost" numeric,
	"lastreceiptdate" timestamp,
	"minorderqty" int(4) NOT NULL,
	"maxorderqty" int(4) NOT NULL,
	"onorderqty" int(4),
	"unitmeasurecode" bpchar NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("productid","businessentityid"),
	FOREIGN KEY ("businessentityid") REFERENCES "purchasing_vendor"("businessentityid"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid"),
	FOREIGN KEY ("unitmeasurecode") REFERENCES "production_unitmeasure"("unitmeasurecode")
);

CREATE TABLE "purchasing_purchaseorderheader" (
	"purchaseorderid" serial NOT NULL,
	"revisionnumber" int(2) NOT NULL,
	"status" int(2) NOT NULL,
	"employeeid" int(4) NOT NULL,
	"vendorid" int(4) NOT NULL,
	"shipmethodid" int(4) NOT NULL,
	"orderdate" timestamp NOT NULL,
	"shipdate" timestamp,
	"subtotal" numeric NOT NULL,
	"taxamt" numeric NOT NULL,
	"freight" numeric NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("purchaseorderid"),
	FOREIGN KEY ("employeeid") REFERENCES "humanresources_employee"("businessentityid"),
	FOREIGN KEY ("shipmethodid") REFERENCES "purchasing_shipmethod"("shipmethodid"),
	FOREIGN KEY ("vendorid") REFERENCES "purchasing_vendor"("businessentityid")
);

CREATE TABLE "sales_salesperson" (
	"businessentityid" int(4) NOT NULL,
	"territoryid" int(4),
	"salesquota" numeric,
	"bonus" numeric NOT NULL,
	"commissionpct" numeric NOT NULL,
	"salesytd" numeric NOT NULL,
	"saleslastyear" numeric NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid"),
	FOREIGN KEY ("businessentityid") REFERENCES "humanresources_employee"("businessentityid"),
	FOREIGN KEY ("territoryid") REFERENCES "sales_salesterritory"("territoryid")
);

CREATE TABLE "sales_salestaxrate" (
	"salestaxrateid" serial NOT NULL,
	"stateprovinceid" int(4) NOT NULL,
	"taxtype" int(2) NOT NULL,
	"taxrate" numeric NOT NULL,
	"name" Name NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("salestaxrateid"),
	FOREIGN KEY ("stateprovinceid") REFERENCES "person_stateprovince"("stateprovinceid")
);

CREATE TABLE "sales_shoppingcartitem" (
	"shoppingcartitemid" serial NOT NULL,
	"shoppingcartid" varchar NOT NULL,
	"quantity" int(4) NOT NULL,
	"productid" int(4) NOT NULL,
	"datecreated" timestamp NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("shoppingcartitemid"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid")
);

CREATE TABLE "sales_specialofferproduct" (
	"specialofferid" int(4) NOT NULL,
	"productid" int(4) NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("specialofferid","productid"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid"),
	FOREIGN KEY ("specialofferid") REFERENCES "sales_specialoffer"("specialofferid")
);

CREATE TABLE "person_businessentityaddress" (
	"businessentityid" int(4) NOT NULL,
	"addressid" int(4) NOT NULL,
	"addresstypeid" int(4) NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid","addressid","addresstypeid"),
	FOREIGN KEY ("addressid") REFERENCES "person_address"("addressid"),
	FOREIGN KEY ("addresstypeid") REFERENCES "person_addresstype"("addresstypeid"),
	FOREIGN KEY ("businessentityid") REFERENCES "person_businessentity"("businessentityid")
);

CREATE TABLE "production_productdocument" (
	"productid" int(4) NOT NULL,
	"modifieddate" timestamp NOT NULL,
	"documentnode" varchar NOT NULL,
	PRIMARY KEY("productid","documentnode"),
	FOREIGN KEY ("documentnode") REFERENCES "production_document"("documentnode"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid")
);

CREATE TABLE "production_workorderrouting" (
	"workorderid" int(4) NOT NULL,
	"productid" int(4) NOT NULL,
	"operationsequence" int(2) NOT NULL,
	"locationid" int(2) NOT NULL,
	"scheduledstartdate" timestamp NOT NULL,
	"scheduledenddate" timestamp NOT NULL,
	"actualstartdate" timestamp,
	"actualenddate" timestamp,
	"actualresourcehrs" numeric,
	"plannedcost" numeric NOT NULL,
	"actualcost" numeric,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("workorderid","productid","operationsequence"),
	FOREIGN KEY ("locationid") REFERENCES "production_location"("locationid"),
	FOREIGN KEY ("workorderid") REFERENCES "production_workorder"("workorderid")
);

CREATE TABLE "purchasing_purchaseorderdetail" (
	"purchaseorderid" int(4) NOT NULL,
	"purchaseorderdetailid" serial NOT NULL,
	"duedate" timestamp NOT NULL,
	"orderqty" int(2) NOT NULL,
	"productid" int(4) NOT NULL,
	"unitprice" numeric NOT NULL,
	"receivedqty" numeric NOT NULL,
	"rejectedqty" numeric NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("purchaseorderid","purchaseorderdetailid"),
	FOREIGN KEY ("productid") REFERENCES "production_product"("productid"),
	FOREIGN KEY ("purchaseorderid") REFERENCES "purchasing_purchaseorderheader"("purchaseorderid")
);

CREATE TABLE "sales_salespersonquotahistory" (
	"businessentityid" int(4) NOT NULL,
	"quotadate" timestamp NOT NULL,
	"salesquota" numeric NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid","quotadate"),
	FOREIGN KEY ("businessentityid") REFERENCES "sales_salesperson"("businessentityid")
);

CREATE TABLE "sales_salesterritoryhistory" (
	"businessentityid" int(4) NOT NULL,
	"territoryid" int(4) NOT NULL,
	"startdate" timestamp NOT NULL,
	"enddate" timestamp,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid","territoryid","startdate"),
	FOREIGN KEY ("businessentityid") REFERENCES "sales_salesperson"("businessentityid"),
	FOREIGN KEY ("territoryid") REFERENCES "sales_salesterritory"("territoryid")
);

CREATE TABLE "sales_store" (
	"businessentityid" int(4) NOT NULL,
	"name" Name NOT NULL,
	"salespersonid" int(4),
	"demographics" xml,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("businessentityid"),
	FOREIGN KEY ("businessentityid") REFERENCES "person_businessentity"("businessentityid"),
	FOREIGN KEY ("salespersonid") REFERENCES "sales_salesperson"("businessentityid")
);

CREATE TABLE "sales_customer" (
	"customerid" serial NOT NULL,
	"personid" int(4),
	"storeid" int(4),
	"territoryid" int(4),
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("customerid"),
	FOREIGN KEY ("personid") REFERENCES "person_person"("businessentityid"),
	FOREIGN KEY ("storeid") REFERENCES "sales_store"("businessentityid"),
	FOREIGN KEY ("territoryid") REFERENCES "sales_salesterritory"("territoryid")
);

CREATE TABLE "sales_salesorderheader" (
	"salesorderid" serial NOT NULL,
	"revisionnumber" int(2) NOT NULL,
	"orderdate" timestamp NOT NULL,
	"duedate" timestamp NOT NULL,
	"shipdate" timestamp,
	"status" int(2) NOT NULL,
	"onlineorderflag" Flag NOT NULL,
	"purchaseordernumber" OrderNumber,
	"accountnumber" AccountNumber,
	"customerid" int(4) NOT NULL,
	"salespersonid" int(4),
	"territoryid" int(4),
	"billtoaddressid" int(4) NOT NULL,
	"shiptoaddressid" int(4) NOT NULL,
	"shipmethodid" int(4) NOT NULL,
	"creditcardid" int(4),
	"creditcardapprovalcode" varchar,
	"currencyrateid" int(4),
	"subtotal" numeric NOT NULL,
	"taxamt" numeric NOT NULL,
	"freight" numeric NOT NULL,
	"totaldue" numeric,
	"comment" varchar,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("salesorderid"),
	FOREIGN KEY ("billtoaddressid") REFERENCES "person_address"("addressid"),
	FOREIGN KEY ("creditcardid") REFERENCES "sales_creditcard"("creditcardid"),
	FOREIGN KEY ("currencyrateid") REFERENCES "sales_currencyrate"("currencyrateid"),
	FOREIGN KEY ("customerid") REFERENCES "sales_customer"("customerid"),
	FOREIGN KEY ("salespersonid") REFERENCES "sales_salesperson"("businessentityid"),
	FOREIGN KEY ("shipmethodid") REFERENCES "purchasing_shipmethod"("shipmethodid"),
	FOREIGN KEY ("shiptoaddressid") REFERENCES "person_address"("addressid"),
	FOREIGN KEY ("territoryid") REFERENCES "sales_salesterritory"("territoryid")
);

CREATE TABLE "sales_salesorderdetail" (
	"salesorderid" int(4) NOT NULL,
	"salesorderdetailid" serial NOT NULL,
	"carriertrackingnumber" varchar,
	"orderqty" int(2) NOT NULL,
	"productid" int(4) NOT NULL,
	"specialofferid" int(4) NOT NULL,
	"unitprice" numeric NOT NULL,
	"unitpricediscount" numeric NOT NULL,
	"rowguid" uuid NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("salesorderid","salesorderdetailid"),
	FOREIGN KEY ("salesorderid") REFERENCES "sales_salesorderheader"("salesorderid"),
	FOREIGN KEY ("specialofferid, sales_salesorderdetail") REFERENCES "sales_specialofferproduct"("specialofferid, sales_specialofferproduct")
);

CREATE TABLE "sales_salesorderheadersalesreason" (
	"salesorderid" int(4) NOT NULL,
	"salesreasonid" int(4) NOT NULL,
	"modifieddate" timestamp NOT NULL,
	PRIMARY KEY("salesorderid","salesreasonid"),
	FOREIGN KEY ("salesorderid") REFERENCES "sales_salesorderheader"("salesorderid"),
	FOREIGN KEY ("salesreasonid") REFERENCES "sales_salesreason"("salesreasonid")
);

CREATE TABLE "hr_d" (
	"id" int(4),
	"departmentid" int(4),
	"name" Name,
	"groupname" Name,
	"modifieddate" timestamp
);

CREATE TABLE "hr_e" (
	"id" int(4),
	"businessentityid" int(4),
	"nationalidnumber" varchar,
	"loginid" varchar,
	"jobtitle" varchar,
	"birthdate" date,
	"maritalstatus" bpchar,
	"gender" bpchar,
	"hiredate" date,
	"salariedflag" Flag NOT NULL,
	"vacationhours" int(2),
	"sickleavehours" int(2),
	"currentflag" Flag NOT NULL,
	"rowguid" uuid,
	"modifieddate" timestamp,
	"organizationnode" varchar
);

CREATE TABLE "hr_edh" (
	"id" int(4),
	"businessentityid" int(4),
	"departmentid" int(2),
	"shiftid" int(2),
	"startdate" date,
	"enddate" date,
	"modifieddate" timestamp
);

CREATE TABLE "hr_eph" (
	"id" int(4),
	"businessentityid" int(4),
	"ratechangedate" timestamp,
	"rate" numeric,
	"payfrequency" int(2),
	"modifieddate" timestamp
);

CREATE TABLE "hr_jc" (
	"id" int(4),
	"jobcandidateid" int(4),
	"businessentityid" int(4),
	"resume" xml,
	"modifieddate" timestamp
);

CREATE TABLE "hr_s" (
	"id" int(4),
	"shiftid" int(4),
	"name" Name,
	"starttime" time,
	"endtime" time,
	"modifieddate" timestamp
);

CREATE TABLE "humanresources_vemployee" (
	"businessentityid" int(4),
	"title" varchar,
	"firstname" Name,
	"middlename" Name,
	"lastname" Name,
	"suffix" varchar,
	"jobtitle" varchar,
	"phonenumber" Phone,
	"phonenumbertype" Name,
	"emailaddress" varchar,
	"emailpromotion" int(4),
	"addressline1" varchar,
	"addressline2" varchar,
	"city" varchar,
	"stateprovincename" Name,
	"postalcode" varchar,
	"countryregionname" Name,
	"additionalcontactinfo" xml
);

CREATE TABLE "humanresources_vemployeedepartment" (
	"businessentityid" int(4),
	"title" varchar,
	"firstname" Name,
	"middlename" Name,
	"lastname" Name,
	"suffix" varchar,
	"jobtitle" varchar,
	"department" Name,
	"groupname" Name,
	"startdate" date
);

CREATE TABLE "humanresources_vemployeedepartmenthistory" (
	"businessentityid" int(4),
	"title" varchar,
	"firstname" Name,
	"middlename" Name,
	"lastname" Name,
	"suffix" varchar,
	"shift" Name,
	"department" Name,
	"groupname" Name,
	"startdate" date,
	"enddate" date
);

CREATE TABLE "humanresources_vjobcandidate" (
	"jobcandidateid" int(4),
	"businessentityid" int(4),
	"Name.Prefix" varchar,
	"Name.First" varchar,
	"Name.Middle" varchar,
	"Name.Last" varchar,
	"Name.Suffix" varchar,
	"Skills" varchar,
	"Addr.Type" varchar,
	"Addr.Loc.CountryRegion" varchar,
	"Addr.Loc.State" varchar,
	"Addr.Loc.City" varchar,
	"Addr.PostalCode" varchar,
	"EMail" varchar,
	"WebSite" varchar,
	"modifieddate" timestamp
);

CREATE TABLE "humanresources_vjobcandidateeducation" (
	"jobcandidateid" int(4),
	"Edu.Level" varchar,
	"Edu.StartDate" date,
	"Edu.EndDate" date,
	"Edu.Degree" varchar,
	"Edu.Major" varchar,
	"Edu.Minor" varchar,
	"Edu.GPA" varchar,
	"Edu.GPAScale" varchar,
	"Edu.School" varchar,
	"Edu.Loc.CountryRegion" varchar,
	"Edu.Loc.State" varchar,
	"Edu.Loc.City" varchar
);

CREATE TABLE "humanresources_vjobcandidateemployment" (
	"jobcandidateid" int(4),
	"Emp.StartDate" date,
	"Emp.EndDate" date,
	"Emp.OrgName" varchar,
	"Emp.JobTitle" varchar,
	"Emp.Responsibility" varchar,
	"Emp.FunctionCategory" varchar,
	"Emp.IndustryCategory" varchar,
	"Emp.Loc.CountryRegion" varchar,
	"Emp.Loc.State" varchar,
	"Emp.Loc.City" varchar
);

CREATE TABLE "pe_a" (
	"id" int(4),
	"addressid" int(4),
	"addressline1" varchar,
	"addressline2" varchar,
	"city" varchar,
	"stateprovinceid" int(4),
	"postalcode" varchar,
	"spatiallocation" varchar,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pe_at" (
	"id" int(4),
	"addresstypeid" int(4),
	"name" Name,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pe_be" (
	"id" int(4),
	"businessentityid" int(4),
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pe_bea" (
	"id" int(4),
	"businessentityid" int(4),
	"addressid" int(4),
	"addresstypeid" int(4),
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pe_bec" (
	"id" int(4),
	"businessentityid" int(4),
	"personid" int(4),
	"contacttypeid" int(4),
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pe_cr" (
	"countryregioncode" varchar,
	"name" Name,
	"modifieddate" timestamp
);

CREATE TABLE "pe_ct" (
	"id" int(4),
	"contacttypeid" int(4),
	"name" Name,
	"modifieddate" timestamp
);

CREATE TABLE "pe_e" (
	"id" int(4),
	"businessentityid" int(4),
	"emailaddressid" int(4),
	"emailaddress" varchar,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pe_p" (
	"id" int(4),
	"businessentityid" int(4),
	"persontype" bpchar,
	"namestyle" NameStyle NOT NULL,
	"title" varchar,
	"firstname" Name,
	"middlename" Name,
	"lastname" Name,
	"suffix" varchar,
	"emailpromotion" int(4),
	"additionalcontactinfo" xml,
	"demographics" xml,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pe_pa" (
	"id" int(4),
	"businessentityid" int(4),
	"passwordhash" varchar,
	"passwordsalt" varchar,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pe_pnt" (
	"id" int(4),
	"phonenumbertypeid" int(4),
	"name" Name,
	"modifieddate" timestamp
);

CREATE TABLE "pe_pp" (
	"id" int(4),
	"businessentityid" int(4),
	"phonenumber" Phone,
	"phonenumbertypeid" int(4),
	"modifieddate" timestamp
);

CREATE TABLE "pe_sp" (
	"id" int(4),
	"stateprovinceid" int(4),
	"stateprovincecode" bpchar,
	"countryregioncode" varchar,
	"isonlystateprovinceflag" Flag NOT NULL,
	"name" Name,
	"territoryid" int(4),
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "person_vadditionalcontactinfo" (
	"businessentityid" int(4),
	"firstname" Name,
	"middlename" Name,
	"lastname" Name,
	"telephonenumber" xml,
	"telephonespecialinstructions" text,
	"street" xml,
	"city" xml,
	"stateprovince" xml,
	"postalcode" xml,
	"countryregion" xml,
	"homeaddressspecialinstructions" xml,
	"emailaddress" xml,
	"emailspecialinstructions" text,
	"emailtelephonenumber" xml,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pr_bom" (
	"id" int(4),
	"billofmaterialsid" int(4),
	"productassemblyid" int(4),
	"componentid" int(4),
	"startdate" timestamp,
	"enddate" timestamp,
	"unitmeasurecode" bpchar,
	"bomlevel" int(2),
	"perassemblyqty" numeric,
	"modifieddate" timestamp
);

CREATE TABLE "pr_c" (
	"id" bpchar,
	"cultureid" bpchar,
	"name" Name,
	"modifieddate" timestamp
);

CREATE TABLE "pr_d" (
	"title" varchar,
	"owner" int(4),
	"folderflag" Flag NOT NULL,
	"filename" varchar,
	"fileextension" varchar,
	"revision" bpchar,
	"changenumber" int(4),
	"status" int(2),
	"documentsummary" text,
	"document" bytea,
	"rowguid" uuid,
	"modifieddate" timestamp,
	"documentnode" varchar
);

CREATE TABLE "pr_i" (
	"id" int(4),
	"illustrationid" int(4),
	"diagram" xml,
	"modifieddate" timestamp
);

CREATE TABLE "pr_l" (
	"id" int(4),
	"locationid" int(4),
	"name" Name,
	"costrate" numeric,
	"availability" numeric,
	"modifieddate" timestamp
);

CREATE TABLE "pr_p" (
	"id" int(4),
	"productid" int(4),
	"name" Name,
	"productnumber" varchar,
	"makeflag" Flag NOT NULL,
	"finishedgoodsflag" Flag NOT NULL,
	"color" varchar,
	"safetystocklevel" int(2),
	"reorderpoint" int(2),
	"standardcost" numeric,
	"listprice" numeric,
	"size" varchar,
	"sizeunitmeasurecode" bpchar,
	"weightunitmeasurecode" bpchar,
	"weight" numeric,
	"daystomanufacture" int(4),
	"productline" bpchar,
	"class" bpchar,
	"style" bpchar,
	"productsubcategoryid" int(4),
	"productmodelid" int(4),
	"sellstartdate" timestamp,
	"sellenddate" timestamp,
	"discontinueddate" timestamp,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pr_pc" (
	"id" int(4),
	"productcategoryid" int(4),
	"name" Name,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pr_pch" (
	"id" int(4),
	"productid" int(4),
	"startdate" timestamp,
	"enddate" timestamp,
	"standardcost" numeric,
	"modifieddate" timestamp
);

CREATE TABLE "pr_pd" (
	"id" int(4),
	"productdescriptionid" int(4),
	"description" varchar,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pr_pdoc" (
	"id" int(4),
	"productid" int(4),
	"modifieddate" timestamp,
	"documentnode" varchar
);

CREATE TABLE "pr_pi" (
	"id" int(4),
	"productid" int(4),
	"locationid" int(2),
	"shelf" varchar,
	"bin" int(2),
	"quantity" int(2),
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pr_plph" (
	"id" int(4),
	"productid" int(4),
	"startdate" timestamp,
	"enddate" timestamp,
	"listprice" numeric,
	"modifieddate" timestamp
);

CREATE TABLE "pr_pm" (
	"id" int(4),
	"productmodelid" int(4),
	"name" Name,
	"catalogdescription" xml,
	"instructions" xml,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pr_pmi" (
	"productmodelid" int(4),
	"illustrationid" int(4),
	"modifieddate" timestamp
);

CREATE TABLE "pr_pmpdc" (
	"productmodelid" int(4),
	"productdescriptionid" int(4),
	"cultureid" bpchar,
	"modifieddate" timestamp
);

CREATE TABLE "pr_pp" (
	"id" int(4),
	"productphotoid" int(4),
	"thumbnailphoto" bytea,
	"thumbnailphotofilename" varchar,
	"largephoto" bytea,
	"largephotofilename" varchar,
	"modifieddate" timestamp
);

CREATE TABLE "pr_ppp" (
	"productid" int(4),
	"productphotoid" int(4),
	"primary" Flag NOT NULL,
	"modifieddate" timestamp
);

CREATE TABLE "pr_pr" (
	"id" int(4),
	"productreviewid" int(4),
	"productid" int(4),
	"reviewername" Name,
	"reviewdate" timestamp,
	"emailaddress" varchar,
	"rating" int(4),
	"comments" varchar,
	"modifieddate" timestamp
);

CREATE TABLE "pr_psc" (
	"id" int(4),
	"productsubcategoryid" int(4),
	"productcategoryid" int(4),
	"name" Name,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pr_sr" (
	"id" int(4),
	"scrapreasonid" int(4),
	"name" Name,
	"modifieddate" timestamp
);

CREATE TABLE "pr_th" (
	"id" int(4),
	"transactionid" int(4),
	"productid" int(4),
	"referenceorderid" int(4),
	"referenceorderlineid" int(4),
	"transactiondate" timestamp,
	"transactiontype" bpchar,
	"quantity" int(4),
	"actualcost" numeric,
	"modifieddate" timestamp
);

CREATE TABLE "pr_tha" (
	"id" int(4),
	"transactionid" int(4),
	"productid" int(4),
	"referenceorderid" int(4),
	"referenceorderlineid" int(4),
	"transactiondate" timestamp,
	"transactiontype" bpchar,
	"quantity" int(4),
	"actualcost" numeric,
	"modifieddate" timestamp
);

CREATE TABLE "pr_um" (
	"id" bpchar,
	"unitmeasurecode" bpchar,
	"name" Name,
	"modifieddate" timestamp
);

CREATE TABLE "pr_w" (
	"id" int(4),
	"workorderid" int(4),
	"productid" int(4),
	"orderqty" int(4),
	"scrappedqty" int(2),
	"startdate" timestamp,
	"enddate" timestamp,
	"duedate" timestamp,
	"scrapreasonid" int(2),
	"modifieddate" timestamp
);

CREATE TABLE "pr_wr" (
	"id" int(4),
	"workorderid" int(4),
	"productid" int(4),
	"operationsequence" int(2),
	"locationid" int(2),
	"scheduledstartdate" timestamp,
	"scheduledenddate" timestamp,
	"actualstartdate" timestamp,
	"actualenddate" timestamp,
	"actualresourcehrs" numeric,
	"plannedcost" numeric,
	"actualcost" numeric,
	"modifieddate" timestamp
);

CREATE TABLE "production_vproductmodelcatalogdescription" (
	"productmodelid" int(4),
	"name" Name,
	"Summary" varchar,
	"manufacturer" varchar,
	"copyright" varchar,
	"producturl" varchar,
	"warrantyperiod" varchar,
	"warrantydescription" varchar,
	"noofyears" varchar,
	"maintenancedescription" varchar,
	"wheel" varchar,
	"saddle" varchar,
	"pedal" varchar,
	"bikeframe" varchar,
	"crankset" varchar,
	"pictureangle" varchar,
	"picturesize" varchar,
	"productphotoid" varchar,
	"material" varchar,
	"color" varchar,
	"productline" varchar,
	"style" varchar,
	"riderexperience" varchar,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "production_vproductmodelinstructions" (
	"productmodelid" int(4),
	"name" Name,
	"instructions" varchar,
	"LocationID" int(4),
	"SetupHours" numeric,
	"MachineHours" numeric,
	"LaborHours" numeric,
	"LotSize" int(4),
	"Step" varchar,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pu_pod" (
	"id" int(4),
	"purchaseorderid" int(4),
	"purchaseorderdetailid" int(4),
	"duedate" timestamp,
	"orderqty" int(2),
	"productid" int(4),
	"unitprice" numeric,
	"receivedqty" numeric,
	"rejectedqty" numeric,
	"modifieddate" timestamp
);

CREATE TABLE "pu_poh" (
	"id" int(4),
	"purchaseorderid" int(4),
	"revisionnumber" int(2),
	"status" int(2),
	"employeeid" int(4),
	"vendorid" int(4),
	"shipmethodid" int(4),
	"orderdate" timestamp,
	"shipdate" timestamp,
	"subtotal" numeric,
	"taxamt" numeric,
	"freight" numeric,
	"modifieddate" timestamp
);

CREATE TABLE "pu_pv" (
	"id" int(4),
	"productid" int(4),
	"businessentityid" int(4),
	"averageleadtime" int(4),
	"standardprice" numeric,
	"lastreceiptcost" numeric,
	"lastreceiptdate" timestamp,
	"minorderqty" int(4),
	"maxorderqty" int(4),
	"onorderqty" int(4),
	"unitmeasurecode" bpchar,
	"modifieddate" timestamp
);

CREATE TABLE "pu_sm" (
	"id" int(4),
	"shipmethodid" int(4),
	"name" Name,
	"shipbase" numeric,
	"shiprate" numeric,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "pu_v" (
	"id" int(4),
	"businessentityid" int(4),
	"accountnumber" AccountNumber,
	"name" Name,
	"creditrating" int(2),
	"preferredvendorstatus" Flag NOT NULL,
	"activeflag" Flag NOT NULL,
	"purchasingwebserviceurl" varchar,
	"modifieddate" timestamp
);

CREATE TABLE "purchasing_vvendorwithaddresses" (
	"businessentityid" int(4),
	"name" Name,
	"addresstype" Name,
	"addressline1" varchar,
	"addressline2" varchar,
	"city" varchar,
	"stateprovincename" Name,
	"postalcode" varchar,
	"countryregionname" Name
);

CREATE TABLE "purchasing_vvendorwithcontacts" (
	"businessentityid" int(4),
	"name" Name,
	"contacttype" Name,
	"title" varchar,
	"firstname" Name,
	"middlename" Name,
	"lastname" Name,
	"suffix" varchar,
	"phonenumber" Phone,
	"phonenumbertype" Name,
	"emailaddress" varchar,
	"emailpromotion" int(4)
);

CREATE TABLE "sa_c" (
	"id" int(4),
	"customerid" int(4),
	"personid" int(4),
	"storeid" int(4),
	"territoryid" int(4),
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sa_cc" (
	"id" int(4),
	"creditcardid" int(4),
	"cardtype" varchar,
	"cardnumber" varchar,
	"expmonth" int(2),
	"expyear" int(2),
	"modifieddate" timestamp
);

CREATE TABLE "sa_cr" (
	"currencyrateid" int(4),
	"currencyratedate" timestamp,
	"fromcurrencycode" bpchar,
	"tocurrencycode" bpchar,
	"averagerate" numeric,
	"endofdayrate" numeric,
	"modifieddate" timestamp
);

CREATE TABLE "sa_crc" (
	"countryregioncode" varchar,
	"currencycode" bpchar,
	"modifieddate" timestamp
);

CREATE TABLE "sa_cu" (
	"id" bpchar,
	"currencycode" bpchar,
	"name" Name,
	"modifieddate" timestamp
);

CREATE TABLE "sa_pcc" (
	"id" int(4),
	"businessentityid" int(4),
	"creditcardid" int(4),
	"modifieddate" timestamp
);

CREATE TABLE "sa_s" (
	"id" int(4),
	"businessentityid" int(4),
	"name" Name,
	"salespersonid" int(4),
	"demographics" xml,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sa_sci" (
	"id" int(4),
	"shoppingcartitemid" int(4),
	"shoppingcartid" varchar,
	"quantity" int(4),
	"productid" int(4),
	"datecreated" timestamp,
	"modifieddate" timestamp
);

CREATE TABLE "sa_so" (
	"id" int(4),
	"specialofferid" int(4),
	"description" varchar,
	"discountpct" numeric,
	"type" varchar,
	"category" varchar,
	"startdate" timestamp,
	"enddate" timestamp,
	"minqty" int(4),
	"maxqty" int(4),
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sa_sod" (
	"id" int(4),
	"salesorderid" int(4),
	"salesorderdetailid" int(4),
	"carriertrackingnumber" varchar,
	"orderqty" int(2),
	"productid" int(4),
	"specialofferid" int(4),
	"unitprice" numeric,
	"unitpricediscount" numeric,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sa_soh" (
	"id" int(4),
	"salesorderid" int(4),
	"revisionnumber" int(2),
	"orderdate" timestamp,
	"duedate" timestamp,
	"shipdate" timestamp,
	"status" int(2),
	"onlineorderflag" Flag NOT NULL,
	"purchaseordernumber" OrderNumber,
	"accountnumber" AccountNumber,
	"customerid" int(4),
	"salespersonid" int(4),
	"territoryid" int(4),
	"billtoaddressid" int(4),
	"shiptoaddressid" int(4),
	"shipmethodid" int(4),
	"creditcardid" int(4),
	"creditcardapprovalcode" varchar,
	"currencyrateid" int(4),
	"subtotal" numeric,
	"taxamt" numeric,
	"freight" numeric,
	"totaldue" numeric,
	"comment" varchar,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sa_sohsr" (
	"salesorderid" int(4),
	"salesreasonid" int(4),
	"modifieddate" timestamp
);

CREATE TABLE "sa_sop" (
	"id" int(4),
	"specialofferid" int(4),
	"productid" int(4),
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sa_sp" (
	"id" int(4),
	"businessentityid" int(4),
	"territoryid" int(4),
	"salesquota" numeric,
	"bonus" numeric,
	"commissionpct" numeric,
	"salesytd" numeric,
	"saleslastyear" numeric,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sa_spqh" (
	"id" int(4),
	"businessentityid" int(4),
	"quotadate" timestamp,
	"salesquota" numeric,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sa_sr" (
	"id" int(4),
	"salesreasonid" int(4),
	"name" Name,
	"reasontype" Name,
	"modifieddate" timestamp
);

CREATE TABLE "sa_st" (
	"id" int(4),
	"territoryid" int(4),
	"name" Name,
	"countryregioncode" varchar,
	"group" varchar,
	"salesytd" numeric,
	"saleslastyear" numeric,
	"costytd" numeric,
	"costlastyear" numeric,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sa_sth" (
	"id" int(4),
	"businessentityid" int(4),
	"territoryid" int(4),
	"startdate" timestamp,
	"enddate" timestamp,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sa_tr" (
	"id" int(4),
	"salestaxrateid" int(4),
	"stateprovinceid" int(4),
	"taxtype" int(2),
	"taxrate" numeric,
	"name" Name,
	"rowguid" uuid,
	"modifieddate" timestamp
);

CREATE TABLE "sales_vindividualcustomer" (
	"businessentityid" int(4),
	"title" varchar,
	"firstname" Name,
	"middlename" Name,
	"lastname" Name,
	"suffix" varchar,
	"phonenumber" Phone,
	"phonenumbertype" Name,
	"emailaddress" varchar,
	"emailpromotion" int(4),
	"addresstype" Name,
	"addressline1" varchar,
	"addressline2" varchar,
	"city" varchar,
	"stateprovincename" Name,
	"postalcode" varchar,
	"countryregionname" Name,
	"demographics" xml
);

CREATE TABLE "sales_vpersondemographics" (
	"businessentityid" int(4),
	"totalpurchaseytd" money,
	"datefirstpurchase" date,
	"birthdate" date,
	"maritalstatus" varchar,
	"yearlyincome" varchar,
	"gender" varchar,
	"totalchildren" int(4),
	"numberchildrenathome" int(4),
	"education" varchar,
	"occupation" varchar,
	"homeownerflag" bool,
	"numbercarsowned" int(4)
);

CREATE TABLE "sales_vsalesperson" (
	"businessentityid" int(4),
	"title" varchar,
	"firstname" Name,
	"middlename" Name,
	"lastname" Name,
	"suffix" varchar,
	"jobtitle" varchar,
	"phonenumber" Phone,
	"phonenumbertype" Name,
	"emailaddress" varchar,
	"emailpromotion" int(4),
	"addressline1" varchar,
	"addressline2" varchar,
	"city" varchar,
	"stateprovincename" Name,
	"postalcode" varchar,
	"countryregionname" Name,
	"territoryname" Name,
	"territorygroup" varchar,
	"salesquota" numeric,
	"salesytd" numeric,
	"saleslastyear" numeric
);

CREATE TABLE "sales_vsalespersonsalesbyfiscalyears" (
	"SalesPersonID" int(4),
	"FullName" text,
	"JobTitle" text,
	"SalesTerritory" text,
	"2012" numeric,
	"2013" numeric,
	"2014" numeric
);

CREATE TABLE "sales_vsalespersonsalesbyfiscalyearsdata" (
	"salespersonid" int(4),
	"fullname" text,
	"jobtitle" varchar,
	"salesterritory" Name,
	"salestotal" numeric,
	"fiscalyear" numeric
);

CREATE TABLE "sales_vstorewithaddresses" (
	"businessentityid" int(4),
	"name" Name,
	"addresstype" Name,
	"addressline1" varchar,
	"addressline2" varchar,
	"city" varchar,
	"stateprovincename" Name,
	"postalcode" varchar,
	"countryregionname" Name
);

CREATE TABLE "sales_vstorewithcontacts" (
	"businessentityid" int(4),
	"name" Name,
	"contacttype" Name,
	"title" varchar,
	"firstname" Name,
	"middlename" Name,
	"lastname" Name,
	"suffix" varchar,
	"phonenumber" Phone,
	"phonenumbertype" Name,
	"emailaddress" varchar,
	"emailpromotion" int(4)
);

CREATE TABLE "sales_vstorewithdemographics" (
	"businessentityid" int(4),
	"name" Name,
	"AnnualSales" money,
	"AnnualRevenue" money,
	"BankName" varchar,
	"BusinessType" varchar,
	"YearOpened" int(4),
	"Specialty" varchar,
	"SquareFeet" int(4),
	"Brands" varchar,
	"Internet" varchar,
	"NumberEmployees" int(4)
);

