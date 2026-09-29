void main() {
  final Set<String> bulutServisleri = {
    "auth-service",
    "payment-service",
    "gateway-service",
    "auth-service", 
    "monitoring-service",
  };

  final bool isProduction = true;

  final List<String> aktifServisler = [
    ...bulutServisleri,
    if (isProduction) "vault-secret-manager",
  ];

  print("Aktif Servisler:");
  print(aktifServisler);
}


//Set + Collection If + List yapılarını kullandık.

//1. Önce Set oluşturduk: Burada "auth-service" iki kere yazıldı ama Set olduğu için sadece bir kez tutulur.

//2. Production bilgisini tuttuk: Şu anda ortamımız production.

// 3. Yeni bir List oluşturduk: 
//...bulutServisleri → Set'in içindeki tüm elemanları listeye aktarır.
//→ isProduction == true ise bu servisi listeye ekler.

//Sonuç
//isProduction = true olduğu için çıktı yaklaşık şöyle olur:
//Aktif Servisler:
//[auth-service, payment-service, gateway-service, monitoring-service, vault-secret-manager]


//buradaki mantık şu:
//Set → mükerrerleri temizle → Collection Spread ile List'e aktar → Collection If ile production servisini koşullu ekle.