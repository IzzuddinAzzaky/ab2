#!/bin/bash

# Tentukan folder utama tujuan untuk menyimpan file ZIP berdasarkan tanggal hari ini
tanggal_waktu=$(date +"%Y-%m-%d")
tujuan_utama="${destinationPath}/backup${tanggal_waktu}/"

# Pastikan folder tujuan utama ada, atau buat jika belum ada
if [ ! -d "$tujuan_utama" ]; then
    mkdir -p "$tujuan_utama"
fi

# Loop untuk setiap folder dalam struktur direktori $sourcePath
find "$sourcePath" -type d | while read -r folder; do
    # Periksa apakah folder ini mengandung subfolder "$backupFileName"
    if [ -d "${folder}/${backupFileName}" ]; then
        # Mendapatkan dua nama path terakhir dari path folder sumber
        path_sumber=$(dirname "$folder")
        folder1=$(basename "$folder")
        folder2="$backupFileName"
        
        # Tentukan nama file ZIP dengan format nama sesuai dengan yang Anda inginkan dan menyimpannya di folder tujuan yang sesuai dengan tanggal hari ini di $destinationPath
        jam_waktu=$(date +"%H%M%S")
        nama_zip="${tujuan_utama}/${folder1}_${folder2}_${jam_waktu}.zip"
        
        # Buat file ZIP dari folder sumber dengan opsi -r untuk rekursif
        zip -r "$nama_zip" "${folder}/${backupFileName}" >/dev/null 2>&1
    fi
done

exit 0
