class CanSistemi {
  final String karakterAdi;
  double _canPuani = //başına _ geldiği için Dart'ta bu alan private/gizli kabul edilir.
      100.0;

  //Constructor
  CanSistemi({required this.karakterAdi});

  //Getter'ın görevi: Gizli olan _canPuani değerini dışarıya sadece okutmak.
  double get canPuani {
    return _canPuani;
  }
  //_canPuani = içerideki gerçek veri , canPuani getter = dışarıdan okumak için pencere

  //Getter → değeri DIŞARI OKUTUR
  //Setter → değeri DIŞARIDAN DEĞİŞTİRİR  ->   setter'ın güzel tarafı şu: değişikliğe kurallar koyabiliyoruz.

  // setter ile can değeri değişirken oyun kurallarını denetleyelim
  set canPuani(double yeniCan) {
    if (yeniCan <= 0.0) {
      _canPuani = 0.0;
      print("$karakterAdi canı tükendi ve yere yığıldı");
    } else if (yeniCan > 100.0) {
      _canPuani = 100.0;
      print("Can tamamen dolu(Maksimum 100 HP)");
    } else {
      _canPuani = yeniCan;
    }
  }

  bool get hayattaMi {
    return _canPuani > 0.0;
  }
}

void main() {
  print("Can barı Güvenlik Sistemi");

  final savasciCani = CanSistemi(karakterAdi: "Meltem Demir");   //Burada CanSistemi sınıfından bir nesne oluşturuyoruz.
  print("Başlangıç Canı          : HP ${savasciCani.canPuani}");  //Başlangıç canını okuyoruz. avasciCani.canPuani dediğimiz için getter çalışıyor.
  print("35 Hasar Alındı");
  savasciCani.canPuani = 65.0;    //Setter çalışıyor. Daha önce yazdığımız: set canPuani(double yeniCan) çalışıyor.
  print("Kalan Can               : HP ${savasciCani.canPuani}");  // Kalan canı tekrar okuyoruz. avasciCani.canPuani dediğimiz için getter çalışıyor ve bize 65.0 döndürüyor.

  //canPuani          → GETTER → oku
  //canPuani = 65     → SETTER → değiştir
  //_canPuani         → gerçek, gizli veri
 

  print("200 can veren iksir içildi");
  savasciCani.canPuani = 200.0;
  print("Sabitlenen Can          : HP ${savasciCani.canPuani}");
  print("Ölümcül Darbe Aldı");
  savasciCani.canPuani = -50.0;
  print("Nihani Can               : HP ${savasciCani.canPuani}");
  print(
    "Savaşçı Hayatta mı?          : ${savasciCani.hayattaMi ? 'Evet' : 'Hayır (Öldü)'}",
  );

}





// CAN SİSTEMİ ÖZETİ


// _canPuani → Gizli/private can değeridir.
// Dışarıdan doğrudan değiştirilmesini istemiyoruz.

// Getter:
// canPuani → Gizli can değerini dışarıya okumak için kullanılır.

// print(savasciCani.canPuani);
// → Can değerini okur.

// Setter:
// canPuani = yeniDeğer → Can değerini değiştirmek için kullanılır.
// Ancak yeni değer önce oyun kurallarından geçirilir.

// Setter kuralları:
// yeniCan <= 0
// → Can 0 yapılır.
// → Karakterin canı tükenir.

// yeniCan > 100
// → Can 100'e sabitlenir.
// → Maksimum can 100 HP'dir.

// 0 < yeniCan <= 100
// → Verilen değer kabul edilir.

// Örnek:
// savasciCani.canPuani = 200;
// → 200 kabul edilmez, can 100 olur.

// savasciCani.canPuani = -50;
// → -50 kabul edilmez, can 0 olur.

// savasciCani.canPuani = 65;
// → 65 kabul edilir.

// hayattaMi:
// → Karakterin hayatta olup olmadığını kontrol eder.
// → Can 0'dan büyükse: Hayatta
// → Can 0 ise: Ölü

// Kısaca:
// Getter → Canı OKU
// Setter → Canı DEĞİŞTİR + KURALLARI KONTROL ET
// _canPuani → Gerçek ve gizli can değeri
// hayattaMi → Karakter yaşıyor mu?
