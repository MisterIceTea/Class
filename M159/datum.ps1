#import-csv export_Kunden_DE_H.csv -Delimiter ";" | Where-Object Strasse -like "*�*" | ft

$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

foreach ($line in $csv) {
    $datum = $line.Geburtsdatum
    try {
        $date = [DateTime]"$datum"
        $date
    }
    catch {
        Write-Host "Fehler bei User " $line.'Nr.' " bei Datum $datum"
    }
}