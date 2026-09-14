# Değişiklik Günlüğü (Changelog)

Tüm önemli değişiklikler bu dosyada belgelenecektir.
Format [Keep a Changelog](https://keepachangelog.com/tr/1.0.0/) ve [Semantic Versioning](https://semver.org/lang/tr/)'e uygundur.

## [v1.1.0] - 2026-09-14 (SOLID Refactoring & Clean Code Ödevi)

### Eklendi
- `SOLID_Odev_Raporu.pdf`: Tespit edilen 5 temel SOLID ihlalinin tek tek incelendiği resmi A4 ödev raporu.
- `lib/solid_refactored_order_system.dart`: SOLID ve Clean Code kurallarına göre baştan sona refactor edilmiş sipariş sistemi.
- Strategy Pattern ile `IOdemeYontemi` ve `IKuponStratejisi` mimarisi.
- Constructor Dependency Injection ile gevşek bağlı (loosely coupled) mimari.
- `IKargolanabilir` arayüzü ile LSP ihlali çözümü.

### Değiştirildi
- `README.md` ödev detayları ve sürüm bağlantıları ile zenginleştirildi.

## [v1.0.0] - 2026-09-14 (14 Eylül Release Denemesi)

### Eklendi
- Repository yapısı kuruldu.
- Açıklayıcı `README.md` ve `.gitignore` dosyaları oluşturuldu.
- Uzak GitHub deposu (`origin`) bağlantısı sağlandı.
- İlk sürüm etiketi (`v1.0.0`) yayımlandı.
