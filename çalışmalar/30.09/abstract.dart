
//Anlamı: Bu sınıftan doğrudan nesne oluşturma.
abstract class LoncaUyeti {
  final String rumuz;    //Her lonca üyesinin bir rumuzu olacak.


 //Constructor -> Lonca üyesi oluşturulurken rumuz verilmesini zorunlu tutuyor. Alt sınıflar bunu kullanabilecek.
  LoncaUyeti({required this.rumuz});

  //Soyut metot (abstract method)
  //"Her lonca üyesinin özel yeteneği olmak zorunda ama bunun nasıl yapılacağını ben söylemiyorum"
  void ozelYetenekKullan();

  //normal bir metot:
  void loncaSelamVer() {
    print("$rumuz Lonca Bayrağını Selamadı:'Onur ve zafer için'");
  }
}


//Şövalye, LoncaUyeti sınıfından miras alıyor. -> Dolayısıyla rumuz gibi özellikleri kullanabiliyor.
class Sovalye extends LoncaUyeti {
  Sovalye({required super.rumuz});   //Constructor

  @override
  void ozelYetenekKullan() {
    print("$rumuz Demir kalkanını kaldırdı ve savunma duvarı ördü");
  }
}

class Sifaci extends LoncaUyeti {
  Sifaci({required super.rumuz});

  @override
  void ozelYetenekKullan() {
    print("$rumuz Kutsal ışık büyüsüyle tüm takımın canını tazeledi");
  }
}

//abstract class
//→ Ortak temel oluşturur.
//→ Doğrudan nesne oluşturulmaz.

//abstract method
//→ Alt sınıfa görev verir.
//→ "Bu metodu sen yazmak zorundasın."

//@override
//→ Alt sınıf bu görevi kendi şekilde gerçekleştirir.


//artık birden fazla lonca üyesini tek bir takım olarak yönetiyoruz.
void savasAlanindaKomutVer(List<LoncaUyeti> takim) {   //İçinde LoncaUyeti türünden nesneler bulunan bir liste.
  print("Liderin Emriyle Takim Yetenekleri Devreye Girsin");
  for (var t in takim) {   //Bu, takımın içindeki her üyeyi tek tek dolaşıyor.
    t.loncaSelamVer();
    //Herkes kendi özel yeteneğini kullansın
    t.ozelYetenekKullan();   //Ve hangi sınıftan nesne geldiyse onun override ettiği metot çalışıyor.
  }
  //t.ozelYetenekKullan(); farklı nesnelerde farklı davranış oluşturuyor. Bu konuya polymorphism (çok biçimlilik) deniyor.
  //Aynı komut: t.ozelYetenekKullan()
  //Ama nesneye göre:
  //Sovalye → kendi yeteneği
  //Sifaci  → kendi yeteneği
}


void main() {   //bütün sistemi çalıştırıyoruz.
  print("Lonca Takımı");
  final List<LoncaUyeti> loncaBirligi = [    //Lonca takımı oluşturuluyor
    Sovalye(rumuz: "Kızıl Şövalye Adil"),
    Sifaci(rumuz: "Orman Perisi Shahd"),
    Sovalye(rumuz: "Gümüş Muhafız Eren"),
  ];

  //Sovalye → LoncaUyeti'den türedi
  //Sifaci  → LoncaUyeti'den türedi
  //Bu yüzden ikisini de aynı listede tutabiliyoruz.

  //Hepsine tek bir emir ile çalıştırıyoruz
  savasAlanindaKomutVer(loncaBirligi);
}




// ABSTRACT CLASS + POLYMORPHISM ÖZETİ


// 1. ABSTRACT CLASS
// abstract class → Doğrudan nesnesi oluşturulamayan temel sınıftır.
// abstract class LoncaUyeti
// Ortak özellikleri ve davranışları tanımlamak için kullanılır.
// Alt sınıflara bir yapı/şablon sağlar.


// 2. SOYUT METOT (ABSTRACT METHOD)
// Gövdesi olmayan metottur.
// void ozelYetenekKullan();
// Burada "nasıl yapılacağı" belirtilmez.
// Sadece "bu metot bulunmak zorunda" denir.
// Alt sınıflar bu metodu @override ile kendileri yazmak zorundadır.


// 3. ORTAK METOT
// Abstract class içinde normal metot da bulunabilir.
// void loncaSelamVer() { ... }
// Bu metot bütün alt sınıflar tarafından ortak olarak kullanılır.
// Alt sınıfların tekrar tekrar aynı kodu yazmasına gerek kalmaz.


// 4. EXTENDS
// Bir sınıfın başka bir sınıftan miras almasını sağlar.
// class Sovalye extends LoncaUyeti
// class Sifaci extends LoncaUyeti
// Sovalye ve Sifaci,
// LoncaUyeti'nin özelliklerini ve metotlarını alır.


// 5. @OVERRIDE
// Üst sınıftaki bir metodun alt sınıfta
// farklı şekilde uygulanmasını sağlar.
// @override
// void ozelYetenekKullan() { ... }
// Şövalye → savunma yeteneği kullanır.
// Şifacı → iyileştirme yeteneği kullanır.
// Aynı metot adı vardır ama davranış farklıdır.


// 6. POLYMORPHISM (ÇOK BİÇİMLİLİK)
// Farklı sınıflardan gelen nesneleri,
// ortak bir üst sınıf üzerinden yönetebilmemizdir.
// List<LoncaUyeti> takim
// Bu listenin içinde:
// → Sovalye
// → Sifaci
// → Sovalye
// bulunabilir.
// Hepsi LoncaUyeti olduğu için aynı listede tutulabilir.


// 7. TEK KOMUT, FARKLI DAVRANIŞ
// t.ozelYetenekKullan();
// Burada t'nin Sovalye mi Sifaci mi olduğunu
// tek tek kontrol etmiyoruz.
// Sovalye ise → Şövalyenin metodu çalışır.
// Sifaci ise → Şifacının metodu çalışır.
// İşte bu POLYMORPHISM'dir.


// 8. FOR DÖNGÜSÜ İLE TAKIMI YÖNETME
// for (var t in takim)
// Listedeki her karakter tek tek alınır
// ve aynı komutlar uygulanır.
// t.loncaSelamVer();
// t.ozelYetenekKullan();



// SİSTEMİN GENEL MANTIĞI

//
//                 LoncaUyeti
//                 (abstract)
//                      │
//          ┌───────────┴───────────┐
//          ↓                       ↓
//       Sovalye                  Sifaci
//          │                       │
//     Kalkan yeteneği         İyileştirme yeteneği
//
//
// Tek liste:
// List<LoncaUyeti>
//
//          ↓
//
// Tek komut:
// savasAlanindaKomutVer(takim)
//
//          ↓
//
// Her karakter kendi davranışını çalıştırır.


// KISACA

// abstract class → Ortak temel yapı oluşturur.
// abstract method → Alt sınıfların uygulaması gereken metot.
// extends → Miras almayı sağlar.
// @override → Metodu alt sınıfta yeniden tanımlar.
// List<ÜstSınıf> → Farklı alt sınıfları aynı listede tutabilir.
// polymorphism → Aynı komut, nesnenin tipine göre farklı davranır.

// EN ÖNEMLİ FİKİR:
// "Tek bir üst sınıf üzerinden farklı nesneleri
//  tek bir sistemle yönetebilmek."

// Örnek:
// Sovalye → ozelYetenekKullan() → Kalkan
// Sifaci  → ozelYetenekKullan() → İyileştirme
// İkisi de:
// t.ozelYetenekKullan();
// komutuyla çalıştırılabilir.

