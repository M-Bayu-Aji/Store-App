# 🛍️ Shopping App

<div align="center">
  
  ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
  
  **Where Functionality Meets Fashion** ✨
  
  Aplikasi belanja modern yang dibangun dengan Flutter untuk pengalaman berbelanja yang mulus dan menyenangkan.
  
</div>

---

## 📱 Tentang Aplikasi

**Bayyy App Store** adalah aplikasi e-commerce mobile yang dikembangkan menggunakan Flutter. Aplikasi ini menyediakan pengalaman belanja yang intuitif dengan antarmuka yang elegan dan performa yang cepat. Dengan state management menggunakan Provider dan integrasi API yang handal, aplikasi ini memberikan fitur lengkap untuk kebutuhan belanja online Anda.

### ✨ Fitur Utama

- 🏪 **Katalog Produk** - Jelajahi berbagai produk dengan tampilan yang menarik
- 🛒 **Keranjang Belanja** - Kelola produk pilihan Anda dengan mudah
- 💰 **Informasi Detail** - Lihat harga, deskripsi, dan rating produk
- 📦 **Kategori Produk** - Temukan produk berdasarkan kategori
- 🎨 **UI/UX Modern** - Desain gradient yang elegan dengan Google Fonts
- ⚡ **Performa Cepat** - Menggunakan state management Provider untuk pengalaman yang smooth

---

## 🛠️ Teknologi yang Digunakan

| Teknologi | Versi | Kegunaan |
|-----------|-------|----------|
| **Flutter** | SDK ^3.10.0 | Framework utama |
| **Dart** | ^3.10.0 | Bahasa pemrograman |
| **Provider** | ^6.1.2 | State management |
| **HTTP** | ^1.6.0 | Integrasi API |
| **Google Fonts** | ^6.3.3 | Typography |

---

## 📁 Struktur Proyek

```
lib/
├── main.dart                 # Entry point aplikasi
├── models/                   # Data models
│   ├── store.dart           # Model produk toko
│   └── carts.dart           # Model keranjang
├── pages/                    # Halaman aplikasi
│   ├── home_page.dart       # Landing page
│   ├── store.dart           # Halaman produk
│   └── carts.dart           # Halaman keranjang
├── providers/                # State management
│   └── cart_provider.dart   # Provider keranjang
├── services/                 # API services
│   ├── store.dart           # Service produk
│   └── carts.dart           # Service keranjang
└── widgets/                  # Reusable widgets
    ├── card_store.dart      # Card produk
    └── card_cart.dart       # Card keranjang
```

---

## 🚀 Cara Menjalankan Aplikasi

### Prasyarat

Pastikan Anda sudah menginstal:
- Flutter SDK (versi 3.10.0 atau lebih baru)
- Dart SDK (versi 3.10.0 atau lebih baru)
- Android Studio / VS Code dengan Flutter Extension
- Emulator Android / iOS atau perangkat fisik

### Langkah Instalasi

1. **Clone Repository**
   ```bash
   git clone <repository-url>
   cd shooping_app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Jalankan Aplikasi**
   ```bash
   flutter run
   ```

4. **Build APK (Opsional)**
   ```bash
   flutter build apk --release
   ```

---

## 🎯 Arsitektur Aplikasi

Aplikasi ini menggunakan arsitektur yang terstruktur dengan pemisahan concerns yang jelas:

- **Models**: Mendefinisikan struktur data aplikasi
- **Views (Pages)**: Menampilkan UI dan menerima input user
- **Providers**: Mengelola state aplikasi menggunakan Provider pattern
- **Services**: Menghandle komunikasi dengan API eksternal
- **Widgets**: Komponen UI yang reusable

### State Management Flow

```
User Action → Provider → Update State → Rebuild UI
```

---

## 🎨 Highlights Desain

- **Gradient Background**: Kombinasi warna teal yang menenangkan
- **Typography**: Menggunakan Google Fonts (Poppins) untuk tipografi yang modern
- **Material Design 3**: Implementasi design system terbaru dari Google
- **Responsive Layout**: Menyesuaikan dengan berbagai ukuran layar

---

## 📦 Dependency Management

Aplikasi ini menggunakan beberapa package penting:

- **provider**: Untuk state management yang efisien
- **http**: Untuk melakukan HTTP requests ke API
- **google_fonts**: Untuk menggunakan font kustom
- **cupertino_icons**: Icon set untuk iOS style

Untuk menambah dependency baru:
```bash
flutter pub add package_name
```

---

## 🧪 Testing

Untuk menjalankan test:
```bash
flutter test
```

---

## 📝 Catatan Pengembangan

### Future Improvements

- [ ] Implementasi autentikasi pengguna
- [ ] Fitur wishlist produk
- [ ] Integrasi payment gateway
- [ ] Notifikasi push
- [ ] Filter dan pencarian produk
- [ ] Dark mode support
- [ ] Multi-bahasa support

---

## 👨‍💻 Developer

Dikembangkan sebagai Tugas Akhir Mandiri PPLG XII-5

---

## 📄 Lisensi

Project ini dibuat untuk keperluan edukasi.

---

## 🤝 Kontribusi

Kontribusi, issues, dan feature requests sangat diterima!

---

## 📞 Kontak & Support

Jika Anda memiliki pertanyaan atau membutuhkan bantuan, jangan ragu untuk menghubungi.

---

<div align="center">
  
  **Made with ❤️ using Flutter**
  
  ⭐ Star project ini jika Anda merasa terbantu!
  
</div>
