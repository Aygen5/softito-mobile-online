// Exception (istisna / hata) yönetimine
// hata olduğunda kullanabileceğimiz kendi özel hata sınıflarımızı oluşturuyoruz.

//Burada Cloud adında özel bir hata sınıfı oluşturuyoruz.
//implements Exception: “Bu sınıf bir Exception gibi kullanılacak.”

class Cloud implements Exception {
  //Her Cloud hatasının 3 bilgisi olacak:

  final String hataKodu;
  final String mesaj;
  final DateTime zaman = DateTime.now();

  // Constructor
  Cloud(this.hataKodu, this.mesaj);

  // Bu da hata nesnesini print ettiğimizde nasıl görüneceğini belirliyor.
  @override
  String toString() => "[$hataKodu] $mesaj ($zaman)";
}

// CpuOverload, Cloud sınıfının özel bir türüdür.
// loud genel hata sınıfı. CpuOverload ise CPU aşırı yüklenmesi hatası.
class CpuOverload extends Cloud {
  final double mevcutCpu;
  final double limit;

  // Constructor
  CpuOverload({required this.mevcutCpu, required this.limit})
    : super(
        //super burada üst sınıfın (Cloud) constructor'ını çağırıyor.
        "Err_cpu_overload",
        "Cpu kullanımı eşik limitini ($limit) aştı: $mevcutCpu%",
      );
}

// Fonksiyonun amacı: Bir pod CPU istediğinde, sistemde yeterli CPU var mı kontrol etmek. Sorun varsa hata fırlatmak.
void podKaynagiTahsisEt(
  String podAdi,
  double talepEdilenCpu,
  double sistemKalanCpu,
) {
  if (talepEdilenCpu <= 0) {
    // İlk kontrol
    throw Cloud(
      // throw: “Bir hata oluştu, bu hatayı dışarı fırlat.”
      "Err_invalid_param",
      "Talep Edilen cpu pozitif bir değer olmalıdır.",
    );
  }
  if (talepEdilenCpu > sistemKalanCpu) {
    //İkinci kontrol
    throw CpuOverload(
      mevcutCpu: 100 - sistemKalanCpu + talepEdilenCpu,
      limit: 100.0,
    );
  }

  print(
    "Pod [$podAdi] başarıyla tahsis edildi:Kalan boş cpu: ${sistemKalanCpu - talepEdilenCpu}%",
  );
}

// Exception → hata nesnesi
// Cloud → kendi genel hata sınıfımız
// CpuOverload → özel CPU hatamız
// throw → hatayı fırlat

//A maç: “Bu kodu çalıştırmayı dene; hata çıkarsa program patlamasın, hatayı yakala.”
// try → dene
// throw → hata fırlat
// catch → hatayı yakala
void main() {
  print("Yönetim Paneli");
  // başarılı tahsis
  try {
    podKaynagiTahsisEt("ingress-controller", 15.0, 40.0);
  } catch (e) {
    print("Hata: $e");
  }




  // Cpu Aşım Hatası Yakalama
  try {
    podKaynagiTahsisEt("ai-training-pd", 75.0, 20.0);
  } on CpuOverload catch (e) {       //on ... catch : Belirli hata türünü yakala
    print("Cpu hatası yakalandı");
    print("Hata kodu: ${e.hataKodu}");
    print("Mesaj: ${e.mesaj}");
    print("Aksiyon: Otomatik Aws Açma isteği Gönderildi");
  } on Cloud catch (e) {
    print("Bulut hatası: ${e.mesaj}");
  } catch (e, stackTrace) {
    print("Bilinmedik Sistem Hatası $e");
  } finally {
    print("Pod tahsis günlüğü kapatıldı.");
  }



}
