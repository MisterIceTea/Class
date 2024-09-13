# CSV-Datei einlesen
$daten = Import-Csv -Path "C:\Pfad\Zur\Datei.csv"

# Funktion zur Umwandlung von Datum in ein einheitliches Format
function Formatiere-Geburtsdatum {
    param(
        [string]$rohesDatum
    )

    # Versuche, das Datum in verschiedene Formate zu parsen
    $formatiertesDatum = $null
    $erfolgreich = $false

    # Liste von möglichen Formaten
    $formate = @("dd.MM.yyyy", "dd/MM/yyyy", "yyyy-MM-dd")

    foreach ($format in $formate) {
        if ([DateTime]::TryParseExact($rohesDatum, $format, [CultureInfo]::InvariantCulture, [DateTimeStyles]::None, [ref]$formatiertesDatum)) {
            $erfolgreich = $true
            break
        }
    }

    # Wenn die Umwandlung erfolgreich war, gib das formatierte Datum zurück
    if ($erfolgreich) {
        return $formatiertesDatum.ToString("yyyy-MM-dd")
    } else {
        # Andernfalls gib das ursprüngliche Datum zurück
        return $rohesDatum
    }
}

# Iteriere über jede Zeile und formatiere das Geburtsdatum
foreach ($zeile in $daten) {
    $zeile.Geburtsdatum = Formatiere-Geburtsdatum -rohesDatum $zeile.Geburtsdatum
}

# Aktualisierte Daten speichern
$daten | Export-Csv -Path "C:\Pfad\Zur\AktualisiertenDatei.csv" -NoTypeInformation