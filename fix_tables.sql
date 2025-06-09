-- Drop duplicate table if it exists
DROP TABLE IF EXISTS oduncler;

-- Add missing columns to UserLoginHistory
ALTER TABLE UserLoginHistory
ADD COLUMN IF NOT EXISTS DeviceInfo VARCHAR(200) NULL,
ADD COLUMN IF NOT EXISTS IpAddress VARCHAR(50) NULL,
ADD COLUMN IF NOT EXISTS Status VARCHAR(20) NULL;

-- Add missing columns to UserTokens
ALTER TABLE UserTokens
ADD COLUMN IF NOT EXISTS DeviceInfo VARCHAR(200) NULL,
ADD COLUMN IF NOT EXISTS CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Add missing columns to AuthUsers
ALTER TABLE AuthUsers
ADD COLUMN IF NOT EXISTS LastLoginAt DATETIME NULL,
ADD COLUMN IF NOT EXISTS CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Ensure all tables have proper character set
ALTER TABLE AuthUsers CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE UserTokens CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
ALTER TABLE UserLoginHistory CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; 