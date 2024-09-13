$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

$tel_format = "+49 (0) ### #########"

foreach ($line in $csv) {
    $telefon = $line.Telefon
    $clean_tel_1 = $telefon.Replace("/", "")
    $clean_tel_2 = $clean_tel_1.Replace(" ", "")
    $clean_tel_3 = $clean_tel_2.Replace(".", "")
    $clean_tel = $clean_tel_3.Replace("-", "")

    if ($clean_tel -like "+49*") {
        $clean_tel_49 = $clean_tel.TrimStart("+49")
        if ($clean_tel_49 -like "0*") {
            $clean_tel_49_0 = $clean_tel.TrimStart("0")
        }
        elseif ($clean_tel_49 -like "(0)*") {
            $clean_tel_49_0 = $clean_tel.TrimStart("(0)")
        }
        #$formatted_tel = "{0:$tel_format}" -f $clean_tel_49_0
        Write-Host $clean_tel_49_0.Length
        if ($clean_tel_49_0.Length -eq 10) {
            $formatted_tel = "{0:+49 000 0000000}" -f $clean_tel_49_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_49_0.Length -eq 11) {
            $formatted_tel = "{0:+49 000 00000000}" -f $clean_tel_49_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_49_0.Length -eq 12) {
            $formatted_tel = "{0:+49 000 000000000}" -f $clean_tel_49_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_49_0.Length -eq 13) {
            $formatted_tel = "{0:+49 000 0000000000}" -f $clean_tel_49_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_49_0.Length -eq 14) {
            $formatted_tel = "{0:+49 000 00000000000}" -f $clean_tel_49_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_49_0.Length -eq 15) {
            $formatted_tel = "{0:+49 000 000000000000}" -f $clean_tel_49_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_49_0.Length -eq 16) {
            $formatted_tel = "{0:+49 000 0000000000000}" -f $clean_tel_49_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_49_0.Length -eq 17) {
            $formatted_tel = "{0:+49 000 00000000000000}" -f $clean_tel_49_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_49_0.Length -eq 18) {
            $formatted_tel = "{0:+49 000 000000000000000}" -f $clean_tel_49_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        else {
            Write-Host "Something is definitly wrong"
        }
    }
    elseif ($clean_tel -like "0*") {
        $clean_tel_0 = $clean_tel.TrimStart("0")
        #$formatted_tel = "{0:$tel_format}" -f $clean_tel_0
        Write-Host $clean_tel_0.Length
        if ($clean_tel_0.Length -eq 10) {
            $formatted_tel = "{0:+49 000 0000000}" -f $clean_tel_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_0.Length -eq 11) {
            $formatted_tel = "{0:+49 000 00000000}" -f $clean_tel_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_0.Length -eq 12) {
            $formatted_tel = "{0:+49 000 000000000}" -f $clean_tel_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_0.Length -eq 13) {
            $formatted_tel = "{0:+49 000 0000000000}" -f $clean_tel_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_0.Length -eq 14) {
            $formatted_tel = "{0:+49 000 00000000000}" -f $clean_tel_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_0.Length -eq 15) {
            $formatted_tel = "{0:+49 000 000000000000}" -f $clean_tel_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_0.Length -eq 16) {
            $formatted_tel = "{0:+49 000 0000000000000}" -f $clean_tel_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_0.Length -eq 17) {
            $formatted_tel = "{0:+49 000 00000000000000}" -f $clean_tel_0
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        elseif ($clean_tel_0.Length -eq 18) {
            $formatted_tel = "{0:+49 000 000000000000000}" -f $clean_tel_4
            Write-Host "User" $line.'Nr.' "has" $formatted_tel
        }
        else {
            Write-Host "Something is definitly wrong"
        }
    }
    #Write-Host "User" $line.'Nr.' "has" $formatted_tel
}