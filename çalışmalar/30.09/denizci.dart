

//YÜZME YETİSİ - MIXIN

// mixin = Bir sınıfa sonradan ekleyebileceğimiz yetenek paketidir.
// Burada "yüzme yeteneği" oluşturuyoruz.
// Bu yeteneği kullanan sınıf, içindeki metotları kullanabilir.

mixin YuzmeYetisi {
  void dalisYap() {
    print("Denizci su altına daldı.");
  }
}


// DENİZCİ SINIFI

// Denizci sınıfına YuzmeYetisi'ni ekliyoruz.
// "with" → Bu sınıfa bu yeteneği ekle anlamına gelir.
// Denizci artık dalisYap() metodunu kullanabilir.

class Denizci with YuzmeYetisi {
  final String ad;

  Denizci({required this.ad});

  void yuzmeyeBasla() {
    print("$ad yüzmeye başladı.");
    dalisYap();
  }
}

// PROGRAMIN BAŞLANGICI

void main() {
  print("=== Denizci Sistemi ===");   // Program başladığında başlık yazdırıyoruz.
  final denizci = Denizci(ad: "Aygen");  // Denizci nesnesi oluşturuyoruz. Denizci sınıfının ad alanına "Aygen" veriyoruz.


  // Denizcinin yüzmeye başlamasını söylüyoruz.
  // Bu metot çalışınca:
  // 1. "Aygen yüzmeye başladı." yazılır.
  // 2. dalisYap() çağrılır.
  // 3. "Denizci su altına daldı." yazılır.

  denizci.yuzmeyeBasla();
  
}


