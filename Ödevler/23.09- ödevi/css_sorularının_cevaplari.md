# CSS, Flutter ve React Native Soruları ve Cevapları

### 1. Flexbox ile CSS Grid arasındaki mimari fark nedir ve ne zaman hangisi seçilmelidir?
* **Mimari Fark:** 
  * **Flexbox:** Tek boyutlu (1D) bir yerleşim sistemidir; elemanları yalnızca tek bir eksende (ya yatay satır ya da dikey sütun) hizalar ve dağıtır.
  * **CSS Grid:** İki boyutlu (2D) bir yerleşim sistemidir; satırları ve sütunları aynı anda, koordineli olarak yönetir.
* **Ne Zaman Hangisi Seçilmeli?**
  * **Flexbox Seçilmeli:** Navigasyon barları, buton grupları, etiket listeleri, form elemanları gibi içerik odaklı (content-first) ve tek eksenli mikro bileşenlerde.
  * **CSS Grid Seçilmeli:** Dashboard panelleri, ürün listeleme ızgaraları, fotoğraf galerileri ve sayfanın genel iskelet şablonu gibi yapı odaklı (layout-first) iki boyutlu makro yerleşimlerde.

---

### 2. CSS Grid'deki fr (fractional unit) birimi, geleneksel yüzde ( % ) birimine göre neden daha güvenlidir?
* **Güvenlik ve Taşma Önleme:** Yüzde (`%`) birimi, kapsayıcının toplam genişliğini baz alır. Izgaraya `gap` (boşluk), `padding` veya `border` eklendiğinde bu değerler yüzdelik dilime dahil edilmediği için toplam genişlik %100'ü aşar ve tasarımda taşmalar (overflow) meydana gelir.
* **Serbest Alan Dağıtımı:** `fr` (fractional unit) birimi ise boşluklar (`gap`) ve sabit genişlikli elemanlar çıkarıldıktan sonra **kalan kullanılabilir boş alanı (free space)** otomatik olarak paylaştırır. Matematiksel hesaplama karmaşasını ortadan kaldırır ve taşma riskini sıfıra indirir.

---

### 3. Neden "Desktop-First" ( max-width ) yerine "Mobile-First" ( min-width ) mimarisi tercih edilir?
1. **Performans ve Donanım:** Mobil cihazların işlemci ve bellek kaynakları masaüstü bilgisayarlara göre daha kısıtlıdır. Mobile-First yaklaşımında mobil tarayıcı hafif ve yalın CSS kodunu doğrudan çalıştırır; masaüstü özelliklerini sıfırlamak (override etmek) için fazladan CPU/RAM harcamaz.
2. **Kullanıcı ve Trafik Önceliği:** Günümüzde internet trafiğinin %70'inden fazlası mobil cihazlardan gelmektedir.
3. **Temiz ve Sürdürülebilir Kod:** Küçük ekrandan başlayarak ekran büyüdükçe katman eklemek (`min-width`), masaüstü kodunu küçültürken özellikleri iptal etmekten (`max-width` ile `display: none` yazmaktan) çok daha az kod karmaşası üretir.

---

### 4. CSS3'te transition ve animation yazarken neden top, left, width yerine transform ve opacity tercih edilmelidir?
* **Tarayıcı Render Hattı (Critical Rendering Path):** `top`, `left`, `width`, `height` gibi özellikler değiştiğinde tarayıcı **Layout (Reflow)** ve **Paint** aşamalarını baştan çalıştırmak zorunda kalır. Bu işlemler ana işlemciyi (CPU) kilitler ve animasyonlarda takılmalara (jank / frame drop) yol açar.
* **Donanım Hızlandırma (GPU Acceleration):** `transform` (`translate`, `scale`, `rotate`) ve `opacity` özellikleri Layout ve Paint adımlarını atlayarak doğrudan grafik kartı katmanına (**GPU Composite**) gönderilir. Böylece animasyonlar CPU'yu yormadan 60 FPS / 120 FPS akıcılığında kesintisiz çalışır.

---

### 5. CSS Grid'de auto-fit ile minmax() birleşimi nasıl çalışır ve responsive tasarım açısından ne avantaj sağlar?
* **Çalışma Prensibi:** `grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));` ifadesinde:
  * `minmax(250px, 1fr)`: Bir sütunun minimum 250px olabileceğini, alan müsait oldukça 1fr oranında genişleyebileceğini belirtir.
  * `auto-fit`: Satıra sığabilecek maksimum sütun adedini hesaplayıp elemanları satıra otomatik yayar.
* **Responsive Avantajı:** Tek bir satır `@media` sorgusu (breakpoint) yazmaya gerek kalmadan, ekran küçüldüğünde kartların otomatik olarak alt satıra geçmesini, ekran büyüdüğünde ise boş alanları doldurmasını sağlayarak tam akışkan bir uyumluluk sunar.

---

### 6. grid-template-areas özelliğinin sağladığı en büyük kurumsal avantaj nedir?
* **Görsel Okunabilirlik ve Şematik Haritalama:** Kurumsal projelerde karmaşık sayfa iskeletlerini CSS içinde ASCII sanatı gibi kelimelerle görselleştirmeyi sağlar (`"header header" "sidebar main" "footer footer"`).
* **HTML Bağımsız Bakım Kolaylığı:** HTML DOM sırasına dokunmadan, yalnızca CSS'teki alan isimlerinin yerini değiştirerek tüm kurumsal sayfa düzenini yeniden yapılandırma esnekliği sunar. Büyük ekiplerde projeye dahil olan yeni geliştiricilerin sayfa hiyerarşisini dakikalar içinde anlamasını sağlar.

---

### 7. CSS'te clamp() fonksiyonunun 3 parametresi ne anlama gelir?
* **Kalıp:** `clamp(MIN, VAL, MAX)`
  1. **MIN (Minimum Sınır):** Özelliğin düşebileceği en alt değerdir (Örn: `1.8rem`). Ekran ne kadar küçülürse küçülsün değer bu sınırın altına inmez.
  2. **VAL (İdeal / Tercih Edilen Değer):** Genellikle viewport birimleriyle tanımlanan akışkan değerdir (Örn: `4vw`). Ekran boyutu değiştikçe dinamik olarak ölçeklenir.
  3. **MAX (Maksimum Sınır):** Özelliğin ulaşabileceği en üst tavan değerdir (Örn: `3.2rem`). Ekran ne kadar büyürse büyüsün değer bu sınırı aşamaz.

---

### 8. Bir CSS animasyonunun sonsuza kadar kesintisiz çalışması için hangi CSS kuralı kullanılır?
* **Kural:** `animation-iteration-count: infinite;` kuralı kullanılır.
* **Kısayol (Shorthand) Kullanımı:** 
  ```css
  animation: pulseAnim 2s infinite ease-in-out;
  ```

---

### 9. Flutter'da CSS Grid'in ve Flexbox'ın doğrudan karşılığı olan widget'lar nelerdir?
* **CSS Grid Karşılığı:**
  * `GridView` ailesi (özellikle `GridView.count`, `GridView.builder` ve `SliverGridDelegateWithFixedCrossAxisCount` / `SliverGridDelegateWithMaxCrossAxisExtent`).
* **Flexbox Karşılığı:**
  * `Flex`
  * `Row` (yatay eksen — `flex-direction: row`)
  * `Column` (dikey eksen — `flex-direction: column`)
  * `Wrap` (çoklu satıra kayma — `flex-wrap: wrap`)
  * Esneme ve pay alma için `Expanded` ve `Flexible` widget'ları.

---

### 10. React Native'de CSS Grid kullanılabilir mi? Kullanılamıyorsa çok sütunlu ızgara yapısı nasıl oluşturulabilir?
* **CSS Grid Durumu:** React Native çekirdeğinde CSS Grid desteği **bulunmaz**. React Native, Yoga yerleşim motoru üzerinden yalnızca **Flexbox** mimarisini destekler.
* **Izgara Yapısı Nasıl Oluşturulur?**
  1. **`FlatList` (numColumns):** En performanslı ve standart yöntemdir. `FlatList` bileşenine `numColumns={2}` veya `numColumns={3}` verilerek liste doğrudan ızgaraya dönüştürülür.
  2. **Flexbox (`flexWrap: 'wrap'`):** Bir kapsayıcı `View` bileşenine `flexDirection: 'row'` ve `flexWrap: 'wrap'` verilip, içindeki kartlara yüzde bazlı genişlik (örneğin `%48`) tanımlanarak manuel ızgara inşa edilir.
