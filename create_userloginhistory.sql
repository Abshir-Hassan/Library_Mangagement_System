CREATE TABLE IF NOT EXISTS `UserLoginHistory` (
    `HistoryId` INT NOT NULL AUTO_INCREMENT,
    `UserId` INT NOT NULL,
    `LoginTime` DATETIME NOT NULL,
    `IpAddress` VARCHAR(45) NULL,
    `DeviceInfo` VARCHAR(255) NULL,
    `Status` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`HistoryId`),
    INDEX `IX_UserLoginHistory_UserId` (`UserId`),
    CONSTRAINT `FK_UserLoginHistory_AuthUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `AuthUsers` (`UserId`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci; 