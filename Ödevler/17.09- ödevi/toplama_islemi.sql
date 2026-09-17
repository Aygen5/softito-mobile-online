-- 1. ADIM: Siparisler tablosunu oluştur
CREATE TABLE Siparisler (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    urun_adi TEXT NOT NULL,
    fiyat REAL NOT NULL,
    kargo_ucreti REAL NOT NULL
);

-- 2. ADIM: Tabloya örnek sipariş verileri ekle
INSERT INTO Siparisler (urun_adi, fiyat, kargo_ucreti) VALUES ('Mekanik Klavye', 1200.00, 50.00);
INSERT INTO Siparisler (urun_adi, fiyat, kargo_ucreti) VALUES ('Oyuncu Mouse', 800.00, 40.00);
INSERT INTO Siparisler (urun_adi, fiyat, kargo_ucreti) VALUES ('Monitör', 5500.00, 150.00);

-- 3. ADIM: Toplama işlemini yap (Her satırdaki fiyat ve kargoyu topla)
SELECT 
    urun_adi, 
    fiyat, 
    kargo_ucreti, 
    (fiyat + kargo_ucreti) AS toplam_odenecek 
FROM Siparisler;

/*
BEKLENEN SORGUNUN ÇIKTISI:
| urun_adi       | fiyat  | kargo_ucreti | toplam_odenecek |
| -------------- | ------ | ------------ | --------------- |
| Mekanik Klavye | 1200.0 | 50.0         | 1250.0          |
| Oyuncu Mouse   | 800.0  | 40.0         | 840.0           |
| Monitör        | 5500.0 | 150.0        | 5650.0          |
*/
