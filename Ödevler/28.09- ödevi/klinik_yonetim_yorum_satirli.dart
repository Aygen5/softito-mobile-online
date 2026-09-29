
// KLİNİK YÖNETİM SİSTEMİ - DETAYLI KOD AÇIKLAMALARI
// ============================================================================
// Bu dosyada, Dart programlama dilinin temel yapı taşlarını göreceğiz.
// Enum'lar, sınıflar (class), nesneler (object), fonksiyonlar ve koleksiyonlar
// (List, Map, Set) gibi kavramların ne işe yaradığını, nasıl kullanıldığını göreceğiz.
// ============================================================================

// 1. ENUMERATION (ENUM) NEDİR?
// Enum'lar (Numaralandırmalar), sadece bizim belirlediğimiz seçeneklerden birini alabilen özel veri tipleridir. Bu sayede yazım hatalarının (örneğin 'lazer' yerine 'layzer' yazmak gibi) önüne geçeriz. 
//Buna "Derleme Zamanı Güvenliği" denir.

// HizmetKategorisi adında bir enum oluşturuyoruz.
// Sadece bu 4 seçenekten biri seçilebilir. Başka bir şey seçilemez.
enum HizmetKategorisi { 
  ciltYenileme,    // 0. indeks
  medikalEstetik,  // 1. indeks
  lazerEpilasyon,  // 2. indeks
  Lipo             // 3. indeks
}

// SeansDurumu adında bir enum oluşturuyoruz.
// Bir seansın hangi aşamada olduğunu takip etmek için kullanılır.
enum SeansDurumu { 
  bekliyor,        // Henüz başlamadı
  odadaIslemde,    // Şu an işlem yapılıyor
  tamamlandi,      // Başarıyla bitti
  iptalEdildi      // Herhangi bir sebeple iptal edildi
}

// OdemeYontemi adında bir enum oluşturuyoruz.
// Müşterinin nasıl ödeme yaptığını takip etmek için seçeneklerimiz.
enum OdemeYontemi { 
  krediKarti,      
  havaleEft,       
  nakit,           
  klinikPaketKredisi // Müşterinin önceden aldığı paket
}


// ============================================================================
// 2. SINIFLAR (CLASSES) VE NESNE YÖNELİMLİ PROGRAMLAMA (OOP)
// Sınıflar, gerçek dünyadaki nesneleri bilgisayar ortamına aktarmak için kullandığımız şablonlardır. Örneğin bir "Danışan" (Müşteri) şablonu oluşturacağız.
// ============================================================================

// Danışan (müşteri) Modeli
class Danisan {
  // final: Bu değişkenin değeri bir kere atandıktan sonra değiştirilemez demek.
  // String: Metin tipi veriler (isim, telefon numarası vb.) için kullanılır.
  final String id;          // Danışana özel eşsiz kimlik numarası (Örn: DAN-101)
  final String adSoyad;     // Danışanın tam adı
  final String telefon;     // İletişim numarası
  
  // bool: Sadece true (doğru) veya false (yanlış) değerini alabilen veri tipi.
  final bool vipUyeMi;      // Müşteri VIP mi? (Evet/Hayır)

  // List<String>: İçinde birden fazla metin (String) barındıran bir liste.
  final List<String> alerjiler; // Alerjilerin listesi. Boş olabilir ama "yok" (null) olamaz!

  // String?: Sonundaki soru işareti (?) bu değerin "null" (boş/tanımsız) olabileceğini gösterir.
  // Yani her danışanın özel bir cilt notu olmak zorunda değildir.
  final String? ozelCiltNotu; 

  // CONSTRUCTOR (Yapıcı Metot)
  // Sınıftan yeni bir nesne (bir danışan) oluşturulurken çalıştırılan ilk kısımdır.
  // 'const' ile başına ekleyerek performans artışı sağlıyoruz (sabit kalacaklarını bildiriyoruz).
  const Danisan({
    required this.id,       // required: Bu bilginin verilmesi ZORUNLUDUR!
    required this.adSoyad,
    required this.telefon,
    this.vipUyeMi = false,  // Eğer VIP durumu belirtilmezse, otomatik olarak 'false' (hayır) kabul edilir.
    this.alerjiler = const [], // Eğer alerji listesi verilmezse, otomatik olarak boş bir liste atanır.
    this.ozelCiltNotu,      // Soru işareti (?) olduğu için zorunlu (required) yapmadık, boş bırakılabilir.
  });

  // GETTER (Okuma Fonksiyonu)
  // Bu özellik, bir değişken gibi çağrılır ama arkasında ufak bir hesaplama yatar.
  // "=>" işareti return (geri döndür) anlamına gelen kısa bir yazım şeklidir (Arrow function).
  bool get hassasCiltMi =>
      alerjiler.isNotEmpty; // Eğer alerji listesi boş DEĞİLSE true (hassas cilt) olur, boşsa false olur.

  // Bilgi Özet Kartı
  // Bu getter, danışanın bilgilerini okunaklı, tek bir metin cümlesi haline getirir.
  String get bilgiOzeti {
    // Eğer alerji listesi boşsa "Kayıtlı alerji yok" yazsın, 
    // doluysa '.join(", ")' metoduyla alerjileri araya virgül koyarak birleştirsin.
    final String alerjiBilgisi = alerjiler.isEmpty
        ? "Kayıtlı alerji yok"
        : "Alerjiler: ${alerjiler.join(", ")}";
    
    // '??' operatörü: Eğer sol taraf null (boş) ise, sağ taraftaki metni kullan demektir.
    final String notBilgisi = ozelCiltNotu ?? "Özel Medikal Not girilmemiş";
    
    // '?' ve ':' (Ternary If): Şart vipUyeMi doğruysa "VIP" yaz, yanlışsa "Standart" yaz.
    final String vipRozeti = vipUyeMi ? "VIP" : "Standart";
    
    // Tüm bilgileri '$' işareti ile tek bir String (metin) içinde birleştirip (String Interpolation) döndürüyoruz.
    return "$vipRozeti $adSoyad ($telefon) | $alerjiBilgisi | Not: $notBilgisi";
  }
}

// Seans (Randevu) Modeli
class SeansKaydi {
  final String seansKodu;          // Seansa ait eşsiz kod (Örn: SNS-2026-1)
  final Danisan danisan;           // Hangi danışana ait olduğu (Yukarıdaki Danisan sınıfını kullanıyoruz!)
  final HizmetKategorisi kategori; // Hangi kategori (Enum kullanıyoruz)
  final String islemAdi;           // İşlemin detaylı adı
  final double birimFiyat;         // double: Ondalıklı sayı tipi. (Örn: 2500.0)
  final int seansSayisi;           // int: Tam sayı tipi. Kaç seans sürecek?
  final double indirimOrani;       // Yüzde kaç indirim yapıldı? (Örn 10.0 = %10)
  final String? sorumluUzman;      // İşlemi yapacak uzman (null olabilir, henüz atanmamış olabilir)
  
  // final DEĞİLLER! Çünkü durum ve ödeme tipi seans sonrasında değişebilir (güncellenebilir).
  SeansDurumu durum;               // Seansın şu anki durumu
  OdemeYontemi? odemeTipi;         // Hangi yöntemle ödendi? (Seans bitince belli olacak, bu yüzden ? var)

  // Yapıcı Metot (Constructor)
  SeansKaydi({
    required this.seansKodu,
    required this.danisan,
    required this.kategori,
    required this.islemAdi,
    required this.birimFiyat,
    this.seansSayisi = 1,                 // Belirtilmezse varsayılan 1 seans
    this.indirimOrani = 0.0,              // Belirtilmezse %0 indirim
    this.sorumluUzman,                    // Atanmak zorunda değil
    this.durum = SeansDurumu.bekliyor,    // İlk oluşturulduğunda hep "bekliyor" statüsündedir
    this.odemeTipi,                       // Başlangıçta ödeme tipi yoktur
  });

  // brutTutar: İndirimsiz toplam fiyatı hesaplar (Birim fiyat x Seans sayısı)
  double get brutTutar => birimFiyat * seansSayisi;

  // indirimTutari: VIP durumu ve girilen indirim oranına göre kaç TL indirim yapılacağını hesaplar.
  double get indirimTutari {
    double toplamOran = indirimOrani; // Başlangıçta verilen indirim oranını aldık.
    
    // EĞER danışan VIP üye ise, mevcut indirim oranına ekstra %10 daha ekle!
    if (danisan.vipUyeMi) {
      toplamOran += 10.0;
    }
    
    // Matematik: Brüt Tutar'ın yüzde 'toplamOran' kadarını hesaplayıp TL cinsinden döndürüyoruz.
    return brutTutar * (toplamOran / 100.0);
  }

  // netTutar: Müşterinin cebinden çıkacak asıl tutar (Brüt - İndirim)
  double get netTutar => brutTutar - indirimTutari;
}


// ============================================================================
// 3. YÖNETİM SERVİSİ (Sistem Mantığı)
// Bütün bu oluşturduğumuz şablonları (sınıfları) bir araya getirip yönetecek olan bir "Beyin" (Yönetici) sınıfı tasarlıyoruz.
// ============================================================================

class KlinikYoneticisi {
  final String subeAdi; // Hangi şube? (Örn: Softito Bağcılar Şubesi)
  
  // private ('_') (Gizli) Değişkenler:
  // Bir değişken isminin başına alt çizgi (_) koyarsak, bu değişkene sadece bu sınıfın içinden erişilebilir. Dışarıdan kimse doğrudan bu listeyi kurcalayamaz.
  
  // _seanslar: Tüm randevuların tutulduğu gizli bir liste (List).
  final List<SeansKaydi> _seanslar = [];
  
  // _danisanRehberi: Danışanların ID'si ile (String) danışanın kendi bilgilerini (Danisan) eşleştiren bir Sözlük / Harita (Map). Tıpkı telefon rehberi gibi çalışır.
  final Map<String, Danisan> _danisanRehberi = {};

  KlinikYoneticisi({required this.subeAdi});

  // Danışan kaydetme fonksiyonu (Metot)
  // Parametre olarak dışarıdan bir 'Danisan' nesnesi alır ve haritaya ekler.
  void danisanKaydet(Danisan danisan) {
    _danisanRehberi[danisan.id] = danisan; // Danışanın id'si anahtar, kendisi değer oldu.
    
    // Ekrana bilgi yazdırıyoruz.
    print(
      "Rehbere Eklendi: ${danisan.adSoyad} (${danisan.vipUyeMi ? "VIP" : "Standart"})",
    );
  }

  // Yeni bir randevu kaydetme fonksiyonu
  void randevuOlustur(SeansKaydi seans) {
    _seanslar.add(seans); // Listeye .add() metoduyla yeni eleman ekliyoruz.
    print(
      "Randevu Kaydedildi [${seans.seansKodu}]: ${seans.danisan.adSoyad}->${seans.islemAdi}",
    );
  }

  // Müşteri işlemi bitirip ödeme yaptığında çağrılacak fonksiyon.
  // Parametreler süslü parantez {} içinde, yani "İsimlendirilmiş (Named)" parametrelerdir.
  void seansiTamamla({required String seansKodu, required OdemeYontemi odeme}) {
    // for-in döngüsü: _seanslar listesindeki her bir seansın içine tek tek bak.
    for (var seans in _seanslar) {
      // Eğer aradığımız seans kodu ile listedeki seans kodu eşleşirse, onu bulduk demektir!
      if (seans.seansKodu == seansKodu) {
        seans.durum = SeansDurumu.tamamlandi; // Durumunu güncelledik.
        seans.odemeTipi = odeme;              // Ödeme yöntemini kaydettik.
        
        // .toStringAsFixed(2): Ondalıklı sayının virgülden sonra sadece 2 basamağını göster. (Örn: 2500.00)
        // .name: Enum'un ismini (örneğin krediKarti) metin olarak verir.
        print(
          "Seans Tamamlandı: [${seans.seansKodu}]: ${seans.netTutar.toStringAsFixed(2)} tahsil edildi (${odeme.name})",
        );
        return; // Fonksiyonun çalışmasını burada durdur, aramaya devam etmene gerek kalmadı.
      }
    }
    // Eğer for döngüsü tamamen biter ve 'return' ile çıkılmazsa, seans bulunamamış demektir.
    print("Hata [$seansKodu] kodlu seans bulunamadı");
  }

  // İptal etme fonksiyonu. iptalNedeni zorunlu değil, verilmeyebilir ([] yerine {} kullanılmış).
  void seansiIptalEt(String seansKodu, {String? iptalNedeni}) {
    for (var seans in _seanslar) {
      if (seans.seansKodu == seansKodu) {
        seans.durum = SeansDurumu.iptalEdildi;
        print(
          "Seans İptal Edildi [${seans.seansKodu}]: ${iptalNedeni ?? "Gerekçe Belirtilmedi"}",
        );
        return; // İşi bitir ve çık.
      }
    }
  }


  // ============================================================================
  // 4. İLERİ DÜZEY FONKSİYONEL PROGRAMLAMA (Where, Fold, Map)
  // Burası en havalı kısım! Listeler üzerinde çok kolay filtreleme ve matematik işlemleri yapmamızı sağlayan modern kodlama yöntemleri göreceğiz.
  // ============================================================================

  // Toplam Tahsil Edilen Ciro (Sadece tamamlanan ve parası alınan seanslar)
  double get toplamTahsilEdilenCiro => _seanslar
      // 1. .where() filtreleme yapar. Sadece durumu 'tamamlandi' olan seansları alır.
      .where((s) => s.durum == SeansDurumu.tamamlandi)
      
      // 2. .fold() listedeki elemanları tek bir değere dönüştürmek (toplamak) için kullanılır.
      // 0.0'dan başla, her bir seansın netTutar'ını 'toplam' değişkenine ekleyerek ilerle.
      .fold(0.0, (toplam, s) => toplam + s.netTutar);

  // Bekleyen Potansiyel Ciro (Henüz ödemesi alınmamış aktif seanslar)
  double get beklenenPotansiyelCiro => _seanslar
      // Durumu 'bekliyor' VEYA (||) 'odadaIslemde' olanları filtrele.
      .where(
        (s) =>
            s.durum == SeansDurumu.bekliyor ||
            s.durum == SeansDurumu.odadaIslemde,
      )
      // Onların net tutarlarını topla.
      .fold(0.0, (toplam, s) => toplam + s.netTutar);


  // Kategori Bazlı Seans Sayıları (Hangi kategoride kaç seans yapıldığını bulmak)
  Map<HizmetKategorisi, int> kategoriBazliSeansDagilimi() {
    final Map<HizmetKategorisi, int> dagilim = {};
    
    // Önce tüm kategorileri sözlüğe 0 olarak ekliyoruz (Başlangıç ayarı).
    for (var kat in HizmetKategorisi.values) {
      dagilim[kat] = 0;
    }
    
    // Bütün seansları tek tek dolaş ve her seansın kendi kategorisine ait sayacı 1 arttır.
    for (var s in _seanslar) {
      // "dagilim[s.kategori] ?? 0" kısmı null ise 0 say mantığını korur.
      dagilim[s.kategori] = (dagilim[s.kategori] ?? 0) + 1;
    }
    return dagilim; // Hesaplanan listeyi geri gönder.
  }


  // Çalışan Uzmanların İsim Listesi (Tekrar etmeyen (Benzersiz) liste)
  // Set: Aynı elemanın iki kere bulunmasına izin vermeyen liste tipidir (Kümeler).
  Set<String> gorevliUzmanKadrosu() {
    return _seanslar
        // 1. .map(): Seanslar listesindeki her objeyi sadece "sorumluUzman" ismine dönüştürür.
        .map((s) => s.sorumluUzman)
        // 2. .whereType<String>(): Sadece metin dolu olanları al, null (boş atanmamış) olanları at çöpe.
        .whereType<String>()
        // 3. .toSet(): Set'e çevir. Böylece "Sümeyye Arab" ismi 5 farklı seansta geçse bile listede 1 kere yazar.
        .toSet();
  }

  // Henüz uzman atanmamış (sorumluUzman == null) olan seansların listesi.
  List<SeansKaydi> uzmansizSeanslar() {
    return _seanslar.where((s) => s.sorumluUzman == null).toList();
  }


  // ============================================================================
  // GÜN SONU RAPORU YAZDIRMA EKRANI
  // ============================================================================
  void gunSonuRaporuYazdir() {
    print("Günlük Seans ve İşlem Çizelgesi");
    print("----------------------------------------------------------------");
    
    // .padRight(sayı): Metnin sağına boşluk ekleyerek her sütunun düzgün hizalanmasını sağlar. Tablo görünümü verir.
    print(
      "${'Kod'.padRight(10)} | "
      "${'Danışan'.padRight(16)} | "
      "${'İşlem'.padRight(20)} | "
      "${'Uzman'.padRight(18)} | "
      "${'Tutar'.padRight(10)} | "
      "${'Durum'} | ",
    );
    print("----------------------------------------------------------------");

    // Tüm seansları tek tek ekrana yazdırma
    for (var s in _seanslar) {
      final String uzman = s.sorumluUzman ?? "Nöbetçi Bekliyor";
      
      // Dart 3 ile gelen MÜTHİŞ BİR ÖZELLİK: switch expression!
      // 'if-else' blokları yerine, s.durum neyse ona karşılık gelen metni anında 'durumRozet' değişkenine atar.
      final String durumRozet = switch (s.durum) {
        SeansDurumu.tamamlandi => "Tamamlandı",
        SeansDurumu.odadaIslemde => "İşlemde",
        SeansDurumu.bekliyor => "Bekliyor",
        SeansDurumu.iptalEdildi => "İptal",
      };

      print(
        "${s.seansKodu.padRight(10)} | "
        "${s.danisan.adSoyad.padRight(10)} | "
        "${s.islemAdi.padRight(10)} | "
        "${uzman.padRight(10)} | "
        "${s.netTutar.toStringAsFixed(2).padRight(10)} | "
        "$durumRozet",
      );
    }

    print("----------------------------------------------------------------");
    print("Finansal Özet:");
    print(
      " * Gerçekleşen (kasadaki net ciro) : ${toplamTahsilEdilenCiro.toStringAsFixed(2)}",
    );
    print(
      " * Bekleyen Potansiyel Alacak : ${beklenenPotansiyelCiro.toStringAsFixed(2)}",
    );
    // .length metodu, listede toplam kaç eleman (randevu) olduğunu sayar.
    print(" * Toplam Seans : ${_seanslar.length} Randevu");
    print("----------------------------------------------------------------");
    print("Aktif Uzmanlar");
    
    final uzmanlar = gorevliUzmanKadrosu();
    if (uzmanlar.isEmpty) {
      print("Kayıtlı Uzman Bulunamadı");
    } else {
      print(" ${uzmanlar.join(', ')}"); // İsimleri araya virgül koyarak yaz.
    }
    
    final uzmansizlar = uzmansizSeanslar();
    if (uzmansizlar.isNotEmpty) {
      print(
        "Dikkat: ${uzmansizlar.length} adet seansa henüz uzman atanmamıştır",
      );
      for (var u in uzmansizlar) {
        print("->[${u.seansKodu}] ${u.danisan.adSoyad} (${u.islemAdi})");
      }
    }
    print("----------------------------------------------------------------");
  }
}

// ============================================================================
// MAIN FONKSİYONU - PROJENİN ÇALIŞMAYA BAŞLADIĞI YER
// Bir Dart programı çalıştırıldığında sistem direkt olarak `main()` 
// isimli fonksiyonu bulur ve içindekileri yukarıdan aşağıya çalıştırmaya başlar.
// ============================================================================
void main() {
  print("Klinik yönetim sistemi başlatılıyor...");

  // Yönetici sınıfımızdan 'yonetici' adında bir obje (nesne) oluşturuyoruz.
  // Bu yönetici bizim tüm işlemlerimizi arka planda halledecek.
  final yonetici = KlinikYoneticisi(subeAdi: "Softito Bağcılar Şubesi");

  // Danışanlar (Müşteriler) oluşturuluyor...
  // Bu kısımlar yukarıda tanımladığımız şablonun (Constructor) içinin doldurulduğu yer.
  final d1 = Danisan(
    id: "DAN-101",
    adSoyad: "Ahmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: ["Retinol", "Aspirin"], // Liste veri tipi olduğu için köşeli parantez [] içinde veriyoruz.
    ozelCiltNotu: "Cilt bariyeri hassas",
  );
  
  final d2 = Danisan(
    id: "DAN-102",
    adSoyad: "Ahmet Yılan",
    telefon: "0555 555 55 55",
    vipUyeMi: false, // VIP değil.
    alerjiler: [],   // Hiçbir alerjisi yok (Boş liste).
  );
  
  final d3 = Danisan(
    id: "DAN-103",
    adSoyad: "Mehmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: ["Retinol", "Aspirin"],
  );
  
  final d4 = Danisan(
    id: "DAN-104",
    adSoyad: "Ahmet Mehmet Yılmaz",
    telefon: "0555 555 55 55",
    vipUyeMi: true,
    alerjiler: [],
    ozelCiltNotu: "Cilt bariyeri hassas",
  );

  // Yöneticinin .danisanKaydet() fonksiyonunu kullanarak oluşturduğumuz 
  // müşteri nesnelerini sisteme/rehbere tek tek kaydediyoruz.
  yonetici.danisanKaydet(d1);
  yonetici.danisanKaydet(d2);
  yonetici.danisanKaydet(d3);
  yonetici.danisanKaydet(d4);

  print("Danışan güvenlik kontrolü");
  // Müşterilerin yukarıda hazırladığımız o özet yazılarını ekrana bastırıyoruz.
  print(d1.bilgiOzeti);
  print(d2.bilgiOzeti);
  print("----------------------------------");

  // Seanslar (Randevular) oluşturuluyor...
  final seans1 = SeansKaydi(
    seansKodu: "SNS-2026-1",
    danisan: d1,                      // Bu seans 1. Danışana (Ahmet Yılmaz) aittir diye tanımladık!
    kategori: HizmetKategorisi.Lipo,  // Enum içinden Lipo'yu seçtik.
    islemAdi: "Lipo gerisini bilmiyorum",
    birimFiyat: 6500.0,
    seansSayisi: 2,
    indirimOrani: 5.0,                // %5 standart indirim. (Üstüne bir de VIP olduğu için %10 daha alacak)
    sorumluUzman: "Sümeyye Arab",
  );
  
  final seans2 = SeansKaydi(
    seansKodu: "SNS-2026-2",
    danisan: d2,
    kategori: HizmetKategorisi.ciltYenileme,
    islemAdi: "Siverex ile yüz temizleme", // Yazım hatası vardı 'tyüz' diye, düzelttik
    birimFiyat: 2500.0,
    seansSayisi: 5,
    indirimOrani: 15.0,
    sorumluUzman: null, // Bilerek uzman atamadık, null verdik ki 'Bekleyen uzman uyarısını' görelim.
  );
  
  final seans3 = SeansKaydi(
    seansKodu: "SNS-2026-3",
    danisan: d3,
    kategori: HizmetKategorisi.lazerEpilasyon,
    islemAdi: "Tüm Vücut",
    birimFiyat: 25000.0,
    seansSayisi: 15,
    indirimOrani: 0.0,
    sorumluUzman: "Tuba Aydın",
  );
  
  final seans4 = SeansKaydi(
    seansKodu: "SNS-2026-4",
    danisan: d4,
    kategori: HizmetKategorisi.medikalEstetik,
    islemAdi: "Burun Estetiği",
    birimFiyat: 1500.0,
    seansSayisi: 3,
    sorumluUzman: "Alaaddin Odabaşı",
  );

  // Yöneticinin .randevuOlustur() metodunu çağırarak hazırladığımız randevuları sisteme girdik.
  yonetici.randevuOlustur(seans1);
  yonetici.randevuOlustur(seans2);
  yonetici.randevuOlustur(seans3);
  yonetici.randevuOlustur(seans4);
  print("Seanslar Gönderiliyor");

  // Gün içindeki olaylar simüle ediliyor...
  
  // Seans 1 başarıyla tamamlandı diyelim ve kredi kartı ile ödendiğini sisteme işleyelim.
  yonetici.seansiTamamla(
    seansKodu: "SNS-2026-1",
    odeme: OdemeYontemi.krediKarti,
  );
  
  // Seans 2 başarıyla tamamlandı, nakit alındı.
  yonetici.seansiTamamla(seansKodu: "SNS-2026-2", odeme: OdemeYontemi.nakit);
  
  // Seans 4 iptal ediliyor.
  // Burada fark ettiyseniz SNS-2026-04 yazılmış ama kodu SNS-2026-4 idi.
  // Sınıf içindeki for-in döngüsü bu koda sahip randevuyu bulamayacak ve iptal işlemi başarısız olacaktır. 
  // (Ufak bir yazım hatasından dolayı çalışmayacak, bunu da fark edelim diye buraya not düşüyoruz.)
  yonetici.seansiIptalEt(
    "SNS-2026-04",
    iptalNedeni: "Danışanın şehir dışından tanıdığı geldiği için gelemedi",
  );

  // Gün sonu geldi! Sistemin tüm verileri hesaplayıp bize şık bir tablo çıkarmasını istiyoruz.
  yonetici.gunSonuRaporuYazdir();
}
