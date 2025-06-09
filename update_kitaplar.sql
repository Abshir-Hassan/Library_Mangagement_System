-- Drop existing table if it exists
DROP TABLE IF EXISTS `Kitaplar`;

-- Create Kitaplar table with correct structure
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