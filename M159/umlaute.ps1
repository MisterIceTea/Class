$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

$vorname_ae = 0
$vorname_oe = 0
$vorname_ue = 0

$clean = 0

foreach ($line in $csv) {
    if ($line.EMail -like "*ä*") {
        $vorname_ae += 1
    }
    if ($line.EMail -like "*ö*") {
        $vorname_oe += 1
    }
    if ($line.EMail -like "*ü*") {
        $vorname_ue += 1
    }
    else {
        $clean += 1
    }
}

Write-Host "ä" $vorname_ae
Write-Host "ö" $vorname_oe
Write-Host "ü" $vorname_ue
Write-Host "clean" $clean
$counter = $vorname_ae + $vorname_oe + $vorname_ue + $clean
Write-Host "von:" $counter 