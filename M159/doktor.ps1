#import-csv export_Kunden_DE_H.csv -Delimiter ";" | Where-Object Strasse -like "*�*" | ft

$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

$titelRichtig = 0
$titelnachname = 0
$titelname = 0
$keindoktor = 0
$user = 0

foreach ($line in $csv) {
    if ($line.Titel -like "Dr.*" -or $line.Titel -like "Prof.*") {
        $titelRichtig += 1
    }
    elseif ($line.Nachname -like "Dr.*" -or $line.Nachname -like "Prof.*") {
        $titelnachname += 1
    }
    elseif ($line.Vorname -like "Dr.*" -or $line.Vorname -like "Prof.*") {
        $titelname += 1
    }
    else {
        $keindoktor += 1
    }
}

Write-Host "Titel richtig = $titelRichtig"
Write-Host "Titel beim Nachname = $titelnachname"
Write-Host "Titel beim Vornamen = $titelname"
Write-Host "Kein Titel = $keindoktor"
$user = $titelRichtig + $titelnachname + $titelname + $keindoktor
Write-Host "User = $user"