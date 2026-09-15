// Bu kod, siparis sistemindeki SOLID ihlallerini (LSP, SRP, OCP, DIP, ISP) cozmek icin refactor edilmistir.

// Urun modelleri (LSP cozumu)
abstract class Urun {
  final String id;
  final String ad;
  final double fiyat;
  int stok;

  Urun(this.id, this.ad, this.fiyat, this.stok);

  bool get stoktaVarMi => stok > 0;

  void stokDus() {
    if (!stoktaVarMi) {
      throw Exception('$ad tukendi');
    }
    stok--;
  }
}

// Kargolanabilir urun arayuzu
abstract class IKargolanabilir {
  double kargoUcretiHesapla();
}

class FizikselUrun extends Urun implements IKargolanabilir {
  FizikselUrun(String id, String ad, double fiyat, int stok)
      : super(id, ad, fiyat, stok);

  @override
  double kargoUcretiHesapla() => 29.90;
}

// Dijital urun kargo hesaplamaz, hata firlatmaz
class DijitalUrun extends Urun {
  DijitalUrun(String id, String ad, double fiyat, int stok)
      : super(id, ad, fiyat, stok);
}

// Odeme stratejisi (OCP cozumu)
abstract class IOdemeYontemi {
  void ode(double tutar);
}

class KrediKartiOdeme implements IOdemeYontemi {
  @override
  void ode(double tutar) {
    print('$tutar TL Kredi karti ile odendi.');
  }
}

class HavaleOdeme implements IOdemeYontemi {
  @override
  void ode(double tutar) {
    print('$tutar TL Havale ile odendi.');
  }
}

class KapidaOdeme implements IOdemeYontemi {
  @override
  void ode(double tutar) {
    print('${tutar + 15} TL Kapida odeme tahsil edilecek.');
  }
}

class KriptoOdeme implements IOdemeYontemi {
  @override
  void ode(double tutar) {
    print('$tutar TL USDT transferi onaylandi.');
  }
}

// Kupon stratejisi (OCP cozumu)
abstract class IKuponStratejisi {
  String get kod;
  double indirimUygula(double tutar);
}

class YuzdeselKupon implements IKuponStratejisi {
  @override
  final String kod;
  final double yuzde;

  YuzdeselKupon(this.kod, this.yuzde);

  @override
  double indirimUygula(double tutar) => tutar * (1 - (yuzde / 100));
}

class SabitKupon implements IKuponStratejisi {
  @override
  final String kod;
  final double indirim;

  SabitKupon(this.kod, this.indirim);

  @override
  double indirimUygula(double tutar) => tutar - indirim > 0 ? tutar - indirim : 0;
}

class KuponServisi {
  final List<IKuponStratejisi> _kuponlar = [];

  void kuponEkle(IKuponStratejisi kupon) => _kuponlar.add(kupon);

  double hesapla(String? kod, double tutar) {
    if (kod == null) return tutar;
    for (var k in _kuponlar) {
      if (k.kod == kod) return k.indirimUygula(tutar);
    }
    return tutar;
  }
}

// Veritabani servisi (DIP cozumu)
abstract class ISiparisRepository {
  void kaydet(String orderId, double tutar);
}

class SqliteSiparisRepository implements ISiparisRepository {
  @override
  void kaydet(String orderId, double tutar) {
    print('DB kaydedildi: $orderId - $tutar TL');
  }
}

// Bildirim servisi (ISP ve DIP cozumu)
abstract class IBildirimServisi {
  void bildir(String kime, String mesaj);
}

class MailServisi implements IBildirimServisi {
  @override
  void bildir(String kime, String mesaj) {
    print('Mail atildi ($kime): $mesaj');
  }
}

class SmsServisi implements IBildirimServisi {
  @override
  void bildir(String kime, String mesaj) {
    print('SMS atildi ($kime): $mesaj');
  }
}

// Fatura servisi (SRP cozumu)
abstract class IFaturaServisi {
  void faturaYazdir(String orderId);
}

class PdfFaturaServisi implements IFaturaServisi {
  @override
  void faturaYazdir(String orderId) {
    print('Fatura cikarildi: $orderId');
  }
}

// Kargo servisi (SRP cozumu)
abstract class IKargoServisi {
  void kargoGonder(String orderId, String adres);
}

class MngKargoServisi implements IKargoServisi {
  @override
  void kargoGonder(String orderId, String adres) {
    print('MNG Kargo fis basildi: $adres');
  }
}

// Musteri modeli
class Musteri {
  final String ad;
  final String email;
  final String tel;
  final String adres;

  Musteri(this.ad, this.email, this.tel, this.adres);
}

// Siparis Yoneticisi (Dependency Injection)
class SiparisYoneticisi {
  final ISiparisRepository _repository;
  final IFaturaServisi _faturaServisi;
  final IKargoServisi _kargoServisi;
  final List<IBildirimServisi> _bildirimler;
  final KuponServisi _kuponServisi;

  SiparisYoneticisi({
    required ISiparisRepository repository,
    required IFaturaServisi faturaServisi,
    required IKargoServisi kargoServisi,
    required List<IBildirimServisi> bildirimler,
    required KuponServisi kuponServisi,
  })  : _repository = repository,
        _faturaServisi = faturaServisi,
        _kargoServisi = kargoServisi,
        _bildirimler = bildirimler,
        _kuponServisi = kuponServisi;

  void siparisTamamla(
    String orderId,
    List<Urun> sepet,
    IOdemeYontemi odemeYontemi,
    Musteri musteri,
    String? kuponKodu,
  ) {
    double urunToplami = 0;
    double kargoToplami = 0;
    bool kargoVarMi = false;

    // Stok kontrolu ve fiyat hesabi
    for (var urun in sepet) {
      if (!urun.stoktaVarMi) {
        print('Hata: ${urun.ad} tukenmis!');
        return;
      }
      urunToplami += urun.fiyat;
      urun.stokDus();

      if (urun is IKargolanabilir) {
        kargoToplami += urun.kargoUcretiHesapla();
        kargoVarMi = true;
      }
    }

    // Kupon ve KDV
    double indirimliTutar = _kuponServisi.hesapla(kuponKodu, urunToplami);
    double toplam = indirimliTutar + kargoToplami;
    double sonTutar = toplam + (toplam * 0.20);

    // Islemler
    odemeYontemi.ode(sonTutar);
    _repository.kaydet(orderId, sonTutar);
    _faturaServisi.faturaYazdir(orderId);

    for (var b in _bildirimler) {
      b.bildir(musteri.email, 'Siparisiniz alindi: $sonTutar TL');
    }

    if (kargoVarMi) {
      _kargoServisi.kargoGonder(orderId, musteri.adres);
    }
  }
}

void main() {
  var kuponServisi = KuponServisi();
  kuponServisi.kuponEkle(YuzdeselKupon('INDIRIM10', 10));
  kuponServisi.kuponEkle(YuzdeselKupon('YAZ20', 20));
  kuponServisi.kuponEkle(SabitKupon('SEPETTE50', 50));

  var siparisci = SiparisYoneticisi(
    repository: SqliteSiparisRepository(),
    faturaServisi: PdfFaturaServisi(),
    kargoServisi: MngKargoServisi(),
    bildirimler: [MailServisi(), SmsServisi()],
    kuponServisi: kuponServisi,
  );

  var urun1 = FizikselUrun('1', 'Kablosuz Mouse', 450.0, 5);
  var urun2 = DijitalUrun('2', 'Flutter Kursu E-Kitap', 150.0, 100);

  var musteri = Musteri('Selahaddin', 'selahaddin@kodvance.com', '05551112233', 'Kadikoy / Istanbul');

  siparisci.siparisTamamla(
    'SP-9921',
    [urun1, urun2],
    KrediKartiOdeme(),
    musteri,
    'INDIRIM10',
  );
}
