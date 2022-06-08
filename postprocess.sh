# EXtract information from the zipped SNOWPACK output files
(for f in /pl/active/icesheetsclimate/IDS_Antarctica/zip_2022/*; do g=$(basename ${f} .zip); unzip -p -- /pl/active/icesheetsclimate/IDS_Antarctica/zip/${g}_MERRA2.zip "*.smet"; unzip -p -- ${f} "*.smet" | grep ^[0-9]; done) | awk -f process_smetfiles.awk
