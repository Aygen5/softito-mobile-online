// Kullanici profil yonetim servisi
class ProfilServisi {
  String kullaniciAdi;
  String durum;
  String rol; // feature/profil-duzenle tarafindan eklendi

  ProfilServisi({
    required this.kullaniciAdi,
    this.durum = "Aktif",
    this.rol = "Mobil Gelistirici",
  });

  void bilgileriGoster() {
    print("Kullanici: $kullaniciAdi");
    print("Durum: $durum");
    print("Rol: $rol");
  }
}

void main() {
  var profil = ProfilServisi(kullaniciAdi: "Aygen");
  profil.bilgileriGoster();
}
