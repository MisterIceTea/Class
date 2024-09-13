#import-csv export_Kunden_DE_H.csv -Delimiter ";" | Where-Object Strasse -like "*�*" | ft

$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

$aktiv = 0
$inaktiv = 0
$notset = 0
$user = 0

foreach ($line in $csv) {
    if ($line.Aktiv -like "ja") {
        $aktiv += 1
    }
    elseif ($line.Aktiv -like "nein") {
        $inaktiv += 1
    }
    else {
        $notset += 1
    }
}

Write-Host "Aktiv = $aktiv"
Write-Host "Inaktiv = $inaktiv"
Write-Host "Nicht gesetzt = $notset"
$user = $aktiv + $inaktiv + $notset
Write-Host "User = $user"