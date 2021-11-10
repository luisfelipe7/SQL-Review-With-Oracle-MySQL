/* ---------------- SQL Basics Review with MySQL-------------------  */

-- First of all creating the schema(database)
create schema tests;
-- Using the schema
use tests;

-- CREATING TABLES 
-- 1. Persons 
create table persons(physicalID varchar(9) not null, name varchar(200) not null , phoneint int(8) default null, province varchar(40) default null);
-- 2. Societies 
create table societies(juridicID varchar(9) not null,name varchar(200) not null, phoneint int(8) default null, province varchar(40) default null, actionValueInDolars int default 0);
-- 3. Partners
create table partners(ID varchar(9) not null, partnerID varchar(9) not null, societyID varchar(9) not null, quantityOfActions int default 0, isActive char(1) default 'Y', positionUnderDirective varchar(400) default 'Not Part of Directive');

-- SETTING CONSTRAINTS
-- 1.PKs
alter table persons add constraint persons_pk primary key (physicalID);
alter table societies add constraint societies_pk primary key (juridicID);
alter table partners add constraint partners_pk primary key (ID);
-- 2.FKs
alter table partners add constraint partners_fk1 foreign key (partnerID) references persons(physicalID);
alter table partners add constraint partners_fk2 foreign key (societyID) references societies(juridicID);
-- 3. CKs
alter table partners add constraint partners_ck1 check (positionUnderDirective in ('Not Part of Directive','President','Vice-President','Treasurer','Secretary','Member 1','Member 2','Prosecutor'));

-- INSERTING INFORMATION
-- 1. Persons 
insert into persons(physicalID,name,phoneint,province) values ('1AA890155','Felipe Castro',85147895,'Heredia');
insert into persons(physicalID,name,phoneint,province) values ('1AA890156','Esteban Castro',85122895,'San Jose');
insert into persons(physicalID,name,phoneint,province) values ('1AA890254','Yenifer Esquivel',47127745,'Guanacaste');
insert into persons(physicalID,name,phoneint,province) values ('1AA890255','Kimberly Esquivel',96147111,'Limon');
insert into persons(physicalID,name,phoneint,province) values ('3BBA89044','Luis Castro',96147222,'Heredia');
commit;
-- 2. Societies
insert into societies(juridicID,name,phoneint,province,actionValueInDolars) values ('1','Anonymous',null,'Heredia',40);
insert into societies(juridicID,name,phoneint,province,actionValueInDolars) values ('2','Brotherhood',54720685,'San Jose',200);
insert into societies(juridicID,name,phoneint,province,actionValueInDolars) values ('3','Informatics',99424864,'San Jose',10);
insert into societies(juridicID,name,phoneint,province,actionValueInDolars) values ('4','Testers',null,'San Jose',500);
-- 3. Partners
insert into partners(ID,partnerID,societyID,quantityOfActions,isActive,positionUnderDirective) values ('1','1AA890155','1',200,'Y','President');
insert into partners(ID,partnerID,societyID,quantityOfActions,isActive,positionUnderDirective) values ('2','1AA890254','1',100,'Y','Vice-President');
insert into partners(ID,partnerID,societyID) values ('3','1AA890156','1');
insert into partners(ID,partnerID,societyID) values ('4','1AA890255','1');
insert into partners(ID,partnerID,societyID,quantityOfActions,isActive,positionUnderDirective) values ('5','1AA890254','2',1000,'Y','President');
insert into partners(ID,partnerID,societyID,quantityOfActions,isActive,positionUnderDirective) values ('6','1AA890156','2',900,'Y','Vice-President');
insert into partners(ID,partnerID,societyID,quantityOfActions,isActive,positionUnderDirective) values ('7','1AA890155','2',200,'Y','Treasurer');
insert into partners(ID,partnerID,societyID,quantityOfActions,isActive,positionUnderDirective) values ('8','1AA890255','2',100,'N','Prosecutor');
insert into partners(ID,partnerID,societyID,quantityOfActions,isActive,positionUnderDirective) values ('13','3BBA89044','2',500,'Y','Secretary');
insert into partners(ID,partnerID,societyID) values ('9','1AA890156','3');
insert into partners(ID,partnerID,societyID) values ('10','1AA890155','3');
insert into partners(ID,partnerID,societyID) values ('11','1AA890254','3');
insert into partners(ID,partnerID,societyID) values ('12','1AA890255','3');

-- CHECKING THE INFORMATION 
-- 1. Persons 
select * from persons;
-- 2. Societies
select * from societies;
-- 3. Partners
select * from partners;

-- MAKING THE QUERIES REQUESTED
-- 1. All the members under a position of the directive from an specific society using the name or the juridicID to make the consult
-- Implicit
select distinct persons.physicalID, persons.name, persons.phoneint, partners.quantityOfActions, partners.positionUnderDirective from societies,persons,partners where partners.societyID = '2' and  partners.partnerID=persons.physicalID and partners.positionUnderDirective != 'Not Part of Directive' and partners.isActive='Y' order by persons.name;
-- Explicit
select distinct persons.physicalID, persons.name, persons.phoneint, partners.quantityOfActions, partners.positionUnderDirective from persons inner join partners on partners.partnerID = persons.physicalID where partners.societyID = '2' and partners.positionUnderDirective != 'Not Part of Directive' and partners.isActive='Y';

-- 2. All the partners from a society and the quantityOfActions
-- Implicit
select societies.name, partners.partnerID, persons.name, partners.quantityOfActions, partners.positionUnderDirective from societies, persons, partners where partners.partnerID=persons.physicalID and partners.societyID=societies.juridicID and partners.societyID = '1' and partners.isActive='Y';
-- Explicit
select societies.name, partners.partnerID, persons.name, partners.quantityOfActions, partners.positionUnderDirective from  partners inner join societies on partners.societyID=societies.juridicID inner join persons on partners.partnerID=persons.physicalID where partners.societyID = '1' and partners.isActive='Y';

-- 3. The total quantityOfActions from the societies and the total value of each society
-- Implicit
select societies.juridicID, societies.name, societies.actionValueInDolars, sum(partners.quantityOfActions) as TotalOfActions, ((sum(partners.quantityOfActions))*societies.actionValueInDolars) as SocietyValue from societies,partners where societies.juridicID = partners.societyID group by societies.juridicID, societies.actionValueInDolars, societies.name;
-- Explicit
select societies.juridicID, societies.name, societies.actionValueInDolars, sum(partners.quantityOfActions) as TotalOfActions, ((sum(partners.quantityOfActions))*societies.actionValueInDolars) as SocietyValue from societies inner join partners on societies.juridicID = partners.societyID group by societies.juridicID, societies.actionValueInDolars, societies.name;

-- 4. Partner actions on each society and the value of the actions
-- Implicit
select societies.name, persons.name, societies.actionValueInDolars, partners.quantityOfActions, partners.quantityOfActions*actionValueInDolars as ValueOfActions from persons, partners, societies where persons.physicalID = partners.partnerID and societies.juridicID = partners.societyID and partners.partnerID = '1AA890155';

-- 5. Left Outer Join Query Consulting the partners, their societies and the societies where he/she is not part.
select societies.name, partners.partnerID, partners.quantityOfActions from societies left outer join partners on societies.juridicID= partners.societyID;

-- 6. Giving 10 actions to the people that is partner of the Society Anonymous
update partners set quantityOfActions=quantityOfActions+10 where societyID='3';

-- 7. Give 20 actions to the people with the province Heredia
update partners inner join persons on partners.partnerID=persons.physicalID set partners.quantityOfActions=partners.quantityOfActions+20 where persons.province='Heredia' ;

-- 8. Delete inactive partners
delete from partners where isActive='N';

-- 9. Truncate Table 
truncate table partners;

-- 10. Drop Constraint
alter table partners drop constraint partners_ck1;

-- 11. Drop Table
drop table partners;