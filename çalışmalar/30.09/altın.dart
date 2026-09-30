class Kasa {
  final String oyuncuAdi;

  double _altinMiktari = 0.0;

  Kasa({required this.oyuncuAdi});

  double get altinMiktari {
    return _altinMiktari;
  }

  set altinMiktari(double yeniAltin) {
    if (yeniAltin < 0) {
      print("Sahte altın gelemez!");
    } else if (yeniAltin > 0) {
      _altinMiktari += yeniAltin;
      print("$yeniAltin altın kasaya eklendi.");
    }
  }
}

void main() {
  print("Oyuncu Kasa Sistemi");

  final oyuncuKasasi = Kasa(
    oyuncuAdi: "Aygen Yildirim",
  );

  print(
    "Oyuncu: ${oyuncuKasasi.oyuncuAdi} | "
    "Başlangıç Altını: ${oyuncuKasasi.altinMiktari}",
  );

  print("50 altın kazanıldı.");
  oyuncuKasasi.altinMiktari = 50.0;

  print(
    "Güncel Altın: ${oyuncuKasasi.altinMiktari}",
  );

  print("100 altın daha kazanıldı.");
  oyuncuKasasi.altinMiktari = 100.0;

  print(
    "Güncel Altın: ${oyuncuKasasi.altinMiktari}",
  );

  print(" -20 sahte altın gönderildi.");
  oyuncuKasasi.altinMiktari = -20.0;

  print(
    "Son Altın: ${oyuncuKasasi.altinMiktari}",
  );
}