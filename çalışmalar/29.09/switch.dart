// enum + switch expression + when konusu

// switch: "Hangisi geldiğine göre karar ver."

// Kodun Amacı : Bir olayın seviyesine bakıp, hangi alarm kanalının kullanılacağına karar vermek.

enum OlaySeviyesi { info, warning, error, critical } //Burada Dart'a 4 tane izin verilen seçenek tanımlıyoruz. Yani artık bir olayın seviyesi sadece bu dört değerden biri olabilir.

String alarmKanaliniBelirle(OlaySeviyesi seviye, int tekarsayisi) {
  return switch (seviye) {
    //Burada Dart diyor ki: seviye değerine bak ve uygun sonucu seç.
    OlaySeviyesi.info => "dev-logs",
    OlaySeviyesi.warning => "dev-warning",
    OlaySeviyesi.error
        when tekarsayisi >=
            5 =>             // Burada iki şart var: seviye= error VE tekrar sayısı >= 5
      "Sms veya Email (mükerrer hata)",
    OlaySeviyesi.error => "Email:dev@site.com",
    OlaySeviyesi.critical => "ACİL DURUM: Kriz odası otomatik node kapanışı",
  };
}



// şimdi burada switch'in sadece "şu değerse bunu yap" şeklinde değil, "şu koşulu sağlıyorsa bunu yap" şeklinde de kullanılabildiğini göstereceğiz.
// yine switch expression kullanıyoruz ama bu sefer enum değil, sayı aralıklarına göre karar veriyoruz.
// Fonksiyonun amacı: HTTP status code'u al → hangi gruba ait olduğunu söyle.

String httpKoduYorumlar(int kod) {                                  // kod olarak bir HTTP kodu alıyor.
  return switch (kod) {                                             // Diyor ki: "Bu kod hangi koşula uyuyor?"
    >= 200 && < 300 => "2xx Başarılı İstek",
    >= 400 && < 500 => "4xx İstemci Hatası (client error)",
    >= 500 && < 600 => "5xx Sunucu Hatası (internal server error)",
    _ => "Tanimsiz Hata Kodu",
  };
}




void main(){          //Fonksiyonları farklı değerlerle çağırıp sonuçlarını ekrana yazdırıyor.
  print("Switch Exporsessions");
  print("Warning Kanalı                  :${alarmKanaliniBelirle(OlaySeviyesi.warning, 1)}");
  print("Tekil Error Kanalı              :${alarmKanaliniBelirle(OlaySeviyesi.error, 2)}");
  print("5 kez Tekrarlanan Error Kanalı  :${alarmKanaliniBelirle(OlaySeviyesi.error, 5)}");
  print("Kritik  Kanalı                  :${alarmKanaliniBelirle(OlaySeviyesi.critical, 1)}");

  print("HTTP 204 :  ${httpKoduYorumlar(204)}");
  print("HTTP 404 :  ${httpKoduYorumlar(404)}");
  print("HTTP 502 :  ${httpKoduYorumlar(502)}");


  //Aynı fonksiyona farklı değerler verirsek switch uygun koşulu bulup farklı sonuç döndürüyor.
}




