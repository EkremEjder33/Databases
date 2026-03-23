--CREATE DATABASE KutuphaneSistemi;
--USE KutuphaneSistemi
CREATE TABLE Adresler(
adresno int PRIMARY KEY NOT null,
sehir varchar (50) NOT NULL,
mahalle varchar(50),
binaNo int,
postakodu int,
ulke varchar(50) NOT NULL,
cadde varchar (50)
);


CREATE TABLE uyeler(
  uyeNO INT PRIMARY KEY NOT NULL,
  uyeAdi varchar (100) NOT NULL,
  uyeSoyadi varchar (100) NOT NULL,
  Cinsiyet char (2),
  eposta varchar (50),
  telefon varchar (50)
  );
  
  
--ALTER TABLE uyeler
--dd adresno int 
FOREIGN KEY (adresno) REFERENCES Adresler(adresno);

ALTER TABLE uyeler_yeni RENAME TO uyeler;

PRAGMA foreign_keys = ON;

CREATE TABLE kutuphane(
  kutuphaneNo INT PRIMARY key ,
  kutuphaneIsmi varchar (100),
  Aciklama varchar (100),
  adresNo int foreign KEY (adresNo)
  REFERENCES Adresler(adresno);
  );
  
  CREATE TABLE kitaplar(
  ISBN varchar (50) NOT NULL PRIMARY KEY,
  kitaplar varchar (100) NOT NULL,
  sayfaSayisi int,
  yayinTarihi datetime
  );
  
  CREATE TABLE emanet(
  emanetId int PRIMARY KEY not NULL,
  emanetTarihi datetime,
  teslimTarihi datetime,
  --uyeNo int  (uyeno) REFERENCES uyeler (ISBN),
  ISBN varchar (50) REFERENCES kitaplar(ISBN)
  );
  
 CREATE TABLE yazarlar(
 yazarNo int primary key NOT NULL,
 yazarAdi varchar (50),
 yazarSoyadi varchar (50)
 );
 
 CREATE TABLE kategori_kitap(
 id int PRIMARY KEY NOT NULL,
 ISBN varchar (50) REFERENCES kitaplar(ISBN),
 kategoriNo varchar (50) REFERENCES kitaplar (ISBN),
 yazarno int
 );
 
 CREATE table kitap_yazarları(
  id int PRIMARY KEY NOT NULL,
 ISBN varchar (50) REFERENCES kitaplar(ISBN),
 kategoriNo varchar (50) REFERENCES kitaplar (ISBN),
 yazarno int
 );

CREATE TABLE kitap_kutuphane(
 id int PRIMARY KEY NOT NULL,
 ISBN varchar (50) REFERENCES kitaplar(ISBN),
 kategoriNo varchar (50) REFERENCES kitaplar (ISBN),
 yazarno int
 );

