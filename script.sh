#!/bin/bash

# Tentukan folder utama tujuan untuk menyimpan file ZIP berdasarkan tanggal hari ini
tanggal_waktu=$(date +\%Y-\%m-\%d)
tujuan_utama="/home/yzu/backup/$tanggal_waktu"

# Pastikan folder tujuan utama ada, atau buat jika belum ada
if [ ! -d "$tujuan_utama" ]; then
    mkdir -p "$tujuan_utama"
fi

# Loop untuk setiap folder "views" di dalam struktur direktori /home/profaskes/klinik
find /home/yzu/ -type d -name "view" | while read -r sumber_folder; do
    # Mendapatkan dua nama path terakhir dari path folder sumber
    folder1=$(basename "$(dirname "$sumber_folder")")
    
    # Tentukan nama file ZIP dengan format nama sesuai dengan yang Anda inginkan dan menyimpannya di folder tujuan yang sesuai dengan tanggal hari ini di /E/backup
    jam_waktu=$(date +\%H\%M\%S)
    nama_zip="$tujuan_utama/$folder1\$jam_waktu.zip"
    
    # Buat file ZIP dari folder "views" dan isi folder "views" akan tetap ada di dalamnya saat diekstrak
    (cd "$(dirname "$sumber_folder")" && zip -r "$nama_zip" "$(basename "$sumber_folder")")
done
