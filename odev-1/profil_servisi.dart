// Conflict Nedeni: feature/profil-duzenle ve feature/profil-guncelle branchleri ayni satirlarda farkli alanlar ekledigi icin cakisma cikti.
// Cozum: Iki branchteki degisiklikler (hem rol hem unvan) birlestirilerek cakisma giderildi.

class ProfilServisi {
  String kullaniciAdi;
  String durum;
  String rol;
  String unvan;

  ProfilServisi({
    required this.kullaniciAdi,
    this.durum = "Aktif",
    this.rol = "Mobil Gelistirici",
    this.unvan = "Flutter Gelistirici",
  });

  void bilgileriGoster() {
    print("Kullanici: $kullaniciAdi");
    print("Durum: $durum");
    print("Rol: $rol");
    print("Unvan: $unvan");
  }
}

void main() {
  var profil = ProfilServisi(kullaniciAdi: "Aygen");
  profil.bilgileriGoster();
}
