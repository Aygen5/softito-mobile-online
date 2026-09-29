class SunucuMetrigi {
  // Yani bir sunucunun hangi bilgileri taşıyacağını tanımlayan şablon.
  // Her SunucuMetrigi nesnesinde bunlar olacak:
  final String hostAdi;
  final String bolge;
  final double cpuYuzdesi;
  final double ramGb;
  final int aktifBaglantiSayisi;
  final bool kritikMi;

  // constructor
  // Bu kısım nesne oluştururken başlangıç değerlerini vermemizi sağlıyor.  this = Gelen değeri bu nesnenin alanına bağla.
  const SunucuMetrigi({
    required this.hostAdi,
    required this.bolge,
    required this.cpuYuzdesi,
    required this.ramGb,
    required this.aktifBaglantiSayisi,
    this.kritikMi = false, //= değer = Verilmezse varsayılan değer.
  });

  // toString() metodunu ezip kendi istediği çıktıyı tanımlıyor.
  @override
  String toString() =>
      "$hostAdi [$bolge] (CPU: %$cpuYuzdesi, Ram: ${ramGb}GB, Conn: $aktifBaglantiSayisi)";
}

void main() {
  //Program çalışmaya başladığında ilk olarak buradaki kodları çalıştır.
  print("Cloud Temelleri");

  //az önce oluşturduğumuz SunucuMetrigi class'ından 5 tane nesne oluşturup bunları bir List'in içine koyduk.

  final List<SunucuMetrigi> sunucuKumesi = [
    //Bir SunucuMetrigi listesi oluşturduk.
    //Burada constructor'ı kullanarak bir nesne oluşturuyoruz.
    SunucuMetrigi(
      hostAdi: "srv-eu-01",
      bolge: "eu-west",
      cpuYuzdesi: 45.2,
      ramGb: 16.0,
      aktifBaglantiSayisi: 1200,
      kritikMi: true,
    ),
    SunucuMetrigi(
      hostAdi: "srv-eu-02",
      bolge: "eu-west",
      cpuYuzdesi: 88.5,
      ramGb: 32.0,
      aktifBaglantiSayisi: 4500,
      kritikMi: true,
    ),
    SunucuMetrigi(
      hostAdi: "srv-us-01",
      bolge: "us-east",
      cpuYuzdesi: 22.0,
      ramGb: 8.0,
      aktifBaglantiSayisi: 450,
      kritikMi: false,
    ),
    SunucuMetrigi(
      hostAdi: "srv-us-02",
      bolge: "us-east",
      cpuYuzdesi: 94.6,
      ramGb: 64.0,
      aktifBaglantiSayisi: 8900,
      kritikMi: true,
    ),
    SunucuMetrigi(
      hostAdi: "srv-ap-01",
      bolge: "ap-south",
      cpuYuzdesi: 62.4,
      ramGb: 16.0,
      aktifBaglantiSayisi: 2000,
      kritikMi: false,
    ),
  ];

  //where() = "Hangileri şartı sağlıyor?"
  // where() ile filtreleme : cpu kullanımı %80 üzerinde olan sunucular

  final asiriYukluSunucular = sunucuKumesi
      .where((s) => s.cpuYuzdesi >= 80.0) //Listedeki her sunucuya tek tek bakıyor.  (s)→ o anda kontrol edilen sunucu.
      .toList(); //where() sonucunu tekrar List'e çeviriyor.
  print("Aşırı Yüklü Sunucular (${asiriYukluSunucular.length})");
  asiriYukluSunucular.forEach(
    (s) => print("* $s"),
  ); //foreach ile Listedeki her sunucuyu tek tek dolaşıp yazdırıyor.

  //map() ile dönüştürme.Sunucu adları ve bağlantı sayılarını alarm etiketine çevirme

  final List<String> alarmEtiketleri = sunucuKumesi
      .map(
        //Burada listedeki her sunucuyu tek tek alıp başka bir değere dönüştürüyoruz.
        (s) =>
            "[Alert-Monitor] ${s.hostAdi.toLowerCase()} ->Aktif Trafik ${s.aktifBaglantiSayisi}",
      )
      .toList();
  print("Alarm Çıktıları (ilk 3 tane)");
  alarmEtiketleri.take(3).forEach((e) => print(" $e"));

  // fold() ile toplam aktif trafik gösterimi
  // fold = Listedeki bütün değerleri bir araya getirip TEK BİR sonuç üretmek.
  // Bu örnekte bütün sunucuların aktif bağlantı sayılarını topluyor.
  final int toplamBaglantiSayisi = sunucuKumesi.fold(
    0, //Buradaki 0 başlangıç değeri. toplam = 0 ile başlıyor.
    (toplam, sunucu) =>
        toplam +
        sunucu
            . //Her sunucuda iki şey var: toplam → o ana kadar biriken toplam sunucu → şu anda işlem yapılan sunucu
            aktifBaglantiSayisi,
  );
  print("Toplam Bağlantı: $toplamBaglantiSayisi");

  //every() ve any()
  //every() → Hepsi mi?
  //every() listedeki her elemanı kontrol eder. Bir tane bile sağlamazsa false.

  //any() → En az biri mi?
  //En az bir tane şartı sağlıyor mu? Bir tane bulması yeterli.

  final bool tumSunucularCalisiyormu = sunucuKumesi.every(
    (s) => s.ramGb >= 8.0,
  );
  final bool tehlikeliSunucuVarMi = sunucuKumesi.any(
    (s) => s.cpuYuzdesi >= 90.0,
  );
  print(
    "Tüm sunucuların Ram'i en az 8 gb mı? : ${tumSunucularCalisiyormu ? 'Evet' : 'Hayır'}",
  );
  print(
    "Cpu kullanımı %90'ı aşan varmı? : ${tehlikeliSunucuVarMi ? 'Evet' : 'Hayır'}",
  );

  //Dolayısıyla çıktı: Tüm sunucuların Ram'i en az 8 gb mı? : Evet Cpu kullanımı %90'ı aşan varmı? : Evet





  //where + map + fold yapılarını tek bir işlemde birleştiriyoruz.
  //Amaç: eu-west bölgesindeki kritik sunucuların ortalama CPU kullanımını bulmak.

  final euWestSunuculari = sunucuKumesi
      .where((s) => s.bolge == "eu-west" && s.kritikMi)    // where() ile sunucuları filtreliyor. Burada iki şart aynı anda aranıyor:
      .toList();
  final double euWestOrtalamaCpu =
      euWestSunuculari
          .map((s) => s.cpuYuzdesi)                        // map() ile sadece CPU değerlerini alıyor. Artık elimizde SunucuMetrigi nesneleri yerine sadece CPU değerleri var:
          .fold(0.0, (acc, cpu) => acc + cpu) /            // fold() ile CPU'ları topluyor. Başlangıç: acc = 0.0
      euWestSunuculari.length;  //length ile sunucu sayısını buluyor. Dolayısıyla: 133.7 / 2 = 66.85  Ortalama CPU: %66.85
  print(
    "Eu West bölgesi Kritik sunucu orlama CPU: ${euWestOrtalamaCpu.toStringAsFixed(2)}",  //toStringAsFixed(2) -> Virgülden sonra 2 basamak gösterir.
  );


  // Sonuç Eu West bölgesi Kritik sunucu orlama CPU: 66.85
  // Buradaki zincir
  // sunucuKumesi
    //.where((s) => ...)
    //.map((s) => ...)
    //.fold(...)
//Türkçesi: Önce istediğim sunucuları seç → sonra onlardan istediğim bilgiyi çıkar → sonra o bilgileri tek sonuç haline getir.


//Burada tam olarak:
  //where → kritik EU sunucularını seçti
  //map → CPU'larını aldı
  //fold → CPU'ları topladı
  // / length → ortalamasını buldu

}
