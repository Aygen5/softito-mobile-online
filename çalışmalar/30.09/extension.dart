// extension: Var olan bir sınıfa, o sınıfın kodunu değiştirmeden yeni özellik/metot eklemek.

extension oyunSayiUzantisi on int {
  //int değerlerine özellik ekledik.
  String get toXpFormat {
    if (this < 1000) return "${this} XP"; //Extension'ı kullanan o anki değeri this temsil ediyor.
    return "${(this / 1000).toStringAsFixed(1)}K Xp";
  }
}

extension MetinSansurUzantisi on String {
  //Bu extension'ı String'ler üzerinde kullanacağım.
  String get temizOyuncuAdi {
    if (this.toLowerCase().contains("hile")) { //this-> extension'ın üzerinde çalıştığı mevcut String'i temsil ediyor.
      return "[YASAKLI_OYUNCU]";
    }
    return "$this";
  }
}

void main() {
  print("Extension metotları(tip genişletmeleri)");
  // int test ediyoruz
  final int kazanilanXp1 = 450;
  final int kazanilanXp2 = 12850;

  print("Görev 1 Ödülü      :  ${kazanilanXp1.toXpFormat}");
  print("Boss Savaşı.        :  ${kazanilanXp2.toXpFormat}");

  final String oyuncu1 = "EjderKatili";
  final String oyuncu2 = "HileciAlaaddin";

  print("Kayıt 1 ${oyuncu1.temizOyuncuAdi}");
  print("Kayıt 2 ${oyuncu2.temizOyuncuAdi}");
}



// EXTENSION (TIP GENİŞLETME) ÖZETİ



// 1. EXTENSION NEDİR?
// Extension, var olan bir tipe sonradan yeni özellik/metot eklememizi sağlar.

// Var olan sınıfın/tipin kodunu değiştirmeyiz.
// Kendi extension'ımızı oluştururuz.

// Örnek:
// int → toXpFormat
// String → temizOyuncuAdi


// 2. EXTENSION OLUŞTURMA
// extension oyunSayiUzantisi on int {
//   String get toXpFormat {
//     ...
//   }
//
// }

// "on int" → Bu extension'ın int değerlerinde kullanılacağını belirtir.
// Örneğin: 450.toXpFormat


// 3. STRING İÇİN EXTENSION
// extension MetinSansurUzantisi on String {

//   String get temizOyuncuAdi {
//     ...
//   }
//
// }

// "on String" → Bu extension'ın String değerlerinde
// kullanılacağını belirtir.

// Örneğin: "EjderKatili".temizOyuncuAdi


// 4. GETTER İLE EXTENSION

// String get toXpFormat
// String get temizOyuncuAdi
// Bunlar getter olduğu için parantez kullanılmaz.

// Doğru:
// 450.toXpFormat

// Yanlış:
// 450.toXpFormat()


// 5. THIS NEDİR?
// Extension'ın üzerinde çalıştığı mevcut değeri temsil eder.

// Örneğin: 450.toXpFormat
// burada: this = 450

// Başka örnek: "HileciAlaaddin".temizOyuncuAdi
// burada: this = "HileciAlaaddin"


// 6. XP EXTENSION'I
// int değerlerine toXpFormat özelliği ekledik.
// 1000'den küçükse:
// 450
// ↓
// 450 XP

// 1000 veya daha büyükse:
// 12850
// ↓
// 12850 / 1000
// ↓
// 12.9K Xp

// toStringAsFixed(1) → Ondalık kısmı 1 basamak olacak şekilde formatlar.


// 7. OYUNCU ADI EXTENSION'I
// String değerlerine temizOyuncuAdi özelliği ekledik.
// Önce: this.toLowerCase()

// → Metni küçük harflere çevirir.

// Sonra:  .contains("hile")
// → Metnin içinde "hile" geçiyor mu kontrol eder.

// Eğer geçiyorsa:
// [YASAKLI_OYUNCU]  döndürülür.
// Geçmiyorsa:
// Orijinal oyuncu adı döndürülür.


// 8. MAIN() İÇİNDE KULLANIM
// final int kazanilanXp1 = 450;
// print(kazanilanXp1.toXpFormat);
// Burada int'in kendi özelliğiymiş gibi
// bizim extension'ımızı kullanıyoruz.
// Aynı şekilde:
// final String oyuncu1 = "EjderKatili";
// print(oyuncu1.temizOyuncuAdi);
// Burada String'in kendi özelliğiymiş gibi bizim extension'ımızı kullanıyoruz.



// GENEL MANTIK

//
//             VAR OLAN TİP
//                  │
//          ┌───────┴───────┐
//          ↓               ↓
//         int            String
//          │               │
//          ↓               ↓
//    toXpFormat      temizOyuncuAdi
//          │               │
//          ↓               ↓
//     XP formatı      Oyuncu adı kontrolü
//
// ============================================================


// KISACA:

// extension → Var olan tipe yeni özellik ekler.

// on int → Extension int üzerinde çalışır.

// on String → Extension String üzerinde çalışır.

// this → Extension'ın üzerinde çalıştığı mevcut değerdir.

// get → Getter oluşturur, kullanırken () yazılmaz.

// EN ÖNEMLİ CÜMLE: "Extension, var olan bir tipi değiştirmeden ona kendi yazdığımız yeni özellikleri eklememizi sağlar."

