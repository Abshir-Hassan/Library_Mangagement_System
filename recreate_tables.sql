-- Drop existing tables if they exist
DROP TABLE IF EXISTS `Cezalar`;
DROP TABLE IF EXISTS `Odunc_Almalar`;
DROP TABLE IF EXISTS `Kitaplar`;
DROP TABLE IF EXISTS `Kullanicilar`;
DROP TABLE IF EXISTS `Kategoriler`;

-- Create Kategoriler table
CREATE TABLE `Kategoriler` (
    `Kategori_ID` int NOT NULL AUTO_INCREMENT,
    `Kategori_Adi` varchar(50) CHARACTER SET utf8mb4 NOT NULL,
    CONSTRAINT `PK_Kategoriler` PRIMARY KEY (`Kategori_ID`)
) CHARACTER SET utf8mb4;

-- Create Kullanicilar table
CREATE TABLE `Kullanicilar` (
    `Kullanici_ID` int NOT NULL AUTO_INCREMENT,
    `Ad` varchar(50) CHARACTER SET utf8mb4 NOT NULL,
    `Soyad` varchar(50) CHARACTER SET utf8mb4 NOT NULL,
    `Email` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
    `Telefon` varchar(15) CHARACTER SET utf8mb4 NULL,
    `Adres` varchar(200) CHARACTER SET utf8mb4 NULL,
    `Kullanici_Tipi` varchar(20) CHARACTER SET utf8mb4 NOT NULL,
    `Kayit_Tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `PK_Kullanicilar` PRIMARY KEY (`Kullanici_ID`),
    CONSTRAINT `UQ_Kullanicilar_Email` UNIQUE INDEX `IX_Kullanicilar_Email` (`Email`)
) CHARACTER SET utf8mb4;

-- Create Kitaplar table
CREATE TABLE `Kitaplar` (
    `Kitap_ID` int NOT NULL AUTO_INCREMENT,
    `Baslik` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
    `Yazar` varchar(100) CHARACTER SET utf8mb4 NOT NULL,
    `Yayin_Yili` int NULL,
    `Yayin_Evi` varchar(100) CHARACTER SET utf8mb4 NULL,
    `ISBN` varchar(13) CHARACTER SET utf8mb4 NOT NULL,
    `Kategori_ID` int NOT NULL,
    `Stok_Adedi` int NOT NULL DEFAULT 0,
    `Aciklama` varchar(500) CHARACTER SET utf8mb4 NOT NULL,
    `Durum` varchar(20) CHARACTER SET utf8mb4 NOT NULL DEFAULT 'Müsait',
    `Fiyat` decimal(18,2) NOT NULL DEFAULT 0.00,
    `Eklenme_Tarihi` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT `PK_Kitaplar` PRIMARY KEY (`Kitap_ID`),
    CONSTRAINT `FK_Kitaplar_Kategoriler_Kategori_ID` FOREIGN KEY (`Kategori_ID`) REFERENCES `Kategoriler` (`Kategori_ID`) ON DELETE SET NULL,
    CONSTRAINT `UQ_Kitaplar_ISBN` UNIQUE INDEX `IX_Kitaplar_ISBN` (`ISBN`),
    CONSTRAINT `CHK_Kitaplar_Yayin_Yili` CHECK (`Yayin_Yili` IS NULL OR (`Yayin_Yili` >= 1800 AND `Yayin_Yili` <= 2100)),
    CONSTRAINT `CHK_Kitaplar_Stok_Adedi` CHECK (`Stok_Adedi` >= 0)
) CHARACTER SET utf8mb4;

-- Create Odunc_Almalar table
CREATE TABLE `Odunc_Almalar` (
    `Odunc_ID` int NOT NULL AUTO_INCREMENT,
    `Kitap_ID` int NOT NULL,
    `Kullanici_ID` int NOT NULL,
    `Alim_Tarihi` datetime NOT NULL,
    `Teslim_Tarihi` datetime NULL,
    `Gecikme_Gun` int NOT NULL DEFAULT 0,
    `Ceza_Miktari` decimal(18,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT `PK_Odunc_Almalar` PRIMARY KEY (`Odunc_ID`),
    CONSTRAINT `FK_Odunc_Almalar_Kitaplar_Kitap_ID` FOREIGN KEY (`Kitap_ID`) REFERENCES `Kitaplar` (`Kitap_ID`) ON DELETE RESTRICT,
    CONSTRAINT `FK_Odunc_Almalar_Kullanicilar_Kullanici_ID` FOREIGN KEY (`Kullanici_ID`) REFERENCES `Kullanicilar` (`Kullanici_ID`) ON DELETE RESTRICT
) CHARACTER SET utf8mb4;

-- Create Cezalar table
CREATE TABLE `Cezalar` (
    `Ceza_ID` int NOT NULL AUTO_INCREMENT,
    `Odunc_ID` int NOT NULL,
    `Ceza_Tutari` decimal(18,2) NOT NULL,
    `Ceza_Tarihi` datetime NOT NULL,
    `Odendi_MI` bit NOT NULL DEFAULT 0,
    `Odeme_Yontemi` varchar(50) CHARACTER SET utf8mb4 NULL,
    `Aciklama` varchar(500) CHARACTER SET utf8mb4 NULL,
    CONSTRAINT `PK_Cezalar` PRIMARY KEY (`Ceza_ID`),
    CONSTRAINT `FK_Cezalar_Odunc_Almalar_Odunc_ID` FOREIGN KEY (`Odunc_ID`) REFERENCES `Odunc_Almalar` (`Odunc_ID`) ON DELETE CASCADE
) CHARACTER SET utf8mb4;

-- Insert initial categories
INSERT INTO `Kategoriler` (`Kategori_Adi`) VALUES
('Roman'),
('Bilim'),
('Tarih'),
('Edebiyat'); 