//Bu kez fonksiyonun kendisini bir veri gibi başka bir fonksiyona gönderiyoruz.

//Fonksiyonu başka fonksiyona parametre olarak verebiliyoruz.

//Kodun genel amacı da şu: Bir metrik değeri al → belirlenen kurala göre kontrol et → eşik aşılmışsa uyarı ver, değilse normal de.


//typedef burada fonksiyonun şablonunu/adını oluşturuyor.
//Şunu söylüyor: MetrikUyariKurali adındaki fonksiyon; double alacak ve bool döndürecek.

typedef MetrikUyariKurali = bool Function(double deger);

void metrikDenetle({              //Bir fonksiyon tanımlıyoruz. void: Bu fonksiyon geriye bir değer döndürmüyor.
  required String metrikAdi,
  required double mevcutDeger,
  required MetrikUyariKurali
  kural,                          //Burada fonksiyonun içine başka bir fonksiyon gönderiyoruz.
  required void Function(String mesaj)
  alertTetikleyici,               //bir fonksiyon daha gönderiyoruz
}) {
  //burada gönderdiğimiz fonksiyonu çalıştırıyoruz.
  if (kural(mevcutDeger)) {
    alertTetikleyici(
      //Daha önce gönderdiğimiz alertTetikleyici fonksiyonunu çalıştırıyor.
      "Uyarı: $metrikAdi eşik değerini aştı. Mevcut: $mevcutDeger",
    );
  } else {
    print("$metrikAdi normal sınırlar içinde ($mevcutDeger)");
  }
}




void main() {
  print("Metrik Uyarıları");
  final MetrikUyariKurali yuksekCpu = (deger) => deger >= 85.0;    // Burada yuksekCpu bir fonksiyon. Anlamı: "Bana bir değer ver, 85 veya daha büyükse true döndür."
  final MetrikUyariKurali yuksekRam = (deger) => deger >= 90.0;    //Bu da: "RAM değeri 90 veya üzerindeyse true."

 //Burada biraz önce yazdığımız metrikDenetle() fonksiyonunu çağırıyoruz.
  metrikDenetle(
    metrikAdi: "Cpu",
    mevcutDeger: 92.4,
    kural: yuksekCpu,  //bir fonksiyonu başka bir fonksiyona veriyoruz.
    alertTetikleyici: (msg) => print("Bildirim Gönderildi - $msg"),  //yine bir fonksiyonu parametre olarak veriyoruz.
  );
}

//92.4 -> yuksekCpu kuralına gönder -> 92.4 >= 85.0 -> true -> if çalışır -> alertTetikleyici çalışır -> Bildirim Gönderildi - Uyarı: Cpu eşik değerini aştı. Mevcut: 92.4

//Yani burada öğrendiğimiz şey: Fonksiyonu parametre olarak göndermek.

//Dart'ta fonksiyonları da değişken gibi başka fonksiyonlara gönderebiliriz.
