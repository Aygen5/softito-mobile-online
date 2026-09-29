
// IoT AĞI YÖNETİM SİSTEMİ ÖDEVİ

// 1. Cihaz Tiplerini Oluşturma (Enum) -> Ağda bulunabilecek cihaz türlerini güvenli bir şekilde belirtir.
enum CihazTipi {
  sensor,
  gateway,
  edgeServer,
  router
}

//  Özel Exception Sınıfı -> Bir cihaza ulaşılamadığında veya cihaz kapalı olduğunda fırlatılacak özel hata.
class CihazErisilemezException implements Exception {
  final String mesaj;
  CihazErisilemezException(this.mesaj);

  @override
  String toString() => mesaj;
}

// 2. IoTCihaz Sınıfı (Class) -> Bir IoT cihazının taşıması gereken tüm özellikleri (veri alanlarını) içerir.
class IoTCihaz {
  final String seriNo;
  final String cihazAdi;
  final CihazTipi tip;
  final double cpuYukYuzdesi;
  final int bellekMb;
  final Set<String> acikPortlar; // Aynı porttan iki tane olamayacağı için Set kullanıldı.
  final bool sslSertifikasiGecerliMi;
  final bool aktifMi;  // Ekstra durum: Cihazın kapalı olup olmadığını anlamak için eklendi (Exception testi için)

  IoTCihaz({
    required this.seriNo,
    required this.cihazAdi,
    required this.tip,
    required this.cpuYukYuzdesi,
    required this.bellekMb,
    required this.acikPortlar,
    required this.sslSertifikasiGecerliMi,
    this.aktifMi = true, // Belirtilmezse varsayılan olarak cihaz açık (true) kabul edilir.
  });

  // Güvenlik Açığı Getter'ı -> SSL sertifikası geçersizse VEYA 23/TELNET portu açıksa cihaz riskli sayılır.
  bool get guvenlikAcigiVarMi => !sslSertifikasiGecerliMi || acikPortlar.contains("23/TELNET");
}

void main() {
  print("=== IoT Ağı Yönetim Sistemi Başlatılıyor ===\n");

  // 3. Cihazları Oluşturma (En az 6 farklı cihaz Listesi)
  final List<IoTCihaz> cihazlar = [
    IoTCihaz(
      seriNo: "SNSR-001",
      cihazAdi: "Sıcaklık Sensörü",
      tip: CihazTipi.sensor,
      cpuYukYuzdesi: 15.5,
      bellekMb: 128,
      acikPortlar: {"80/HTTP"},
      sslSertifikasiGecerliMi: true,
    ),
    IoTCihaz( // Riskli Cihaz 1 (CPU yüksek)
      seriNo: "GTW-001",
      cihazAdi: "Ana Gateway",
      tip: CihazTipi.gateway,
      cpuYukYuzdesi: 92.0, 
      bellekMb: 1024,
      acikPortlar: {"443/HTTPS", "8080/TCP"},
      sslSertifikasiGecerliMi: true,
    ),
    IoTCihaz( // Riskli Cihaz 2 (SSL geçersiz)
      seriNo: "EDGE-001",
      cihazAdi: "Kenar Sunucu",
      tip: CihazTipi.edgeServer,
      cpuYukYuzdesi: 60.0,
      bellekMb: 4096,
      acikPortlar: {"443/HTTPS", "22/SSH"},
      sslSertifikasiGecerliMi: false, 
    ),
    IoTCihaz( // Riskli Cihaz 3 (Telnet portu açık)
      seriNo: "RTR-001",
      cihazAdi: "Omurga Router",
      tip: CihazTipi.router,
      cpuYukYuzdesi: 45.0,
      bellekMb: 2048,
      acikPortlar: {"23/TELNET", "80/HTTP"}, 
      sslSertifikasiGecerliMi: true,
    ),
    IoTCihaz( // Kapalı Cihaz (Exception fırlatılacak cihaz)
      seriNo: "SNSR-002",
      cihazAdi: "Nem Sensörü",
      tip: CihazTipi.sensor,
      cpuYukYuzdesi: 10.0,
      bellekMb: 256,
      acikPortlar: {},
      sslSertifikasiGecerliMi: true,
      aktifMi: false, // KAPALI
    ),
    IoTCihaz( // Riskli Cihaz 4 (Hem SSL geçersiz, Hem CPU yüksek, Hem Telnet)
      seriNo: "GTW-002",
      cihazAdi: "Yedek Gateway",
      tip: CihazTipi.gateway,
      cpuYukYuzdesi: 88.5,
      bellekMb: 1024,
      acikPortlar: {"23/TELNET", "21/FTP"},
      sslSertifikasiGecerliMi: false,
    ),
  ];


  // 4. Riskli Cihazları Bulun (where kullanımı)
  // Kriter: Güvenlik açığı var veya CPU %85'ten büyük
  final riskliCihazlar = cihazlar.where((cihaz) => cihaz.guvenlikAcigiVarMi || cihaz.cpuYukYuzdesi > 85.0).toList();

  print("--- RİSKLİ CİHAZLAR ---");
  for (var cihaz in riskliCihazlar) {
    print("- ${cihaz.cihazAdi} (${cihaz.seriNo})");
    print("  CPU: %${cihaz.cpuYukYuzdesi}, SSL Geçerli: ${cihaz.sslSertifikasiGecerliMi}, Portlar: ${cihaz.acikPortlar}");
  }
  print("");


  // 5. Toplam Bellek Kullanımını Hesaplayın (fold kullanımı)
  final int toplamBellek = cihazlar.fold(0, (toplam, cihaz) => toplam + cihaz.bellekMb);
  
  print("--- TOPLAM BELLEK KULLANIMI ---");
  print("Ağdaki tüm cihazların toplam RAM kullanımı: $toplamBellek MB\n");


  // 7. Cihaz Tipine Göre İzolasyon Bölgesi (Switch Expression kullanımı)
  String izolasyonBolgesiGetir(CihazTipi tip) {
    return switch (tip) {
      CihazTipi.sensor => "ZONE-S",
      CihazTipi.gateway => "ZONE-G",
      CihazTipi.edgeServer => "ZONE-E",
      CihazTipi.router => "ZONE-R",
    };
  }


  // 6. Seri Numarasına Göre Cihaz Bulma (Record kullanımı)
  // Geri dönüş tipi bir Record yapısıdır.
  (String, CihazTipi, bool) cihazBilgisiGetir(String seriNoAranan) {
    
    // Cihazı seri numarasına göre listede arıyoruz. İlk bulduğunu al, bulamazsa null dön.
    final cihaz = cihazlar.where((c) => c.seriNo == seriNoAranan).firstOrNull;

    // Cihaz hiç yoksa exception fırlat!
    if (cihaz == null) {
      throw CihazErisilemezException("HATA: $seriNoAranan seri numaralı cihaz ağda bulunamadı!");
    }

    // Cihaz var ama kapalıysa exception fırlat!
    if (!cihaz.aktifMi) {
      throw CihazErisilemezException("HATA: $seriNoAranan seri numaralı cihaz şu anda KAPALI durumda!");
    }

    // Alarm Durumu: Güvenlik açığı varsa veya CPU çok yüksekse Alarm = true
    bool alarmDurumu = cihaz.guvenlikAcigiVarMi || cihaz.cpuYukYuzdesi > 85.0;

    // Sonucu bir Record (tuple) olarak döndürüyoruz.
    return (cihaz.cihazAdi, cihaz.tip, alarmDurumu);
  }


  // 8. Cihaz Erişilemiyorsa Exception Fırlatın ve Try-Catch İle Yakalayın
  print("--- CİHAZ SORGULAMA VE HATA YÖNETİMİ (TRY-CATCH) ---");
  
  void sorguTestiYap(String testSeriNo) {
    print("Sorgulanan Seri No: $testSeriNo");
    try {
      // Metodu çağırıp Record'u alıyoruz.
      final sonuc = cihazBilgisiGetir(testSeriNo);
      
      // Record içindeki verilere $1, $2, $3 ile erişiyoruz.
      final String ad = sonuc.$1;
      final CihazTipi tip = sonuc.$2;
      final bool alarm = sonuc.$3;
      
      final String bolge = izolasyonBolgesiGetir(tip); // Bölge hesapla (Switch)

      print(" Durum: BAŞARILI");
      print(" Cihaz Adı: $ad | Bölge: $bolge | Alarm: ${alarm ? "VAR (RİSKLİ)" : "YOK (GÜVENLİ)"}\n");
      
    } catch (e) {
      // Hata yakalandığında (CihazErisilemezException) burası çalışacak.
      print(" Durum: BAŞARISIZ");
      print(" Hata Mesajı: $e\n");
    }
  }

  // Senaryo 1: Sağlıklı ve açık bir cihazı bul (Sensör 1)
  sorguTestiYap("SNSR-001");

  // Senaryo 2: Kapalı (offline) cihazı sorgula (Exception fırlatacak)
  sorguTestiYap("SNSR-002");

  // Senaryo 3: Listede hiç olmayan geçersiz bir seri numarası (Exception fırlatacak)
  sorguTestiYap("GW-BİLİNMEYEN");
  
  // Senaryo 4: Riskli bir cihazı bul (Alarm: Var dönmesi bekleniyor)
  sorguTestiYap("EDGE-001");
}
