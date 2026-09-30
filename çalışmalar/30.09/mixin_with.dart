//Mixin: Bir sınıfa hazır bir yetenek eklemek.
//with = o yeteneği sınıfa eklemek
//Mixin'in mantığı tam olarak burada: Bir sınıfa, ihtiyaç duyduğu farklı yetenekleri with kullanarak eklemek.

mixin UcmaYetisi {
  //Bir sınıfa sonradan ekleyebileceğimiz hazır bir yetenek paketi.
  int ucusIrtifasiMetre =
      100; //Bu değişkeni mixin'i kullanan sınıf da kullanabilecek.

  void gogeyuksel() {
    print(
      "Uçuş Yetisi: Kanatlarını Açtı ve $ucusIrtifasiMetre metreye Yükseldi",
    );
  }
}

mixin GorunmezlikYetisi {
  //→ Görünmezlik yeteneğini hazırlıyoruz.
  void pelerinOrt() {
    //Bu yeteneğin gerçekleştirdiği davranış.
    print("Görünmezlik: Düşmanların gözünden tamamen kayboldu!");
  }
}

mixin AtesGucuYetisi {
  void alevSaldirisi() {
    print("Ateş Gücü: Kılıcını alevlendirdi ve alanı yaktı");
  }
}

class TemelKarakter {
  final String ad;
  TemelKarakter({required this.ad});
}

class EfsaneviEjderBinicisi extends TemelKarakter
    with UcmaYetisi, AtesGucuYetisi {
  final String ejderhaAdi;

  EfsaneviEjderBinicisi({
    required this.ejderhaAdi,
    required super.ad,
  }); //Constructor'dan gelen ad değerini üst sınıfın ad alanına gönder."

  void hucumEt() {
    print("$ad ve ejderhası $ejderhaAdi savaşa atılıyor");
    gogeyuksel();
    alevSaldirisi();
  }
}

class GolgeSuikastci extends TemelKarakter with GorunmezlikYetisi {
  GolgeSuikastci({required super.ad});

  void suikastYap() {
    print("$ad hedefe sessizce yaklaşıyor");
    pelerinOrt();
    print("Kritik Darbe Vurdu");
  }
}

void main() {
  print("Süper Güçler Başlatılıyor");
  final birinci = EfsaneviEjderBinicisi(ejderhaAdi: "Aslıhan", ad: "Gencer");
  birinci.hucumEt();
  final ikinci = GolgeSuikastci(ad: "AdilMurat");
  ikinci.suikastYap();
}





// MIXIN ÖZETİ



// 1. MIXIN NEDİR?
// Mixin, bir sınıfa tekrar kullanılabilir bir YETENEK eklemek için kullanılır.
// Örneğin:
// UcmaYetisi
// GorunmezlikYetisi
// AtesGucuYetisi
// Bunlar birer "yetenek paketi" gibi düşünülebilir.


// 2. MIXIN OLUŞTURMA
// mixin UcmaYetisi {
//   void gogeyuksel() {
//     ...
//   }
//
// }

// "UcmaYetisi" adında bir yetenek oluşturduk.
// Bu yeteneği daha sonra farklı sınıflara verebiliriz.


// 3. WITH

// class EfsaneviEjderBinicisi
//     extends TemelKarakter
//     with UcmaYetisi, AtesGucuYetisi

// "with" kullanarak sınıfa mixin ekliyoruz.
// Yani EfsaneviEjderBinicisi:
// → Uçabilir.
// → Ateş saldırısı yapabilir.
// Aynı sınıfa birden fazla mixin eklenebilir.


// 4. EXTENDS VE WITH FARKI

// extends
// → Bir sınıftan miras almak.
// → Sınıfın temel yapısını belirler.

// with
// → Sınıfa yetenek eklemek.
// → Sınıfın neler yapabildiğini artırır.

// Örnek:

// extends TemelKarakter
// → EfsaneviEjderBinicisi bir TemelKarakter'dir.

// with UcmaYetisi
// → EfsaneviEjderBinicisi uçabilir.

// with AtesGucuYetisi
// → EfsaneviEjderBinicisi ateş saldırısı yapabilir.


// 5. MIXIN'DEN GELEN METOTLAR

// EfsaneviEjderBinicisi sınıfının içinde  gogeyuksel() metodunu yazmadık.
// Çünkü bu metot UcmaYetisi mixin'inden geliyor.

// Aynı şekilde:
// alevSaldirisi() → AtesGucuYetisi'nden geliyor.
// pelerinOrt() → GorunmezlikYetisi'nden geliyor.

// Yani mixin'i kullanan sınıf,  mixin içerisindeki metotları kullanabilir.


// 6. FARKLI SINIFLARA FARKLI YETENEKLER
// EfsaneviEjderBinicisi:
// extends TemelKarakter
// with UcmaYetisi, AtesGucuYetisi

// GolgeSuikastci:
// extends TemelKarakter
// with GorunmezlikYetisi

// Her sınıfa ihtiyacı olan yetenekleri ekledik.
// Her sınıfa bütün yetenekleri vermek zorunda değiliz.


// 7. SINIFIN KENDİ METODU
// EfsaneviEjderBinicisi'nin:
// hucumEt() metodu kendi sınıfına aittir.

// Ama içerisinde mixinlerden gelen:
// gogeyuksel()
// alevSaldirisi() metotlarını kullanabilir.
// Yani bir sınıf kendi davranışında,
// mixin ile kazandığı yetenekleri kullanabilir.


// 8. MAIN() İLE NESNELERİ OLUŞTURMA

// final birinci = EfsaneviEjderBinicisi(
//   ejderhaAdi: "Aslıhan",
//   ad: "Gencer",
// );

// Burada sınıftan gerçek bir nesne oluşturduk.
// Sonra: birinci.hucumEt(); diyerek nesnenin davranışını çalıştırdık.


// 9. İKİNCİ KARAKTER
// final ikinci = GolgeSuikastci(
//   ad: "AdilMurat",
// );
// ikinci.suikastYap();

// Burada da başka bir sınıftan nesne oluşturduk.
// Bu karakterin yeteneği: GorunmezlikYetisi olduğu için suikast sırasında:  pelerinOrt(); metodunu kullanabiliyor.



// PROJENİN BÜYÜK MANTIĞI

//
//                 TemelKarakter
//                      │
//             ┌────────┴────────┐
//             ↓                 ↓
//   EfsaneviEjderBinicisi   GolgeSuikastci
//             │                 │
//       ┌─────┴─────┐           │
//       ↓           ↓            ↓
//   UcmaYetisi  AtesGucuYetisi  GorunmezlikYetisi


// EfsaneviEjderBinicisi
// → Uçar + Ateş saldırısı yapar
//
// GolgeSuikastci
// → Görünmez olur + Suikast yapar



// EN KISA HALİYLE

// class  → Nesnenin temel yapısını oluşturur.

// extends → Bir sınıftan miras alır.

// mixin → Tekrar kullanılabilir bir yetenek oluşturur.

// with → Yetenek mixin'ini sınıfa ekler.


// AKILDA KALACAK CÜMLE:
// extends → "Ben neyim?"
// with    → "Neler yapabiliyorum?"7

// Örnek:
// EfsaneviEjderBinicisi
// → TemelKarakter'dir.
// → Uçabilir.
// → Ateş saldırısı yapabilir.

// GolgeSuikastci
// → TemelKarakter'dir.
// → Görünmez olabilir.



// MIXIN'İN AVANTAJI: Aynı yeteneği farklı sınıflarda tekrar kullanabiliriz.
// Örneğin UcmaYetisi:
// Ejderha → uçabilir
// Kuş     → uçabilir
// Melek   → uçabilir

// Bu sınıfların hepsinde uçma kodunu tekrar yazmak yerine aynı UcmaYetisi mixin'ini kullanabiliriz.
// Böylece kod tekrarını azaltır ve yetenekleri daha kolay tekrar kullanabiliriz.
