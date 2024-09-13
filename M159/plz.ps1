#import-csv export_Kunden_DE_H.csv -Delimiter ";" | Where-Object Strasse -like "*�*" | ft

$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

$plzOK = 0
$plzNOTok = 0
$user = 0

foreach ($line in $csv) {
    if ($line.Postleitzahl -eq "$null") {
        $plzNOTok += 1
    }
    else {
        $plzOK += 1
    }
}

Write-Host "Hausnummer vorhanden = $plzOK"
Write-Host "Hausnummer nicht gefunden = $plzNOTok"
$user = $plzOK + $plzNOTok
Write-Host "User = $user"