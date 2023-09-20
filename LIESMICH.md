
# statistik.sh (1.0.0)

Dieses Bash-Skript analysiert Dateinamen mit der Dateiendung ".eml" aus dem aktuellen Verzeichnis.  Diese Dateinamen wurden beim Export aus einem E-Mail-Programm vergeben und sind aus der Betreffzeile der exportierten E-Mails gebildet worden. 

`statistik.sh` nutzt diese Tatsache, um die im Betreff vorkommenden Wörter zu zählen. Zusätzlich zählt es im Betreff vorkommende E-Mail-Adressen und deren Domains. Seien Analyseergebnisse fasst das Programm in einem Abschlussbericht zusammen.

Hinweis: Das Skript verarbeitet Dateinamen mit der Endung ".eml". Wenn andere Dateiformate verarbeitet werden sollen, muss das Skript angepasst werden.

## Anforderungen

Dieses Programm erfordert bash Version 4 oder höher und die folgenden Befehle: find, mapfile, sed, sort, uniq, grep, rev, date, cat und rm.

### Verwendete externe Programme

| Programmname | Aufgabe in dem Script statistics.sh       | Installation unter Linux|
|:-------------|:------------------------------------------|:------------------------|
| find         | Ermittelt Dateien im aktuellen Verzeichnis| automatisch             |
| sed          | Führt Textmanipulationen durch            | automatisch             |
| uniq         | Filtert doppelte Zeilen heraus            | automatisch             |
| sort         | Sortiert Zeilen                           | automatisch             |
| grep         | Filtert Zeilen anhand von Mustern         | automatisch             |

Die genannten Programme sind normalerweise unter Linux standardmäßig vorhanden.

## Installation

Um dieses Programm zu installieren, kopieren Sie die Datei `statistik.sh` in ein Verzeichnis Ihrer Wahl und machen Sie die Script-Datei mit dem folgenden Befehl ausführbar:

```bash
chmod +x statistik.sh
```

Möchten Sie das Script aus allen Verzeichnissen ausrufen können, dann muss es in einem Verzeichnis gespeichert sein, welches dem Suchpfad angehört. Sie können den Suchpfad durch das Kommando `echo "$PATH"` anzeigen lassen und ihn erweitern, falls nötig oder gewünscht ist, indem Sie die Datei `~/.bashrc` oder die Datei `/etc/bash.bashrc` bearbeiten. Die Datei `~/.bashrc` definiert den Suchpfad für einen Anwender; `/etc/bash.bashrc` definiert ihn systemweit für alle Anwender.

## Verwendung

1. Navigieren Sie in das Verzeichnis, in dem das Skript gespeichert ist.
2. Öffnen Sie ein Terminal und führen Sie den folgenden Befehl aus:

### Wenn das Script im Suchpfad liegt:

```bash
statistik.sh
```
### Wenn das Script im aktuellen Verzeichnis, aber nicht im Suchpfad liegt:


```bash
./statistik.sh
```

Das Skript analysiert alle Dateinamen mit der Dateiendung ".eml" im aktuellen Verzeichnis und schreibt in dieses Verzeichnis als Abschlussbericht eine Textdatei namens `spam_statistik`, welche die Wörter und ihre Häufigkeit sowie die E-Mail-Adressen und E-Mail-Domains aufführt, die in den Betreffzeilen gefunden wurden.

## Autor

Bernd Storck: Ich bin ein zertifizierter Webmaster / Webentwickler und Linux-Aficionado aus Berlin. Meine ersten Programmiererfahrungen hatte ich etwa 1984 mit einem ATARI 800XL.

Kontakt: [Facebook: Linux-Infos von Bernd Storck](https://www.facebook.com/BStLinux/), [www.facebook.com/BStLinux](https://www.facebook.com/BStLinux/)

## Lizenz

Dieses Programm ist freie Software: Sie können es unter den Bedingungen der GNU General Public License wie von der Free Software Foundation veröffentlicht weiterverbreiten und/oder modifizieren, entweder gemäß Version 3 der Lizenz oder (nach Ihrer Option) jeder späteren Version.

Dieses Programm wird in der Hoffnung verteilt, dass es nützlich sein wird, aber OHNE JEDE GEWÄHRLEISTUNG; sogar ohne die implizite Gewährleistung der MARKTFÄHIGKEIT oder EIGNUNG FÜR EINEN BESTIMMTEN ZWECK. Siehe die GNU General Public License für weitere Details.

Die GNU General Public License finden Sie unter <http://www.gnu.org/licenses/>.