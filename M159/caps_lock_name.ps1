$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

foreach ($line in $csv) {
    $nachname = $line.Nachname
    $vorname = $line.Vorname

    $lower_surname = $nachname.ToLower()
    $lower_name = $vorname.ToLower()

    $TextInfo = (Get-Culture).TextInfo

    $cultured_name = $TextInfo.ToTitleCase($lower_name)
    $cultured_surname = $TextInfo.ToTitleCase($lower_surname)

    Write-Host "Corrected User:" $line.'Nr.' $cultured_name $cultured_surname
}