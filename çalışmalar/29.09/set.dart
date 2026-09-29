
// bu dosyanın ana konusu: "Benzersiz verileri nasıl tutar ve iki veri kümesini nasıl karşılaştırırız?"
// Set'in en önemli özelliği: Aynı elemanı birden fazla kez tutmaz.

void main() {
  final Set<String> istanbulVeriMerkeziIpleri = {
    "10.0.1.10",
    "10.0.1.11",
    "10.0.1.12",
    "10.0.1.13",
    "10.0.1.10", // Çift kayıt Set burayı anında tek hale getirir
  };
  print("İstanbul İpleri: $istanbulVeriMerkeziIpleri");

  final Set<String> frankfurtVeriMerkeziIpleri = {
    "10.0.1.13",
    "10.0.1.30",
    "10.0.1.45",
  };
  print("Frankfur İpleri: $frankfurtVeriMerkeziIpleri");



  //iki Set'in ortak elemanlarını buluyoruz. Buna kesişim (intersection) deniyor.
  //intersection = kesişim = ikisinde de bulunanlar
  //istanbul.intersection(frankfurt) -> "İstanbul ile Frankfurt'un ortak elemanlarını getir."

  final ortakKopruIpler = istanbulVeriMerkeziIpleri.intersection(
    frankfurtVeriMerkeziIpleri,
  );
  print("Ortak Ağ İpleri(kesişim): $ortakKopruIpler");



  //union = birleşim → İstanbul ve Frankfurt'taki tüm benzersiz IP'leri tek bir Set'te toplar.
  //10.0.1.13 iki listede de olmasına rağmen bir kere bulunuyor. Çünkü Set tekrarları tutmaz.

  final tumGlobalIpler = istanbulVeriMerkeziIpleri.union(
    frankfurtVeriMerkeziIpleri,
  );
  print("Toplam Global İpler(birleşim):$tumGlobalIpler");





  //istanbul.difference(frankfurt) → İstanbul'da var, Frankfurt'ta yok.
  //difference() yönlüdür. İlk yazdığın Set'ten, ikinci Set'te bulunanları çıkarır.

  final sadeceIstanbul = istanbulVeriMerkeziIpleri.difference(
    frankfurtVeriMerkeziIpleri,
  );
  print("Sadece İstanbul: $sadeceIstanbul");


}
