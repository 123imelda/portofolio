# Kia Portfolio

Website portofolio responsif Rizkia Imelda yang dibuat menggunakan Flutter.

## Isi portofolio

- Profil dan riwayat pendidikan.
- Keahlian UI/UX dan pengembangan website.
- Proyek MomsCare dan LoveLens Wedding.
- Tautan prototype Figma, email, dan WhatsApp.

## Menjalankan aplikasi di komputer

Pastikan Flutter SDK sudah terpasang. Jalankan perintah berikut dari folder proyek yang berisi `pubspec.yaml`:

```bash
flutter pub get
flutter run -d chrome
```

Gambar profil dan gambar proyek lokal disimpan di folder `assets/images/`.

## Menerbitkan website melalui Git dan GitHub Pages

Project ini sudah dilengkapi workflow GitHub Actions di `.github/workflows/deploy.yml`. Setelah source project dikirim ke repository GitHub, workflow akan membuat build Flutter Web dan menerbitkannya ke GitHub Pages setiap ada push ke branch `main`.

1. Buat repository baru di GitHub bernama `kia_portfolio`. Jika project ini akan dikirim dari folder lokal, buat repository kosong (jangan menambahkan README atau file awal lain di GitHub).
2. Buka terminal di folder project yang berisi `pubspec.yaml`, lalu jalankan:

   ```bash
   git init
   git add .
   git commit -m "Initial commit Kia Portfolio"
   git branch -M main
   git remote add origin https://github.com/USERNAME/kia_portfolio.git
   git push -u origin main
   ```

   Ganti `USERNAME` dengan username GitHub kamu. Jika Git meminta identitas untuk commit, atur `git config --global user.name` dan `git config --global user.email` memakai nama serta email GitHub kamu.

3. Di repository GitHub, buka **Settings → Pages**.
4. Pada bagian **Build and deployment**, pilih **GitHub Actions** sebagai sumber deploy.
5. Buka tab **Actions** dan tunggu workflow **Build and deploy Flutter Web to GitHub Pages** selesai dengan status berhasil.
6. Untuk repository bernama `kia_portfolio`, alamat website biasanya `https://USERNAME.github.io/kia_portfolio/`.

Workflow mengatur `base-href` berdasarkan nama repository supaya file Flutter Web dapat dimuat dari alamat GitHub Pages. Repository publik diperlukan untuk GitHub Pages pada akun GitHub Free. Website yang berhasil dipublikasikan dapat diakses publik; jangan commit password, token, atau data rahasia.

Untuk pembaruan berikutnya, simpan perubahan, lalu jalankan:

```bash
git add .
git commit -m "Update portfolio"
git push
```

GitHub Actions akan membangun dan menerbitkan versi terbaru secara otomatis.
