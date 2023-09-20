#!/bin/bash
#
# statistik.sh
#
# Version 1.0.0
# Datum:  2023-09-20
#
# Beschreibung:
#
# Das Programm liest aus dem aktuellen Verzeichnis alle Dateinamen mit
# der Dateiendung ".eml" ein. Diese Dateinamen wurden beim Export aus
# einem E-Mail-Programm vergeben und sind aus der Betreffzeile der
# exportierten E-Mail gebildet worden.
#
# Dieses Programm nutzt diese Tatsache, die im Betreff vorkommenden
# Woerter zu zaehlen. Im Betreff vorkommende E-Mail-Adressen und deren
# Domains werden gesondert gezaehlt und im Abschlussbericht aufgefuehrt.
#
# Autor:   Bernd Storck
# Kontakt: https://www.facebook.com/BStLinux/
#

readonly FILE_PATTERN="${1:-*.eml}"

# Ein Array aus Dateinamen erstellen:
mapfile -t files < <(find . -maxdepth 1 -type f -name "$FILE_PATTERN")
gisted_subjects=( "${files[@]}" )

# Woerter, die in der Statistik nicht beruecksichtigt werden:
stop_words=("der" "die" "das" "dem" "des" "den" "um" "bei" "mit" "an" "am"
            "in" "im" "zur" "zum" "und" "oder" "haben" "wer" "wie" "was" "wen" "wem"
            "ein" "eine" "einer" "einem" "einen" "nicht" "kann"
           )

# Zeichen, die zur Analyse des Betreffs geloescht werden:
chars_to_delete=( "," "-" "\"" "(" ")" "+" )

to_delete=( "${stop_words[@]}" "${chars_to_delete[@]}" )

last_index="$(( ${#gisted_subjects[@]} -1 ))"

# Wandelt "'eins zwei" um zu "eins_zwei", ebenso "[eins zwei]". Dadurch bleibt
# aus "'Aktion Mensch'" "Aktion Mensch" als ein Begriff erhalten:
for i in $(seq 0 $last_index); do
  item="${gisted_subjects[$i]}"
  item="$( sed -E "s/'([a-zA-Z]+) ([a-zA-Z]+)'/\1_\2/g" <<< "$item" )"
  item="$( sed -E "s/\[([a-zA-Z]+) ([a-zA-Z]+)\]/\1_\2/g" <<< "$item" )"
  gisted_subjects[$i]="$item"
done


# Stopwoerter, ueberfluessige Zeichen und die Dateiendung '.eml' loeschen:
for i in $(seq 0 $last_index); do
  for word in "${to_delete[@]}"; do
    tmp="${gisted_subjects[$i]%.eml}"
    tmp="${tmp// - / }"
    tmp="${tmp//  / }"
    gisted_subjects[$i]="${tmp//$word/}"
  done
done

rm -f words

# Diverse Ersetzungen:
#
#  - Loescht "'" und "." am Anfang oder Ende jeden Wortes.
#  - Tausch den Unterstrich wieder gegen ein Leerzeichen aus.
#
for ((i=0; i<=last_index; i++ )); do
  tmp="${gisted_subjects[$i]}"
  mapfile -d' ' -t  < <(echo -n "$tmp")
  parts=( "${MAPFILE[@]}" )
  len_parts="${#parts[@]}"
  for j in $( seq 0 $(( len_parts -1 )) ); do
    part="${parts[$j]}"
    part="${part%\.}"
    part="${part#\./}"
    part="${part#\'}"
    part="${part%\'}"
    part="${part//_/ }"
    if [ "$part" != '' ]; then
      echo "$part" >> words
    fi
  done
done

# Wortzaehlung generieren:
sed -Ei '/^[0-9]{1,}$/d' words  # Loescht alle Woerter, die nur aus Ziffern bestehen.
# Sortierung, Zaehlung, numerische Sortierung der Zaehlung:
counted_words="$(sort < words | uniq -c | sort -nr -k1)"
printf "\n\n%s\n%s" "Gefundenen Wörter:" "$counted_words"  > counted_words

# Mail-Adressen gesondert auflisten:
pattern='^[a-zA-Z]{1,}[-[:alnum:]\.]*@[[:alnum:]]{1,}[-[:alnum:]\.]*\.[a-z]{2,6}$'
tmp_file="$(date +%s).tmp"  # Generiert einen Dateinamen aus den vergangenen Sekunden seit 1.1.1970.
# Findet die Mail-Adressen.
# 'rev' sorgt dafuer, dass Adressen mit der selben Domain beieinander stehen.
grep -E --color=never "$pattern" words | rev | sort | rev > "$tmp_file"
mail_addresses="$(uniq -c "$tmp_file")"  # Zaehlt gleiche Adressen.
printf "\n\n%s\n%s" "Gefundene Mail-Adressen:" "$mail_addresses" > mail_addresses

# Die haeufigsten Mail-Domains zusammenstellen (haeufiger als zweimal):
mail_domains="$(grep -Eo --color=never '@.*$' "$tmp_file" |\
sed -E 's/^@(.*)/\1/' | uniq -c | sort -nr -k1 | grep -E '^\s*[3-9]')"
printf "%s\n%s" "Gefundene Mail-Domains:" "$mail_domains" > mail_domains


# Abschlussbericht / Daten zusammenfassen:
cat mail_domains mail_addresses counted_words > spam_statistik

# Aufraeumarbeiten:
rm -f "$tmp_file" words mail_domains mail_addresses counted_words

exit 0
