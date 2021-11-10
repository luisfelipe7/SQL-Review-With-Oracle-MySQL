---------------- SQL Basics Review ------------------- 

-- Creating an Spool Log
spool SQLBasicsReviewSpool.log 

-- Cleaning the screen  
host cls

prompt Connecting with System User 
conn system/H0nt3r05


prompt Modified the session due to new policies with Oracle avoiding requiring SYS admin permissions
alter session set "_ORACLE_SCRIPT"=true;  

prompt Dropping the User Recursively
drop user felipe cascade;

prompt Dropping the Tables Recursively
drop tablespace TBSP01 including contents and datafiles;

prompt Creating the user
create user felipe identified by myPassword;

prompt Granting permissions to the user 
grant dba to felipe;

prompt Connecting to the User
conn felipe/myPassword;

prompt Creating the TABLESPACE
CREATE TABLESPACE TBSP01 datafile'D:\Installations\Programs\Oracle\DatabaseExpressEdition21c\TBSP01.DBF' SIZE 256K REUSE AUTOEXTEND ON;

prompt CREATING TABLES 

-- 1. Persons 
create table persons(physicalID varchar2(9) not null, name varchar2(200) not null , phoneNumber number(8) default null, province varchar2(40) default null) TABLESPACE TBSP01;
-- 2. Societies 
create table societies(juridicID varchar2(9) not null,name varchar2(200) not null, phoneNumber number(8) default null, province varchar2(40) default null, actionValueInDolars number default 0) TABLESPACE TBSP01;
-- 3. Partners
create table partners(ID varchar2(9) not null, partnerID varchar2(9) not null, societyID varchar2(9) not null, quantityOfActions number default 0, isActive char(1) default 'Y', positionUnderDirective varchar2(400) default 'Not Part of Directive') TABLESPACE TBSP01;

prompt SETTING CONSTRAINTS
-- 1.PKs
alter table persons add constraint persons_pk primary key (physicalID);
alter table societies add constraint societies_pk primary key (juridicID);
alter table partners add constraint partners_pk primary key (ID);
-- 2.FKs
alter table partners add constraint partners_fk1 foreign key (partnerID) references persons;
alter table partners add constraint partners_fk2 foreign key (societyID) references societies;

-- 3. CKs
alter table partners add constraint partners_ck1 check (positionUnderDirective in ('Not Part of Directive','President','Vice-President','Treasurer','Secretary','Member 1','Member 2','Prosecutor'));

prompt INSERTING INFORMATION
-- 1. Persons 
insert into persons(physicalID,name,phoneNumber,province) values ('1AA890155','Felipe Castro',85147895,'Heredia');
insert into persons(physicalID,name,phoneNumber,province) values ('1AA890156','Esteban Castro',85122895,'San Jose');
insert into persons(physicalID,name,phoneNumber,province) values ('1AA890254','Yenifer Esquivel',47127745,'Guanacaste');
insert into persons(physicalID,name,phoneNumber,province) values ('1AA890255','Kimberly Esquivel',96147111,'Limon');
insert into persons(physicalID,name,phoneNumber,province) values ('3BBA89044','Luis Castro',96147222,'Heredia');

commit;
-- 2. Societies
insert into societies(juridicID,name,phoneNumber,province,actionValueInDolars) values ('1','Anonymous',null,'Heredia',40);
insert into societies(juridicID,name,phoneNumber,province,actionValueInDolars) values ('2','Brotherhood',54720685,'San Jose',200);
insert into societies(juridicID,name,phoneNumber,province,actionValueInDolars) values ('3','Informatics',99424864,'San Jose',10);
insert into societies(juridicID,name,phoneNumber,province,actionValueInDolars) values ('4','Testers',null,'San Jose',500);

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



prompt SETTING THE FORMAT TO THE COLUMNS
COLUMN name format A20;
COLUMN positionUnderDirective format A22;


prompt CHECKING THE INFORMATION 
-- 1. Persons 
select * from persons;
-- 2. Societies
select * from societies;
-- 3. Partners
select * from partners;

prompt MAKING THE QUERIES REQUESTED

prompt 1. All the members under a position of the directive from an specific society using the name or the juridicID to make the consult
prompt Implicit
select distinct persons.physicalID, persons.name, persons.phoneNumber, partners.quantityOfActions, partners.positionUnderDirective from societies,persons,partners where partners.societyID = '2' and  partners.partnerID=persons.physicalID and partners.positionUnderDirective != 'Not Part of Directive' and partners.isActive='Y';
prompt Explicit
select persons.physicalID, persons.name, persons.phoneNumber, partners.quantityOfActions, partners.positionUnderDirective from persons inner join partners on partners.partnerID = persons.physicalID where partners.societyID = '2' and partners.positionUnderDirective != 'Not Part of Directive' and partners.isActive='Y';

prompt 2. All the partners from a society and the quantityOfActions
prompt Implicit
select societies.name, partners.partnerID, persons.name, partners.quantityOfActions, partners.positionUnderDirective from societies, persons, partners where partners.partnerID=persons.physicalID and partners.societyID=societies.juridicID and partners.societyID = '1' and partners.isActive='Y';
prompt Explicit
select societies.name, partners.partnerID, persons.name, partners.quantityOfActions, partners.positionUnderDirective from  partners inner join societies on partners.societyID=societies.juridicID inner join persons on partners.partnerID=persons.physicalID where partners.societyID = '1' and partners.isActive='Y';

prompt 3. The total quantityOfActions from the societies and the total value of each society
prompt Implicit
select societies.juridicID, societies.name, societies.actionValueInDolars, sum(partners.quantityOfActions) as TotalOfActions, ((sum(partners.quantityOfActions))*societies.actionValueInDolars) as SocietyValue from societies,partners where societies.juridicID = partners.societyID group by societies.juridicID, societies.actionValueInDolars, societies.name;
prompt Explicit
select societies.juridicID, societies.name, societies.actionValueInDolars, sum(partners.quantityOfActions) as TotalOfActions, ((sum(partners.quantityOfActions))*societies.actionValueInDolars) as SocietyValue from societies inner join partners on societies.juridicID = partners.societyID group by societies.juridicID, societies.actionValueInDolars, societies.name;

prompt 4. Partner actions on each society and the value of the actions
prompt Implicit
select societies.name, persons.name, societies.actionValueInDolars, partners.quantityOfActions, partners.quantityOfActions*actionValueInDolars as ValueOfActions from persons, partners, societies where persons.physicalID = partners.partnerID and societies.juridicID = partners.societyID and partners.partnerID = '1AA890155';

prompt 5. Left Outer Join Query Consulting the partners, their societies and the societies where he/she is not part.
select societies.name, partners.partnerID, partners.quantityOfActions from societies left outer join partners on societies.juridicID= partners.societyID;

prompt 6. Giving 10 actions to the people that is partner of the Society Anonymous
update partners set quantityOfActions=quantityOfActions+10 where societyID='3';

prompt 7. Give 20 actions to the people with the province Heredia
update (Select partners.partnerID, partners.quantityOfActions from partners inner join persons on partners.partnerID=persons.physicalID where persons.province='Heredia') t set t.quantityOfActions=t.quantityOfActions+20;

prompt 8. Delete inactive partners
delete from partners where isActive='N';

prompt 9. Truncate Table 
truncate table partners;

prompt 10. Drop Constraint
alter table partners drop constraint partners_ck1;

prompt 11. Drop Table
drop table partners;


prompt Closing the Spool Log  
spool off