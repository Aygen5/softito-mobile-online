// Spread ...  ...? ve collection if ve collection for kullanımı

void main(){
  print("Pipeline Konfigürasyonu");

  final bool productionMu = true;
  final bool debugLoggingAktif = false;
  final List<String>? cloudWatchEklentileri = ["datadog-agent:v7", "prometheus-exporter"];
  final List<String>? geciciTestYamalari = null;



  //Collection If = "Listeyi oluştururken, koşula göre eleman ekle."

  final List<String> aktifPipelineAdimlari = ["git-checkout","security-sast-scan",   //İlk iki eleman her zaman ekleniyor: Koşula bağlı değiller.
   if (productionMu) "production-kms-check",
  if (debugLoggingAktif) "verbose-debug-logger" else "minified-json-logger", 

  //... şu demek: "Bu listenin elemanlarını mevcut listenin içine tek tek koy."

  ...["docker-build", "helm-chart-package"],

  //...? diyor ki: "Liste varsa elemanlarını ekle, null ise hiçbir şey yapma.""

  ...?cloudWatchEklentileri,
  ...?geciciTestYamalari, //Null olduğu için hiç bir işlem yapmaz/ çökmezde

];


//şeyi ayır:
// ...liste → Listenin elemanlarını içeri dağıt.
//...?liste → Liste varsa dağıt, null ise geç.
// if (şart) "eleman" → Şart doğruysa elemanı ekle.




//listenin elemanlarını tek tek dolaşıp yazdırıyoruz. 

for (int i = 0; i < aktifPipelineAdimlari.length; i++) 
{
  print("Adım ${i + 1}: ${aktifPipelineAdimlari[i]}");
}





//Collection For : Bir listenin içindeki elemanları dolaş ve her biri için yeni bir eleman üret.

final List<int> izinliPortlar = [8080, 8443, 9090];
final List<String> firewallGuvenlikKurallari = [
  "INGRESS-DEFAULT-DROP",
  for (var port in izinliPortlar) "ALLOW-TCP_PORT-$port (VPC_INTERNAL)","EGRESS_ALL_ALLOW",
];
print("Dinamik Güvenlik Kuralları (collection for :-)");
firewallGuvenlikKurallari.forEach((kural) => print(" * $kural"));   //Listedeki her kuralı tek tek alıp print ediyor.
}





  


