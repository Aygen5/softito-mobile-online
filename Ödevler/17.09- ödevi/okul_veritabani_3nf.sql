-- 3NF Kurallarına Uygun Okul Veritabanı DDL Sorguları

-- 1. Bölümler Tablosu (Department)
CREATE TABLE bolumler (
    bolum_id INTEGER PRIMARY KEY AUTOINCREMENT,
    bolum_adi VARCHAR(100) NOT NULL
);

-- 2. Öğrenciler Tablosu (Student)
-- Her öğrencinin bir bölümü vardır (1 to N ilişki).
CREATE TABLE ogrenciler (
    ogrenci_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ad VARCHAR(50) NOT NULL,
    soyad VARCHAR(50) NOT NULL,
    bolum_id INTEGER,
    FOREIGN KEY (bolum_id) REFERENCES bolumler(bolum_id)
);

-- 3. Dersler Tablosu (Course)
CREATE TABLE dersler (
    ders_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ders_adi VARCHAR(100) NOT NULL,
    kredi INTEGER NOT NULL
);

-- 4. Öğrenci - Ders İlişki Tablosu (Junction Table)
-- Öğrenciler ve Dersler arasında N to N (Çoka Çok) ilişki vardır. 
-- 3NF gereği bu ilişki ayrı bir tabloda tutulmalıdır.
CREATE TABLE ogrenci_dersler (
    ogrenci_id INTEGER,
    ders_id INTEGER,
    PRIMARY KEY (ogrenci_id, ders_id),
    FOREIGN KEY (ogrenci_id) REFERENCES ogrenciler(ogrenci_id),
    FOREIGN KEY (ders_id) REFERENCES dersler(ders_id)
);
