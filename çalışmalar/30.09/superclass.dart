// Üst sınıf
//Bu sınıf bizim ortak temelimiz.
//Her savaşçının: ad, temelGuc, saldir() özelliği olduğunu söylüyor.
class TemelSavasci {
  final String ad;
  final double temelGuc;

  TemelSavasci({required this.ad, required this.temelGuc});

  void saldir() {
    print("[$ad] Temel Fiziksel Yumruk attı. Hasar: $temelGuc");
  }
}

class Buyucu extends TemelSavasci {    //extends → Kalıtım  extends kelimesinin burada anlamı:Buyucu, TemelSavasci'den miras alıyor.
  int manaPuani;

  Buyucu({required this.manaPuani, required super.ad, required super.temelGuc});

  @override     //Ben saldir() metodunu kendi tarzımda yapmak istiyorum.
  void saldir() {
    if (manaPuani >= 10) {
      manaPuani -= 10;
      print(
        "[$ad] Alev Topu Fırlattı: Hasar: ${temelGuc * 2} Kalan Mana:$manaPuani",
      );
    } else {
      print("Mana Tükendi");
      super.saldir();    //super.saldir(): Üst sınıftaki saldir() metodunu çalıştır.
    }
  }
}

class Okcu extends TemelSavasci {    //Okçu da TemelSavasci'den miras alıyor.
  int okSayisi;

  Okcu({required this.okSayisi, required super.ad, required super.temelGuc});

  @override
  void saldir() {
    if (okSayisi > 0) {
      okSayisi--;
      print(
        "[$ad] Hedefe zehirli ok fırlattı: Hasar : ${temelGuc * 1.5} Kalan Ok Sayısı: $okSayisi",
      );
    } else {
      print("Ok Bitti");
      super.saldir();
    }
  }
}

void main() {
  print("Savaş Arenası");
  final asker = TemelSavasci(ad: "Ayberk", temelGuc: 20.0);
  // Yumruk atar
  asker.saldir();
  print("----------------------------------");
  final merlin = Buyucu(manaPuani: 20, ad: "Sümeyye Arab", temelGuc: 40.0);
  merlin.saldir();
  print("----------------------------------");
  final legolas = Okcu(okSayisi: 5, ad: "Zelal", temelGuc: 35.0);
  legolas.saldir();
}





// KALITIM (INHERITANCE) - EN ÖNEMLİ 4 KAVRAM


// 1. extends
// Bir sınıfın başka bir sınıftan miras almasını sağlar.
// class Buyucu extends TemelSavasci
// Buyucu, TemelSavasci'nin özelliklerini ve metotlarını miras alır.

// 2. super
// Alt sınıftan üst sınıfa erişmek için kullanılır.
// super.ad
// super.temelGuc
// Bu özelliklerin üst sınıf olan TemelSavasci'ye ait olduğunu gösterir.

// 3. @override
// Üst sınıftan miras alınan bir metodu alt sınıfta
// kendi davranışımızla yeniden yazmamızı sağlar.
// @override
// void saldir() { ... }
// TemelSavasci yumruk atarken,
// Buyucu alev topu atabilir,
// Okcu ise ok fırlatabilir.

// 4. super.saldir()
// Alt sınıfta değiştirdiğimiz metodun içinde,
// üst sınıftaki orijinal metodu çağırır.
// Örneğin Büyücünün manası bittiyse:
// super.saldir();
// → TemelSavasci'nin saldir() metodu çalışır.
// → Büyücü normal fiziksel yumruk atar.



// GENEL SİSTEM

//
//                    TemelSavasci
//                   /             \
//                  ↓               ↓
//               Buyucu           Okcu
//                  │               │
//             manaPuani         okSayisi
//                  │               │
//           saldırıyı değiştir  saldırıyı değiştir
//                  │               │
//              Alev Topu       Zehirli Ok
//                  │               │
//              Mana yoksa       Ok yoksa
//                  ↓               ↓
//           super.saldir()   super.saldir()
//                  ↓               ↓
//                Yumruk          Yumruk
//


// Kısaca:

// extends → Miras al
// super → Üst sınıfa eriş
// @override → Miras alınan metodu yeniden yaz
// super.saldir() → Üst sınıftaki orijinal metodu çalıştır
