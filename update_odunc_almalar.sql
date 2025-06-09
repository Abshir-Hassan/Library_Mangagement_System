-- Drop existing table if it exists
DROP TABLE IF EXISTS `Odunc_Almalar`;

-- Create Odunc_Almalar table with correct structure
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