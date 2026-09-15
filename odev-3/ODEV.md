# Ödev 3: KahveGo Mimari ve API Tasarımı

## GÖREV 1: Sözde Kod (Pseudocode)

```text
BAŞLA
EĞER kullanıcı giriş yapmamışsa İSE
    Giriş Ekranına yönlendir
    BİTİR
DEĞİLSE
    Ürünleri seç ve sepete ekle
    EĞER cüzdan bakiyesi < sepet tutarı İSE
        "Bakiye Yükle" uyarısı ver
    DEĞİLSE
        Siparişi onayla
        Bakiye = Bakiye - sepet tutarı
        Arka planda sunucuya sipariş paketi gönder
BİTİR
```

---

## GÖREV 2: REST API Uç Noktası & JSON Tasarımı

### 1. Sipariş Oluşturma Endpoint'i
- **HTTP Metodu:** `POST`
- **URL / Endpoint:** `/api/v1/siparisler`
- **Header:** `Authorization: Bearer <token>`, `Content-Type: application/json`

**Örnek Request Body (JSON):**
```json
{
  "kahve_adi": "Latte",
  "boyut": "Venti",
  "adet": 2,
  "toplam_tutar": 210.50
}
```

- **Başarılı Sonuç HTTP Durum Kodu:** `201 Created`
- **Kullanıcı Giriş Yapmamışsa:** `401 Unauthorized`

### 2. Cüzdan Bakiye Sorgulama Endpoint'i
- **HTTP Metodu:** `GET`
- **URL / Endpoint:** `/api/v1/kullanici/bakiye`

**Örnek Response (JSON):**
```json
{
  "bakiye": 350.00,
  "para_birimi": "TRY"
}
```

- **Sunucuda Beklenmeyen Hata:** `500 Internal Server Error`

> **Mini Mülakat Sorusu:**  
> GET isteği idempotent'tir (eşgüçlüdür) çünkü art arda atılsa bile sunucudaki veriyi değiştirmez; POST isteği ise her defasında yeni bir kaynak/sipariş oluşturduğu için idempotent değildir.

---

## GÖREV 3: Clean Code & SOLID Prensip Teşhisi

1. **SRP İhlali:**  
   Sınıf; fiyat hesaplama, veritabanı kaydı, ödeme alma ve SMS gönderme gibi farklı sorumlulukları tek başına üstlendiği için SRP'yi ihlal etmiştir. Çözüm olarak sınıfı; `SiparisYoneticisi`, `OdemeServisi`, `VeritabaniServisi` ve `BildirimServisi` şeklinde küçük parçalara bölmeliyiz.

2. **OCP İhlali:**  
   Yeni bir müşteri tipi geldiğinde kodun değiştirilmeye zorlanması (if-else bloklarının sürekli güncellenmesi), Open/Closed Principle (Açık/Kapalı Prensibi) kuralına aykırıdır.
