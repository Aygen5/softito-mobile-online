-- ============================================================
-- 1. TABLO OLUSTURMA (CREATE TABLE)
-- Ekstra alan olarak 'phone' (telefon) eklendi.
-- ============================================================
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    fullname TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    phone TEXT NOT NULL
);

-- ============================================================
-- 2. KULLANICI EKLEME (INSERT / CREATE)
-- ============================================================
INSERT INTO users (fullname, email, phone) VALUES 
('Ahmet Yilmaz', 'ahmet@mail.com', '05321112233'),
('Ayse Demir', 'ayse@mail.com', '05442223344'),
('Mehmet Kaya', 'mehmet@mail.com', '05553334455');

-- Sonuc: 3 kayit basariyla eklendi (Query OK, 3 rows affected).

-- ============================================================
-- 3. KULLANICILARI LISTELEME (SELECT / READ)
-- ============================================================
SELECT * FROM users;

-- Sorgu Sonucu:
-- | id | fullname     | email           | phone       |
-- |----|--------------|-----------------|-------------|
-- | 1  | Ahmet Yilmaz | ahmet@mail.com  | 05321112233 |
-- | 2  | Ayse Demir   | ayse@mail.com   | 05442223344 |
-- | 3  | Mehmet Kaya  | mehmet@mail.com | 05553334455 |

-- ============================================================
-- 4. EMAIL GUNCELLEME (UPDATE)
-- ============================================================
UPDATE users 
SET email = 'ayse.yeni@mail.com' 
WHERE id = 2;

-- Sorgu Sonucu (Guncelleme sonrasi liste):
-- | id | fullname     | email              | phone       |
-- |----|--------------|--------------------|-------------|
-- | 1  | Ahmet Yilmaz | ahmet@mail.com     | 05321112233 |
-- | 2  | Ayse Demir   | ayse.yeni@mail.com | 05442223344 |
-- | 3  | Mehmet Kaya  | mehmet@mail.com    | 05553334455 |

-- ============================================================
-- 5. KULLANICI SILME (DELETE)
-- ============================================================
DELETE FROM users 
WHERE id = 3;

-- Sorgu Sonucu (Silme sonrasi son durum):
-- | id | fullname     | email              | phone       |
-- |----|--------------|--------------------|-------------|
-- | 1  | Ahmet Yilmaz | ahmet@mail.com     | 05321112233 |
-- | 2  | Ayse Demir   | ayse.yeni@mail.com | 05442223344 |
