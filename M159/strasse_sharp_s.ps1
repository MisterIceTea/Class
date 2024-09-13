$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

$sharp_s = 0
$no_sharp_s = 0
$nothing = 0

foreach ($line in $csv) {
    if ($line.Bundesland -like "*ß*") {
        $sharp_s += 1
    }
    elseif ($line.Bundesland -like "*ss*") {
        $no_sharp_s += 1
    }
    else {
        $nothing +=1
    }
}

Write-Host "Scharfes S = " $sharp_s
Write-Host "Doppel S = " $no_sharp_s
Write-Host "Keines von beidem = " $nothing
$counter = $sharp_s + $no_sharp_s + $nothing
Write-Host "Gesamt = " $counter 