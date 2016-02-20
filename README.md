BSE Downloaders
===============

Adalah sekumpulan skrip yang ditulis dalam bahasa Ruby guna mengotomasi pengunduhan file-file pdf Buku Sekolah Elektronik dari situs <http://bse.kemdikbud.go.id>.

## Kebutuhan Sistem

Sebelum menjalankan skrip ini, pastikan Anda sudah memasang:

  - Ruby & Bundler (ikuti bagian awal dari [tutorial ini](https://gorails.com/setup/ubuntu/15.04))
  - wget (untuk melakukan pengunduhan)

## Persiapan

Install dependensi (nokogiri, supaya skrip bisa menganalisa halaman web) dengan perintah gem install:

    $ gem install nokogiri

atau dengan perintah bundler:

    $ bundle

Supaya file skrip bisa di-eksekusi, pertama berikan izin seperti berikut:

    $ chmod a+x smp.rb

## Penggunaan

Jalankan seperti biasa dan tunggu hingga selesai:

    $ ./smp.rb

**Opsional**: untuk mengatur di mana pdf akan disimpan, edit variabel `folder_simpan` pada skrip yang akan dijalankan (folder default adalah `downloads/<jenjang pendidikan>`).