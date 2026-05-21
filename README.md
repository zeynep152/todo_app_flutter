<<<<<<< HEAD
# todo_app_flutter
Flutter ve Firebase Firestore ile geliştirilmiş; CRUD operasyonları, kategori bazlı ikon seçimi ve canlı görev durum yönetimi özelliklerine sahip gerçek zamanlı Todo uygulaması.
=======
# 🚀 TaskFlow - Real-Time ToDo Application

TaskFlow, Flutter ve Firebase Firestore kullanılarak geliştirilmiş, gerçek zamanlı (real-time) veri akışına sahip modern bir ajanda ve görev yönetim uygulamasıdır. 

*Bu proje, Mobil Programlama dersi final ödevi teknik gereksinimlerine uygun olarak kurgulanmış ve optimize edilmiştir.*

---

## ✨ Özellikler & Teknik Maddeler

Uygulama, ödev yönergesinde belirtilen tüm isterleri eksiksiz bir şekilde yerine getirmektedir:

* **Gerçek Zamanlı Güncelleme (Real-Time Sync):** `StreamBuilder` mimarisi sayesinde buluttaki Firestore veritabanında meydana gelen her türlü değişiklik (ekleme, durum güncellemesi), arayüzde sayfa yenilemeye gerek kalmadan anlık olarak görüntülenir.
* **Dinamik Bottom Modal Panel:** Yeni görev ekleme ekranı `showModalBottomSheet` ile açılır. Form alanlarının kendi içindeki anlık durum yönetimi ve performans optimizasyonu için `StatefulBuilder` (`setModalState`) kullanılmıştır.
* **10 Farklı Sabit İkon (Kategori Yönetimi):** Ödev isterlerine uygun olarak belirlenen 10 farklı kategori ikonu, kullanıcıya bir `DropdownButton` aracılığıyla sunulur. Firebase veri tabanına ikon nesnesinin kendisi yerine güvenli ve optimize bir şekilde `String key` değeri kaydedilir; veri çağrılırken bu anahtarla eşleştirilerek ekrana basılır.
* **Zaman Bilgisi Entegrasyonu:** Görevler için `showDatePicker` kullanılarak dinamik ve kullanıcı dostu bir tarih seçimi entegre edilmiştir.
* **Checkbox ve Görev Durum Güncellemesi:** Her todo öğesi için bir Checkbox yer almaktadır. 
  * **İşaretlendiğinde (Yapıldı):** Firestore'da ilgili dökümanın `g_durum` alanı anlık olarak güncellenir ve arayüzdeki başlık yazısının üstü çizilir (`TextDecoration.lineThrough`).
  * **İşaret Kaldırıldığında (Yapılmadı):** Veritabanındaki durum güncellenerek başlık yazısı eski orijinal haline (üstü çizilmemiş) geri döner.

---

## 🛠️ Kurulum ve Çalıştırma Talimatı

Bu proje **Public (Herkese Açık)** bir depoda yer aldığı için güvenlik amacıyla `main.dart` içerisindeki şahsi Firebase API anahtarları temizlenmiştir. Projeyi kendi yerel ortamınızda test etmek ve çalıştırmak için aşağıdaki adımları takip etmeniz gerekmektedir:

### 1. Projeyi Klonlayın
```bash
git clone [https://github.com/KULLANICI_ADINIZ/odev_todo.git](https://github.com/KULLANICI_ADINIZ/odev_todo.git)
cd odev_todo
>>>>>>> f2e8b1f (Proje tamamlandı ve tüm dosyalar yüklendi#)
