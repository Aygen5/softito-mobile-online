
abstract class Canavar {
  void kukre();
}


class Ejderha extends Canavar {
  @override
  void kukre() {
    print("Ejderha: ROAAARRR! Ateş püskürüyor!");
  }
}


class Kurt extends Canavar {
  @override
  void kukre() {
    print("Kurt: Auuuuuu!");
  }
}


class Trol extends Canavar {
  @override
  void kukre() {
    print("Trol: GRAAAARRR!");
  }
}


void canavarlariKukret(List<Canavar> canavarlar) {
  for (var canavar in canavarlar) {
    canavar.kukre();
  }
}

void main() {
  print("=== Canavarlar ===");

  final List<Canavar> canavarlar = [
    Ejderha(),
    Kurt(),
    Trol(),
  ];

  canavarlariKukret(canavarlar);
}






// CANAVAR SİSTEMİ - ABSTRACT CLASS + POLYMORPHISM


// 1. ABSTRACT CLASS
// abstract class Canavar
// Canavar burada temel/üst sınıftır.
// Doğrudan Canavar nesnesi oluşturamayız.
// Ama Canavar'dan başka sınıflar türetebiliriz.
// Canavar
//   ↓
// Ejderha
// Kurt
// Trol


// 2. ABSTRACT (GÖVDESİZ) METOT
// void kukre();
// Bu metodun gövdesi yoktur.
// Yani burada ne yapılacağı belirtilmez.
// Sadece: "Canavar sınıfından türeyen her sınıfta  kukre() metodu olmak zorunda." denmiş olur.
// Her alt sınıf kendi kukreme şeklini belirler.


// 3. EXTENDS
// class Ejderha extends Canavar
// Ejderha, Canavar sınıfından miras alır.
// Aynı şekilde:
// class Kurt extends Canavar
// class Trol extends Canavar
// Böylece bu sınıflar Canavar'ın alt sınıfları olur.


// 4. @OVERRIDE
// @override
// void kukre() { ... }
// Alt sınıf, üst sınıftaki soyut kukre() metodunu
// kendi davranışına göre gerçekleştirir.
// Ejderha → Ateş püskürterek kükreyebilir.
// Kurt    → Uluyabilir.
// Trol    → Farklı bir şekilde kükreyebilir.
// Metodun adı aynı:  kukre()
// Ama davranışları farklı.


// 5. POLYMORPHISM (ÇOK BİÇİMLİLİK)
// List<Canavar> canavarlar = [
//
//     Ejderha(),
//     Kurt(),
//     Trol(),
//
// ];

// Listenin tipi Canavar olmasına rağmen içine Canavar'dan türeyen farklı sınıfları koyabiliyoruz.

// Yani:
// Canavar listesi
//      ↓
// Ejderha
// Kurt
// Trol


// 6. TEK METOT, FARKLI DAVRANIŞ
// for (var canavar in canavarlar) {
//     canavar.kukre();
// }

// Burada tek bir komut kullanıyoruz: canavar.kukre();
// Ama hangi nesne geldiyse onun kukre() metodu çalışıyor.
// Ejderha geldiyse → Ejderha.kukre()
// Kurt geldiyse    → Kurt.kukre()
// Trol geldiyse    → Trol.kukre()
// Buna POLYMORPHISM denir.
// "Aynı komut → farklı nesnelerde farklı davranış"


// 7. NEDEN BUNU YAPIYORUZ?
// Her canavar için ayrı ayrı:
// if (canavar is Ejderha) ...
// if (canavar is Kurt) ...
// if (canavar is Trol) ...
// yazmak zorunda kalmıyoruz.
// Hepsine ortak bir kukre() komutu verebiliyoruz.
// Bu yapı büyüyen projelerde kodu daha düzenli ve yönetilebilir hale getirir.



// SİSTEMİN TAM MANTIĞI

//
//                 Canavar
//                (abstract)
//                    │
//          ┌─────────┼─────────┐
//          ↓         ↓         ↓
//       Ejderha     Kurt      Trol
//          │         │         │
//       kukre()   kukre()   kukre()
//          │         │         │
//        ROAR!     AUUU!     GRAAR!
//
//                    ↓
//
//          List<Canavar>
//
//                    ↓
//
//          canavarlariKukret()
//
//                    ↓
//
//             canavar.kukre()
//
//                    ↓
//
//       Her canavar kendi kukremesini yapar.
//




// KISACA ÖĞRENİLECEKLER

// abstract class → Doğrudan nesnesi oluşturulamayan temel sınıf.

// abstract method
// → Gövdesiz metot.
// → Alt sınıflar uygulamak zorundadır.

// extends → Bir sınıftan miras almak.

// @override  → Miras alınan metodu alt sınıfta yeniden yazmak.

// List<Canavar>  → Farklı alt sınıfları aynı listede tutabilmek.

// Polymorphism  → Aynı metot çağrısının nesneye göre farklı davranması.


// EN ÖNEMLİ CÜMLE:
// "Canavar sınıfı ne yapılacağını söyler, alt sınıflar nasıl yapılacağını belirler."

// Canavar → "Kükre!"
// Ejderha → "Nasıl kükreyeceğim belli: ROAR!"
// Kurt    → "Ben AUUU diyeceğim!"
// Trol    → "Ben GRAAR diyeceğim!"
