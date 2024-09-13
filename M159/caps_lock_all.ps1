$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

foreach ($line in $csv) {
    $vorname = $line.Vorname
    $nachname = $line.Nachname
    $strasse = $line.Strasse
    $stadt = $line.Stadt
    $email = $line.EMail
    $firma = $line.Firma

    $lower_name = $vorname.ToLower()
    $lower_surname = $nachname.ToLower()
    $lower_street = $strasse.ToLower()
    $lower_city = $stadt.ToLower()
    $lower_email = $email.ToLower()
    $lower_firma = $firma.ToLower()

    $TextInfo = (Get-Culture).TextInfo

    $cultured_name = $TextInfo.ToTitleCase($lower_name)
    $cultured_surname = $TextInfo.ToTitleCase($lower_surname)
    $cultured_street = $TextInfo.ToTitleCase($lower_street)
    $cultured_city = $TextInfo.ToTitleCase($lower_city)
    $cultured_firma = $TextInfo.ToTitleCase($lower_firma)

    Write-Host "Corrected User:" $line.'Nr.' $cultured_name $cultured_surname
    Write-Host "Corrected Address to User:" $cultured_street $cultured_city
    Write-Host "Corrected E-Mail of User:" $lower_email
    Write-Host "Corrected Company: " $cultured_firma
    Write-Host "________________________________________________________________"
}