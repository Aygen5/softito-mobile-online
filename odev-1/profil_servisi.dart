// Kullanici profil yonetim servisi
class ProfilServisi {
  String kullaniciAdi;
  String durum;

  ProfilServisi({
    required this.kullaniciAdi,
    this.durum = "Aktif",
  });

  void bilgileriGoster() {
    print("Kullanici: $kullaniciAdi");
    print("Durum: $durum");
  }
}

void main() {
  var profil = ProfilServisi(kullaniciAdi: "Aygen");
  profil.bilgileriGoster();
}
