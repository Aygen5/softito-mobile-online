-- users tablosundan kullanici adi ve email, orders tablosundan siparis numarasi
SELECT 
    users.fullname,
    users.email,
    orders.order_number
FROM users
INNER JOIN orders ON users.id = orders.user_id;

-- Nasil Calisir: users tablosundaki 'id' ile orders tablosundaki 'user_id' eslesen kayitlari birlestirerek kullanicinin adi, e-postasi ve siparis numarasini tek bir tabloda listeler.
