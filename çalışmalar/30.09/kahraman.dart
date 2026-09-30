class Kahraman {
  final String ad;
  final String sinif;
  int seviye;
  double saldiriGucu;
  bool hayattaMi;

  //normal constructor
  Kahraman({
    required this.ad,
    required this.sinif,
    this.seviye = 1,
    this.saldiriGucu = 50.0,
    this.hayattaMi = true,
  });

  //named constructor  ->  "Bana sadece adı ver, ben geri kalan başlangıç değerlerini kendim ayarlayayım.""
  Kahraman.acemi({required this.ad})
    : sinif = "Çırak Savaşçı", //Buradaki : constructor initializer list başlatıyor. "Kahraman nesnesi daha oluşturulurken bu alanlara şu başlangıç değerlerini ver.""
      seviye = 1,
      saldiriGucu = 25.0,
      hayattaMi = true;


  //Bunun amacı: Kayıt edilmiş JSON verisinden bir Kahraman nesnesi oluşturmak.
  //factory ise şunu yapmamıza izin veriyor: "Ben constructor çağrıldığında biraz işlem yapacağım, sonra uygun bir Kahraman nesnesi döndüreceğim."
  //Burada yaptığı işlem JSON'dan değerleri okuyup Kahraman oluşturmak.
  //factory = Nesne oluştururken arada özel bir işlem yapıp sonunda nesne döndüren constructor.

  factory Kahraman.fromSaveJson(Map<String, dynamic> json) {     //Map<String, dynamic> json ne? -> Key'ler String, değerlerin tipi farklı olabilir. Bu yüzden dynamic kullanılmış.
    return Kahraman(
      ad: json["ad"] as String,                   //Yani JSON'dan gelen dynamic değerleri beklediğimiz tipe çeviriyoruz.
      sinif: json["sinif"] as String,
      seviye: json["seviye"] as int,
      saldiriGucu: (json["hasar"] as num).toDouble(),
      hayattaMi: json["hayatta"] as bool,
    );
  }


  //Bu bir class metodu. Kahraman kendisini ekrana yazdırabilsin

  void kartiYazdir() {
    print(
      "[$sinif] $ad | Seviye: $seviye | Güç: $saldiriGucu | Durum: ${hayattaMi ? 'Canlı' : 'Ruh Halinde'}",
    );
  }
}
  
 void main() {             //Program çalışmaya başlıyor ve ekrana: Karakter Üretimi yazıyor.
  print("Karakter Üretimi");


  final sampiyon = Kahraman(       //Normal constructor ile kahraman oluşturuyor
    ad: "Tuba Aydın",
    sinif: "Şövalye",
    seviye: 10,
    saldiriGucu: 120.0,
  );
  sampiyon.kartiYazdir();


final caylak = Kahraman.acemi(ad: "Furkan Çalışkan");
caylak.kartiYazdir();




final Map<String, dynamic> jsondanGelenKarakter = {   //Şimdi JSON'dan karakter geliyor. Bunu aslında oyunun kayıt dosyasından gelen veri gibi düşün.
  "ad": "Alaaddin",
  "sinif": "Ak Büyücü",
  "seviye": 50,
  "hasar": 350.5,
  "hayatta": true,
};
final efsane = Kahraman.fromSaveJson(jsondanGelenKarakter);
efsane.kartiYazdir();

}





// KAHRAMAN OLUŞTURMA YÖNTEMLERİ



// 1. NORMAL CONSTRUCTOR
// Her şeyi kendimiz belirleyerek Kahraman oluştururuz.
//
// Kahraman(
//   ad: "Tuba",
//   sinif: "Şövalye",
//   seviye: 10,
//   saldiriGucu: 120,
// );
//
// Yani:
// "Bana bir Kahraman oluştur ve özelliklerini ben vereyim."



// 2. NAMED CONSTRUCTOR
// Class içinde belirli bir amaç için hazırlanmış özel constructor'dır.
//
// Kahraman.acemi(
//   ad: "Furkan",
// );
//
// Burada sadece adı veriyoruz.
// Diğer değerler constructor tarafından otomatik belirleniyor.
//
// Yani:
// "Bana hazır bir acemi Kahraman oluştur."



// 3. FACTORY CONSTRUCTOR
// Dışarıdan gelen veriyi kullanarak Kahraman nesnesi oluşturur.
// Örneğin kayıt dosyasından veya JSON'dan gelen veriler.
//
// Kahraman.fromSaveJson(json);
//
// Yani:
// "Bu dışarıdan gelen verilerden bana bir Kahraman oluştur."



// GENEL MANTIK

//
//                       Kahraman class
//                              │
//             ┌────────────────┼────────────────┐
//             ↓                ↓                ↓
//          Normal            acemi        fromSaveJson
//        constructor         named           factory
//             │                │                │
//             ↓                ↓                ↓
//           Tuba             Furkan          Alaaddin
//          Şövalye             Çırak         Ak Büyücü
//             │                │                │
//             └────────────────┼────────────────┘
//                              ↓
//                       kartiYazdir()
//                              ↓
//                        Ekrana yazdır
//
// Özet:
// Normal constructor → Özellikleri kendimiz veririz.
// Named constructor → Özel/hazır bir oluşturma şeklidir.
// Factory constructor → Dışarıdaki veriden nesne oluşturur.
// Method → Oluşturduğumuz nesnenin yapabildiği iştir.