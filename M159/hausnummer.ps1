#import-csv export_Kunden_DE_H.csv -Delimiter ";" | Where-Object Strasse -like "*�*" | ft

$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"


foreach ($line in $csv) {
    if ($line.Hausnummer -eq "$null") {
        $strasse, [string]$hausnummer = $line.Strasse -split '(\d+.*$)'
        $line.Strasse = $strasse.TrimEnd()
        $line.Hausnummer = $hausnummer.TrimEnd()
    }
    if ($line.Postleitzahl -eq "$null") {
        [string]$plz, [string]$stadt = $line.Stadt.Split(" ")
        $line.Postleitzahl = $plz.Trim()
        $line.Stadt = $stadt.Trim()
    }
}

$csv | Export-Csv -Path ./test.csv -NoTypeInformation