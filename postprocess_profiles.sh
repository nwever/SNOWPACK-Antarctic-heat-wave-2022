# EXtract information from the zipped SNOWPACK output files
(for f in /pl/active/icesheetsclimate/IDS_Antarctica/zip_2022/*; do g=$(basename ${f} .zip); unzip -p -- /pl/active/icesheetsclimate/IDS_Antarctica/zip/${g}_MERRA2.zip "*.pro"; unzip -p -- ${f} "*.pro" | awk '{if(d) {print}; if(/\[DATA\]/) {d=1}}'; done) | awk -F, -f process_profiles.awk
