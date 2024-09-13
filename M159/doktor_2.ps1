#import-csv export_Kunden_DE_H.csv -Delimiter ";" | Where-Object Strasse -like "*�*" | ft

$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

$doktor1 = 0
$doktor2 = 0
$professor1 = 0
$profdoktor1 = 0
$profdoktor2 = 0
$keindoktor = 0

foreach ($line in $csv) {
    if ($line.Nachname -like "Dr. Dr.*") {
        $doktor2 += 1
    }
    elseif ($line.Nachname -like "Dr.*") {
        $doktor1 += 1
    }
    elseif ($line.Nachname -like "Prof. Dr. Dr.*") {   
        $profdoktor2 += 1
    }
    elseif ($line.Nachname -like "Prof. Dr.*") {
        $profdoktor1 += 1
    }
    elseif ($line.Nachname -like "Prof.*") {
        $professor1 += 1
    }
    #elseif ($line.Titel -like "Dr. Dr.*") {
    #    $doktor2 += 1
    #}
    #elseif ($line.Titel -like "Dr.*") {
    #    $doktor1 += 1
    #}
    #elseif ($line.Titel -like "Prof. Dr. Dr.*") {   
    #    $profdoktor2 += 1
    #}
    #elseif ($line.Titel -like "Prof. Dr.*") {
    #    $profdoktor1 += 1
    #}
    #elseif ($line.Titel -like "Prof.*") {
    #    $professor1 += 1
    #}
    else {
        $keindoktor += 1
    }
}

Write-Host "1 Doktor =" $doktor1
Write-Host "2 Doktor =" $doktor2
Write-Host "Professor =" $professor1
Write-Host "Professor und Doktor =" $profdoktor1
Write-Host "Professor und 2 Doktor =" $profdoktor2
Write-Host "kein Titel =" $keindoktor
$counter = $doktor1 + $doktor2 + $professor1 + $profdoktor1 + $profdoktor2 +$keindoktor
Write-Host "all =" $counter