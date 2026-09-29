# IoT Ağı Yönetim Sistemi Ödevi - Kod Açıklamaları ve Analizi


## 1. Cihaz Tipleri (Enum)
```dart
enum CihazTipi {
  sensor,
  gateway,
  edgeServer,
  router
}
```
**Neden yazıldı?** Ağımızda sadece bu 4 tip cihaz olmasını istiyoruz. Birisi yanlışlıkla geçersiz bir tip giremesin diye (derleme zamanı güvenliği) `enum` kullanarak seçeneklerimizi kısıtlıyoruz.



## 2. Özel Hata Sınıfı (Exception)
```dart
class CihazErisilemezException implements Exception {
  final String mesaj;
  CihazErisilemezException(this.mesaj);

  @override
  String toString() => mesaj;
}
```
**Neden yazıldı?** Programın akışı sırasında beklenen bir sorun çıktığında (örneğin cihaz kapalıysa veya yoksa), uygulamanın tamamen çökmesini istemeyiz.
`implements Exception` kullanarak kendi özel hatamızı yarattık. Böylece hatayı fırlattığımızda sistem tam olarak neyin ters gittiğini bu `mesaj` sayesinde bize söyleyebilecek.




## 3. IoTCihaz Sınıfı ve Özellikleri (Class ve Getter)
```dart
class IoTCihaz {
  final String seriNo;
  final CihazTipi tip; // Yukarıdaki enum'ı burada tür olarak kullanıyoruz
  final double cpuYukYuzdesi;
  final int bellekMb;
  final Set<String> acikPortlar; 
  final bool sslSertifikasiGecerliMi;
  final bool aktifMi; // Cihaz kapalı mı açık mı?
  // ... constructor kodları ...
```
**Neden yazıldı?** Gerçek hayattaki bir IoT cihazını (sensör, gateway vs.) kod ortamına aktarmak için bir kalıp oluşturuyoruz.
**Set Kullanımı:** `acikPortlar` için neden `List` yerine `Set` kullandık? Çünkü bir cihazda örneğin "80/HTTP" portu açıksa, aynı port tekrar tekrar listede bulunmamalı. Set, içindeki verilerin tekrarlanmasını otomatik olarak engeller. (Bugün derste gördüğümüz mükerrer verileri engelleme konusu).

```dart
bool get guvenlikAcigiVarMi => !sslSertifikasiGecerliMi || acikPortlar.contains("23/TELNET");
```
**Getter (get) Kullanımı:** Bu bir değişkene benziyor ama aslında hesaplama yapan küçük bir fonksiyondur. SSL sertifikası geçerli değilse (`!`) VEYA (`||`) açık portların içinde "23/TELNET" kelimesi varsa (`contains`), bu cihaz tehlikeli kabul edilip `true` döndürecektir.





## 4. Listelerde Filtreleme (.where Metodu)
```dart
final riskliCihazlar = cihazlar.where((cihaz) => cihaz.guvenlikAcigiVarMi || cihaz.cpuYukYuzdesi > 85.0).toList();
```
**Neden yazıldı?** Elimizde 6 tane cihaz olan bir liste var. Biz bunlardan sadece "riskli olanları" ayıklamak istiyoruz. `where()` metodu döngü (for) kullanmaya gerek kalmadan tüm listeyi süzer. İçerideki kuralımız: "Güvenlik açığı varsa VEYA CPU yükü %85'ten büyükse, bunu yeni listeye al." 




## 5. Bütün Verileri Toplama (.fold Metodu)
```dart
final int toplamBellek = cihazlar.fold(0, (toplam, cihaz) => toplam + cihaz.bellekMb);
```
**Neden yazıldı?** Tüm cihazların toplam kullandığı RAM (Bellek) miktarını bulmak istiyoruz. 
*   `0`: Toplama işlemine 0'dan başlıyoruz.
*   `(toplam, cihaz)`: `toplam` kümülatif olarak biriken sayıdır. `cihaz` ise listedeki o anki cihazdır. Her adımda "mevcut toplama, bu cihazın belleğini ekle" diyoruz ve tüm listeyi tek bir sayı haline getiriyoruz. 





## 6. Dart 3 Switch Expression (Bölge Belirleme)
```dart
String izolasyonBolgesiGetir(CihazTipi tip) {
  return switch (tip) {
    CihazTipi.sensor => "ZONE-S",
    CihazTipi.gateway => "ZONE-G",
    CihazTipi.edgeServer => "ZONE-E",
    CihazTipi.router => "ZONE-R",
  };
}
```
**Neden yazıldı?** Uzun uzun `if-else` yazmak yerine Dart 3 ile gelen muazzam `Switch Expression` özelliğini kullanıyoruz. Cihaz tipi neyse ok işareti `=>` ile karşılığındaki String (metin) değerini anında döndürüyor. 





## 7. Dart 3 Record İle Çoklu Veri Döndürme
```dart
(String, CihazTipi, bool) cihazBilgisiGetir(String seriNoAranan) {
  // ...
  return (cihaz.cihazAdi, cihaz.tip, alarmDurumu);
}
```
**Neden yazıldı?** Normalde bir fonksiyondan `return` ile sadece BİR TANE veri döndürebiliriz (örneğin sadece String). Ama Cihaz adını, Tipini ve Alarm Durumunu aynı anda döndürmemiz isteniliyor. İşte parantezler `( )` kullanarak 3 farklı bilgiyi tek bir pakette döndürme işlemine **Record** diyoruz. Bu değerleri alırken de `sonuc.$1`, `sonuc.$2` gibi indeksler kullanıyoruz.





## 8. Hata Fırlatma (Throw) ve Yakalama (Try-Catch)
```dart
if (cihaz == null) {
  throw CihazErisilemezException("HATA: Cihaz bulunamadı!");
}
```
**Neden yazıldı?** Kullanıcı var olmayan bir cihazı arattığında veya cihaz kapalı olduğunda, uygulamanın çökmesini engellemek için `throw` ile bilinçli olarak hatayı fırlatıyoruz. "Burada bir sorun var!" diyoruz.

```dart
try {
  final sonuc = cihazBilgisiGetir("SNSR-002");
  // Başarılı ise burası çalışır
} catch (e) {
  // Hata fırlatıldıysa burası yakalar
  print("Hata Mesajı: $e");
}
```
**Neden yazıldı?** Yukarıda fırlattığımız "Burada sorun var!" mesajını `try-catch` havada kapar. `try` bloğu "Bu kodları çalıştırmayı dene" der, eğer fırlatılmış bir `Exception` (hata) gelirse anında `catch` bloğuna düşer ve uygulama çökmeden kullanıcıya kibarca "Cihaz bulunamadı" yazdırırız.

---
### Özet
Bu projeyi baştan sona dikkatlice incelediğimizde, Dart dilindeki modern özelliklerin birbiriyle ne kadar uyumlu çalıştığını görüyoruz. `IoTCihaz` şablonuyla cihazlar ürettik, `where` ve `fold` ile dataları işledik, `Record` ile pratik paketler taşıdık ve `try-catch` ile uygulamanın çökmesini engelledik.

