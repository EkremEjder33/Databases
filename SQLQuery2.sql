create database Kafe
use Kafe
create table Musteriler(
musteriNo int Primary key not null identity (1,1) ,
musteriAdi nvarchar (30),
musteriSoyadi nvarchar (40),
musteriMail nvarchar (100),
);
create table Urunler(
urunNo int Primary key not null,
urunAdi nvarchar (40),
urunFiyat float 
);	
create table Siparisler(
siparisNo int Primary Key not null,
musteriNo int foreign key (musteriNo) references Musteriler(musteriNo),
urunNo int foreign key (urunNo) references Urunler(urunNo),
siparisTarihi Datetime
);
INSERT INTO Siparisler (siparisNo,siparisTarihi) values (6,'2024-05-13');
INSERT INTO Musteriler (musteriNo,musteriAdi,musteriSoyadi,musteriMail) values (38,'Ekrem','Ejder','ejderekrem@gmail.com');
INSERT INTO Musteriler (musteriNo,musteriAdi,musteriSoyadi,musteriMail) values (46,'Canberk','Özbek','canokeder@gmail.com');
INSERT INTO Urunler (urunNo,urunAdi,urunFiyat) values (1,'Iced Americano',180.50);
INSERT INTO Urunler (urunNo,urunAdi,urunFiyat) values (2,'Iced Filter Cofee',190.75);
INSERT INTO Siparisler (siparisNo,siparisTarihi) values (5,'2026-05-13');
INSERT INTO Musteriler (musteriNo, musteriAdi, musteriSoyadi, musteriMail) 
VALUES (19, 'Erkan', 'Karaaytu', 'corumspor19@mail.com');
update Urunler set urunFiyat = 130.50 where urunNo = 2 ;
update Urunler set urunFiyat = 131.50 where urunNo = 1 ;

select * from Urunler;
alter table Musteriler alter column musteriAdi nvarchar (50);
select * from Musteriler where musteriAdi like  '%e%';

select * from Musteriler order by musteriAdi asc;

select * from Musteriler where musteriAdi in (select musteriAdi where musteriNo = 38 );
select * from Siparisler where siparisTarihi in (SELECT siparisTarihi FROM Siparisler WHERE siparisTarihi = CONVERT(DATE, '2025-03-05'));

select count (*) as MusteriSayısı from Musteriler;
select count (*) as UrunSayisi from Urunler;
select sum (urunFiyat)  from Urunler;
select avg (urunFiyat) from Urunler;
select max (urunFiyat) from Urunler;
select min (urunFiyat) from Urunler;
select musteriAdi,len(musteriAdi) as HarfSayisi from Musteriler;
select siparisTarihi from siparisler where siparisTarihi < '2026';
select siparisTarihi from siparisler where siparisTarihi > '2026';
select siparisTarihi from siparisler ;



SELECT 
    m.musteriAdi,
    m.musteriSoyadi,
    u.urunAdi,
    u.urunFiyat 
FROM Siparisler AS s
INNER JOIN Musteriler AS m ON s.musteriNo = m.musteriNo
INNER JOIN Urunler AS u ON s.urunNo = u.urunNo
WHERE m.musteriAdi = 'Erkan';


select ('Sn. '+musteriAdi+' '+musteriSoyadi) from Musteriler where len(musteriAdi )>3


alter table Musteriler drop column musteriMail
alter table Musteriler add adresNo int constraint "musteriler_siparisler"
foreign key (adresNo) references Adresler(adresNo);

