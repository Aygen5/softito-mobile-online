// dart record ve api durum kontrolü

//Dart Record = Birden fazla farklı veriyi tek bir değer içinde birlikte taşımamızı sağlayan yapı.

({
  String nodeAdi,
  int statusCode,
  double latencyMs,
  bool baglantiBasarili,
}) //Benim oluşturacağım veri 4 tane isimlendirilmiş değer taşıyacak.
sunucuPingAt({required String hedefIp}) {
  //Bu bir fonksiyon. hedefIp fonksiyona dışarıdan verilecek.
  final double gecikme = 24.8;
  final int kod = 200;

  return (
    //Burada fonksiyon Record döndürüyor.
    nodeAdi: "edge-router-ist-$hedefIp",
    statusCode: kod,
    latencyMs: gecikme,
    baglantiBasarili: kod == 200,

    //Record birden fazla ilişkili değeri tek bir yapı halinde taşıma
    //ping sonucunu oluşturup Record olarak geri döndürdük.
  );
}

  void main() {

    print("Dart Record Kayıtları");
    final probeSonucu = sunucuPingAt(hedefIp: "10.0.1.50");  //Önce Record'u alıyoruz. Fonksiyonu çağırıyoruz ve dönen Record'u probeSonucu içine koyuyoruz.
    print("İp adi             : ${probeSonucu.nodeAdi}");
    print("Http Kodu          : ${probeSonucu.statusCode}");
    print("Gecikme Süresi     : ${probeSonucu.latencyMs} ms");
    print(
      "Ağ Durumu          : ${probeSonucu.baglantiBasarili ? "Stabil" : "Kopuk"}",
    );

    //Tek hamlede Değişkenlere Parçalama;
    // final (:nodeAdi, :statusCode, :latencyMs, :baglantiBasarili) = probeSonucu;   //Record'un içindeki değerleri ayrı ayrı değişkenlere çıkar. Buna Record destructuring / pattern matching diyebilirsin.
    // print("Değişkenler -> $nodeAdi [Kod: $statusCode, Gecikme: ${latencyMs}ms]");
  

  //Burada iki farklı şey yapıldı:  1- Record'un içindeki değerlere tek tek erişmek  2- Record'u tek hamlede değişkenlere parçalamak
  


  // Tek hamlede Değişkenlere Parçalama
  //Destructuring = Bir Record'un içindeki değerleri tek tek değişkenlere çıkarmak.
final (:nodeAdi, :statusCode, :latencyMs, :baglantiBasarili) = probeSonucu;
print("Değişkenler -> $nodeAdi [Kod: $statusCode, Gecikme: ${latencyMs}ms]");

final (String podId, int cpuCores, double ramGb) = ("k8s-pod-77x", 8, 32.0);
print("Pod özeti: $podId | Çekirdek : $cpuCores | Ram : ${ramGb}GB");


}
