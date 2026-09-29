
void main() {
  final List<String> aktifMikroservisler=[
    "auth-service:v2.1",
    "gateway-service:v1.9",
    "payment-processor:v3.0",
  ];

  aktifMikroservisler.add("telemetry-collector:v1.0");
  print("Akrif servisler: (${aktifMikroservisler.length}adet): $aktifMikroservisler");





//sabit uzunluktaki liste (fixed length)
//growable: false → listenin eleman sayısı artırılamaz veya azaltılamaz.

final List<String> cekirdekYukDengeleyiciler = List.filled(4, "Port-Kapalı", growable: false);
cekirdekYukDengeleyiciler[0] = "LB-NODE-01; 192.168.1.10 (Online)";
cekirdekYukDengeleyiciler[1] = "LB-NODE-02; 192.168.1.11 (Online)";
cekirdekYukDengeleyiciler.add("LB-NODE-05"); // HATA: fixed-length listeye eleman eklenemez
print("Çekirdek Yük Dengeleyici Portları:\n$cekirdekYukDengeleyiciler");





//Programatik List Üretici
// List.generate → tekrar eden verileri programatik olarak üretmek için kullanılır.
// List.generate(sayı, (index) => ...) :  "Bana şu kadar eleman üret, her elemanı bu kurala göre oluştur."

final List<String> kubernetsPodlari=List.generate(3, (index)=>"pod-node-eu-west-${index+1} [Ram:16GB, CPU:4 Cores]",);
print("Oluşturulan K8s Podları: $kubernetsPodlari");





//Değiştirilemez List
// List.unmodifiable(...) ne yapıyor? → Listeyi oluşturduktan sonra hiçbir şekilde değiştirilmesine izin vermez.

final List<String> guvenlikDuvariPortlari = List.unmodifiable([
  "22/TCP (SSH)",
  "443/TCP (HTTPS)",
  "6443/TCP (K8s-API)",
]);
//guvenlikDuvariPortlari[0]="80/TCP";//Hata cannot modify an unmodifiable list
print("Güvenlik Duvarı Korumalı Portlar:\n$guvenlikDuvariPortlari");
}


//aklında tut: growable: false → Boyut sabit unmodifiable → Liste tamamen değiştirilemez
