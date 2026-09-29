// Map = key → value ilişkisi.
//Bu örnekte ise servis adı → servis bilgileri şeklinde kullandık.

void main() {
  final Map<String, Map<String, dynamic>> mikroservisRehberi = {
    //dynamic burada: "Value kısmında farklı veri tipleri olabilir."

    //"auth-api" nedir? Bu key (anahtar): "auth-api": { : sonrasındaki kısım ise o key'in value'su (değeri).
    "auth-api": {
      "port": 8081,
      "saglik": "Healthy",
      "restartSayisi": 0,
      "bellekKullanimiMB": 384.5,
      "otonomOlcekleme": true,
    },

    "payment-gateway": {
      "port": 8082,
      "saglik": "Degraded",
      "restartSayisi": 4,
      "bellekKullanimiMB": 1280.0,
      "otonomOlcekleme": false,
    },
  };

  //Yeni servis ekleme (putIfAbsent ile çakışmasız ekleme)
  //Map'e yeni bir servis ekliyoruz, ama bunu mevcut kaydın üzerine yazmadan yapıyoruz.
  //putIfAbsent ne demek? Kelime olarak: "Yoksa koy."
  //Yoksa: → Verilen bilgileri ekler. Zaten varsa: → Hiçbir şey yapmaz, mevcut kaydı değiştirmez.
  mikroservisRehberi.putIfAbsent(
    "reporting-worker",
    () => {
      //Neden () => var?  → "Eklenecek değeri gerektiğinde oluştur." Burada Map'in value'sunu üreten küçük bir fonksiyon veriliyor.
      "port": 9091,
      "saglik": "Healthy",
      "restartSayisi": 1,
      "bellekKullanimiMB": 512.0,
      "otonomOlcekleme": true,
    },
  );
  //putIfAbsent = "Bu key yoksa ekle, varsa elleme."

  // Metrik güncelleme (update)
  if (mikroservisRehberi.containsKey("payment-gateway")) {
    //containsKey() → Key var mı?
    mikroservisRehberi["payment-gateway"]!["restartSayisi"] = //Buradaki !: "Bunun null olmadığından eminim."
        (mikroservisRehberi["payment-gateway"]!["restartSayisi"] as int) + 1; //as int Diyor ki: "Bu değeri int olarak kabul et." Çünkü iç Map'in değer tipi dynamic idi. Yani Dart burada değerin gerçekten int olduğunu bilsin diye

    //Bu kodun Türkçesi: "Eğer payment-gateway varsa, restart sayısını 1 artır."
  }





//Map'in içindeki tüm servisleri dolaşıp rapor yazdırıyoruz.

  print("Güncel Servis Durum Raporu");
  print("________________________________");
  for (var entry in mikroservisRehberi.entries) {    //.entries : Map'in içindeki key + value çiftlerini getirir.
    final String servis = entry.key;   //servis = key'i alır    Örneğin: servis = "payment-gateway"
    final Map<String, dynamic> ozet = entry.value;   //value'yu alıyor
    final String saglik = ozet["saglik"];
    final String durumRozet = saglik == "Healthy" ? "OK" : "Alert";   //ternary operator   koşul ? doğruysa : yanlışsa
    print(
      "$durumRozet ${servis.padRight(18)} | Port: ${ozet['port']} | Ram: ${ozet['bellekKullanimiMB']}MB | Restrat: ${ozet['restartSayisi']}",  //.padRight(18) → yazıyı sağdan boşlukla tamamla/hizala
    );
  }
}


//En kısa haliyle:
// Map oluştur → veri oku → key kontrol et → yoksa ekle → mevcut veriyi güncelle → entries ile hepsini dolaş → raporla.
