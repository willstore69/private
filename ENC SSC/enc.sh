#!/usr/bin/env bash
ssc_path="/root/ssc/ssc"

read -p "Masukin Nama Folder: " folder_name
source_folder="/root/$folder_name"
if [[ ! -d "$source_folder" ]]; then
    echo "Folder $source_folder tidak ditemukan."
    exit 1
fi
dos2unix $source_folder/* &>/dev/null
chmod +x $source_folder/* &>/dev/null

total_files=$(find "$source_folder" -maxdepth 1 -type f | wc -l)
if [[ $total_files -eq 0 ]]; then
    echo "Folder kosong, tidak ada file untuk dienkripsi."
    exit 1
fi

processed=0
spinner_chars=(🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘)
draw_progress_bar() {
    local progress=$1
    local width=40
    local filled=$((progress * width / 100))
    local empty=$((width - filled))
    local spinner_index=$((processed % ${#spinner_chars[@]}))
    local spinner_char=${spinner_chars[$spinner_index]}
    printf "\r[%s%s] %3d%% %s" "$(printf "%0.s#" $(seq 1 $filled))" "$(printf "%0.s-" $(seq 1 $empty))" "$progress" "$spinner_char"
}

for file in "$source_folder"/*; do
    if [[ -f "$file" ]]; then
        $ssc_path -r -u -c -s -i /usr/bin/bash -n /tmp/.XXXXXX -0 "$file" "$file" &>/dev/null
        processed=$((processed + 1))
        percent=$((processed * 100 / total_files))
        draw_progress_bar "$percent"
        sleep 0.1
    fi
done

echo -e "\r[########################################] 100% 🌕"
echo "Selesai mengenkripsi semua file."
