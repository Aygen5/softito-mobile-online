// Kullanici profil yonetim servisi
class ProfilServisi {
  String kullaniciAdi;
  String durum;
  String unvan; // feature/profil-guncelle tarafindan eklendi

  ProfilServisi({
    required this.kullaniciAdi,
    this.durum = "Aktif",
    this.unvan = "Flutter Gelistirici",
  });

  void bilgileriGoster() {
    print("Kullanici: $kullaniciAdi");
    print("Durum: $durum");
    print("Unvan: $unvan");
  }
}

void main() {
  var profil = ProfilServisi(kullaniciAdi: "Aygen");
  profil.bilgileriGoster();
}
