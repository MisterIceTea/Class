#########################################################
# Written by Yannick Morgenthaler
# Used for M159
# Copyright by Yannick Morgenthaler
#########################################################

$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

#Columns of csv
$colNr = 'Nr.'
$colAnrede = 'Anrede'
$colTitel = 'Titel'
$colVorname = 'Vorname'
$colNachname = 'Nachname'
$colGeburtsdatum = 'Geburtsdatum'
$colStrasse = 'Strasse'
$colHausnummer = 'Hausnummer'
$colPLZ = 'Postleitzahl'
$colStadt = 'Stadt'
$colTelefon = 'Telefon'
$colMobil = 'Mobil'
$colEMail = 'EMail'
$colFirma = 'Firma'
$colBundesland = 'Bundesland'
$colFax = 'Fax'
$colAktiv = 'Aktiv'
$colZusatz1 = 'Zusatz 1'
$colZusatz2 = 'Zusatz 2'
$colZusatz3 = 'Zusatz 3'

#phonenumber formats
$tel_format8 = '"+49" ### #####'
$tel_format9 = '"+49" ### ######'
$tel_format10 = '"+49" ### #######'
$tel_format11 = '"+49" ### ########'
$tel_format12 = '"+49" ### #########'

#date formats
[string[]]$formats = "dd.MM.yyyy", "MM/dd/yyyy", "yyyy-MM-dd"

#replacement characters for non ASCII characters
$replacements = @{
    'ä' = 'ae'
    'á' = 'a'
    'ã' = 'a'
    'å' = 'a'
    'ā' = 'a'
    'ć' = 'c'
    'č' = 'c'
    'ç' = 'c'
    'é' = 'e'
    'ë' = 'e'
    'ğ' = 'g'
    'í' = 'i'
    'î' = 'i'
    'ł' = 'l'
    'ö' = 'oe'
    'ø' = 'o'
    'ß' = 'ss'
    'š' = 's'
    'ş' = 's'
    'ü' = 'ue'
    'ů' = 'u'
    'ž' = 'z'
}

#other values that need to be set
$username = 110001 #zusatz 1
$fehlerhaft = $false #zusatz 2
$fehlercode = "" #zusatz 3
$nonASCII = $false

#function to write a report
function Report([String]$Report) {
    Add-Content './report.txt' "_________________________________________________________________"
    Add-Content './report.txt' $Report
    Add-Content './report.txt' "Error is checked and corrected []"
    Add-Content './report.txt' "_________________________________________________________________"
}


foreach ($line in $csv) {

    #values that need to be reset after every user
    $fehlerhaft = $false
    $fehlercode = ""

    $line.'Zusatz 1' = $username
    $username += 1

    foreach ($column in $line.psobject.Properties) {
        if (($column.Name -eq $colVorname) -or ($column.Name -eq $colNachname) -or ($column.Name -eq $colStrasse) -or ($column.Name -eq $colStadt) -or ($column.Name -eq $colFirma) -or ($column.Name -eq $colBundesland)) {
            $nonASCII = $line.$($column.Name) -cmatch '[^\x20-\x7F]'
            if ($nonASCII -eq $true) {
                try {
                    foreach ($key in $replacements.Keys) {
                        $line.$($column.Name) = $line.$($column.Name) -replace $key, $replacements[$key]
                    }
                }
                catch {
                    $fehlerhaft = $true
                    $fehlercode += "(1E)"
                }
                $nonASCII = $false
            }
            if ($column.Name -eq $colStrasse) {
                try {
                    $line.Strasse = $line.Strasse.Replace("str.", "strasse")
                }
                catch {
                    $fehlerhaft = $true
                    $fehlercode += "(15)"
                }
            }
            if ($column.Name -ne $colBundesland) {
                try {
                    $line.$($column.Name) = $line.$($column.Name).ToLower()
                    $TextInfo = (Get-Culture).TextInfo
                    $line.$($column.Name) = $TextInfo.ToTitleCase($line.$($column.Name))
                }
                catch {
                    $fehlercode += "(00)"
                    Report "An unknown error occured while correcting upper and lower Case on user: $line.$colNr"
                }
            }
            if ($column.Name -eq $colFirma) {
                try {
                    if ($line.$($column.Name) -like "*gmbh &*") {
                        $line.$($column.Name) = $line.$($column.Name).Replace("Gmbh & Co. Kg", "GmbH & Co. KG")
                    }
                    elseif ($line.$($column.Name) -like "*gmbh*") {
                        $line.$($column.Name) = $line.$($column.Name).Replace("Gmbh", "GmbH")
                    }
                    elseif ($line.$($column.Name) -like "*kg") {
                        $line.$($column.Name) = $line.$($column.Name).Replace("Kg", "KG")
                    }
                    elseif ($line.$($column.Name) -like "*kgaa") {
                        $line.$($column.Name) = $line.$($column.Name).Replace("Kgaa", "KGaA")
                    }
                    elseif ($line.$($column.Name) -like "*ag") {
                        $line.$($column.Name) = $line.$($column.Name).Replace("Ag", "AG")
                    }
                    elseif ($line.$($column.Name) -like "*ug") {
                        $line.$($column.Name) = $line.$($column.Name).Replace("Ug", "UG")
                    }
                    elseif ($line.$($column.Name) -like "*ohg") {
                        $line.$($column.Name) = $line.$($column.Name).Replace("Ohg", "OHG")
                    }
                    elseif ($line.$($column.Name) -like "*gbr") {
                        $line.$($column.Name) = $line.$($column.Name).Replace("Gbr", "GbR")
                    }
            
                    if ($line.$($column.Name) -like "* und *") {
                        $line.$($column.Name) = $line.$($column.Name).Replace("Und", "und")
                    }
                }
                catch {
                    $fehlercode += "(1A)"
                    Report "An error occured while correcting the company endings on user: $line.$colNr"
                }
            }
            if ($column.Name -eq $colNachname) {
                try {
                    if ($line.$($column.Name) -like "Dr. Dr.*") {
                        $line.$($column.Name) = $line.$($column.Name).TrimStart("Dr. Dr.")
                        $line.Titel = "Dr. Dr."
                    }
                    elseif ($line.$($column.Name) -like "Dr.*") {
                        $line.$($column.Name) = $line.$($column.Name).TrimStart("Dr.")
                        $line.Titel = "Dr."
                    }
                    elseif ($line.$($column.Name) -like "Prof. Dr. Dr.*") {   
                        $line.$($column.Name) = $line.$($column.Name).TrimStart("Prof. Dr. Dr.")
                        $line.Titel = "Prof. Dr. Dr."
                    }
                    elseif ($line.$($column.Name) -like "Prof. Dr.*") {
                        $line.$($column.Name) = $line.$($column.Name).TrimStart("Prof. Dr.")
                        $line.Titel = "Prof. Dr."
                    }
                    elseif ($line.$($column.Name) -like "Prof.*") {
                        $line.$($column.Name) = $line.$($column.Name).TrimStart("Prof.")
                        $line.Titel = "Prof."
                    }
                }
                catch {
                    $fehlercode += "(12)"
                    Report "An error occured while correcting the title on user: $line.$colNr"
                }
            }
        }
        elseif ($column.Name -eq $colEMail) {
            try {
                $line.$($column.Name) = $line.$($column.Name).ToLower()
            }
            catch {
                $fehlercode += "(00)"
                Report "An unknown error occured while correcting upper and lower Case on user: $line.$colNr"
            }
        }
        elseif ($column.Name -eq $colTitel) {
            if ($line.$($column.Name) -ne "$null") {
                try {
                    $line.$($column.Name) = $line.$($column.Name).ToLower()
                    $TextInfo = (Get-Culture).TextInfo
                    $line.$($column.Name) = $TextInfo.ToTitleCase($line.$($column.Name))
                }
                catch {
                    $fehlercode += "(00)"
                    Report "An unknown error occured while correcting upper and lower Case on user: $line.$colNr"
                }
            }
        }
        elseif ($column.Name -eq $colHausnummer) {
            if ($line.$($column.Name) -eq "$null") {
                try {
                    $strasse, [string]$hausnummer = $line.Strasse -split '(\d+.*$)'
                    $line.Strasse = $strasse.TrimEnd()
                    $line.Hausnummer = $hausnummer.TrimEnd()
                }
                catch {
                    $fehlerhaft = $true
                    $fehlercode += "(15)"
                }
            }
        }
        elseif ($column.Name -eq $colPLZ) {
            if ($line.$($column.Name) -eq "$null") {
                try {
                    [string]$plz, [string]$stadt = $line.Stadt.Split(" ")
                    $line.Postleitzahl = $plz.Trim()
                    $line.Stadt = $stadt.Trim()
                }
                catch {
                    $fehlerhaft = $true
                    $fehlercode += "(16)"
                }
            }
        }
        elseif ($column.Name -eq $colGeburtsdatum) {
            [string[]] $datum = $line.$($column.Name)
            try {
                $date = $datum | ForEach-Object {
                    [datetime]::ParseExact(
                        $_,
                        $formats,
                        [cultureinfo]::InvariantCulture,
                        [System.Globalization.DateTimeStyles]::None
                    )
                }
                $date_format = Get-Date $date -Format "dd.MM.yyyy"
                $line.$($column.Name) = $date_format
            }
            catch{
                try {
                    $unix = Get-Date -UnixTimeSeconds $line.$($column.Name) -Format "dd.MM.yyyy"
                    $line.$($column.Name) = $unix
                }
                catch {
                    $fehlerhaft = $true
                    $fehlercode += "(14)"
                }
            }
        }
        elseif (($column.Name -eq $colTelefon) -or ($column.Name -eq $colMobil) -or ($column.Name -eq $colFax)) {
            try {
                $line.$($column.Name) = $line.$($column.Name).Replace("/", "")
                $line.$($column.Name) = $line.$($column.Name).Replace(" ", "")
                $line.$($column.Name) = $line.$($column.Name).Replace(".", "")
                $line.$($column.Name) = $line.$($column.Name).Replace("-", "")
                $line.$($column.Name) = $line.$($column.Name).Replace("+49", "")
                $line.$($column.Name) = $line.$($column.Name).Replace("(0)", "")
                $line.$($column.Name) = $line.$($column.Name).TrimStart("0")
            }
            catch {
                if ($column.Name -eq $colTelefon) {
                    $fehlercode += "(17)"
                    Report "An error occured while correcting the phonenumber format on user: $line.$colNr"
                }
                elseif ($column.Name -eq $colMobil) {
                    $fehlercode += "(18)"
                    Report "An error occured while correcting the mobile phonenumber format on user: $line.$colNr"
                }
                elseif ($column.Name -eq $colFax) {
                    $fehlercode += "(1B)"
                    Report "An error occured while correcting the fax number format on user: $line.$colNr"
                }
            }
            try {
                if ($line.$($column.Name).Length -eq 8) {
                    $line.$($column.Name) = "{0:$tel_format8}" -f [int64]$line.$($column.Name)
                }
                elseif ($line.$($column.Name).Length -eq 9) {
                    $line.$($column.Name) = "{0:$tel_format9}" -f [int64]$line.$($column.Name)
                }
                elseif ($line.$($column.Name).Length -eq 10) {
                    $line.$($column.Name) = "{0:$tel_format10}" -f [int64]$line.$($column.Name)
                }
                elseif ($line.$($column.Name).Length -eq 11) {
                    $line.$($column.Name) = "{0:$tel_format11}" -f [int64]$line.$($column.Name)
                }
                elseif ($line.$($column.Name).Length -eq 12) {
                    $line.$($column.Name) = "{0:$tel_format12}" -f [int64]$line.$($column.Name)
                }
            }
            catch {
                if ($column.Name -eq $colTelefon) {
                    $fehlercode += "(17)"
                    Report "An error occured while correcting the phonenumber format on user: $line.$colNr"
                }
                elseif ($column.Name -eq $colMobil) {
                    $fehlercode += "(18)"
                    Report "An error occured while correcting the mobile phonenumber format on user: $line.$colNr"
                }
                elseif ($column.Name -eq $colFax) {
                    $fehlercode += "(1B)"
                    Report "An error occured while correcting the fax number format on user: $line.$colNr"
                }
            }
        }
        elseif ($column.Name -eq $colAktiv) {
            $line.$($column.Name) = $line.$($column.Name).ToLower()
            if ($line.$($column.Name) -like "ja") {
                $line.$($column.Name) = $line.$($column.Name).Replace("ja", "$true")
            }
            elseif ($line.$($column.Name) -like "nein") {
                $line.$($column.Name) = $line.$($column.Name).Replace("nein", "$false")
            }
            elseif ($line.$($column.Name) -eq "$null") {
                $fehlerhaft = $true
                $fehlercode += "(1C)"
            }
        }
    }

    $line.'Nr.' = $line.'Nr.'.Trim()
    $line.Anrede = $line.Anrede.Trim()
    $line.Titel = $line.Titel.Trim()
    $line.Vorname = $line.Vorname.Trim()
    $line.Nachname = $line.Nachname.Trim()
    $line.Geburtsdatum = $line.Geburtsdatum.Trim()
    $line.Strasse = $line.Strasse.Trim()
    $line.Hausnummer = $line.Hausnummer.Trim()
    $line.Postleitzahl = $line.Postleitzahl.Trim()
    $line.Stadt = $line.Stadt.Trim()
    $line.Telefon = $line.Telefon.Trim()
    $line.Mobil = $line.Mobil.Trim()
    $line.EMail = $line.EMail.Trim()
    $line.Firma = $line.Firma.Trim()
    $line.Bundesland = $line.Bundesland.Trim()
    $line.Fax = $line.Fax.Trim()

    foreach ($column in $line.psobject.Properties) {
        $nonASCII = $line.$($column.Name) -cmatch '[^\x20-\x7F]'
        if ($nonASCII -eq $true) {
            if ($column.Name -eq $colNr) {
                $fehlerhaft = $true
                $fehlercode += "(01)"
            }
            elseif ($column.Name -eq $colAnrede) {
                $fehlerhaft = $true
                $fehlercode += "(03)"
            }
            elseif ($column.Name -eq $colTitel) {
                $fehlerhaft = $true
                $fehlercode += "(02)"
            }
            elseif ($column.Name -eq $colVorname) {
                $fehlerhaft = $true
                $fehlercode += "(04)"
            }
            elseif ($column.Name -eq $colNachname) {
                $fehlerhaft = $true
                $fehlercode += "(05)"
            }
            elseif ($column.Name -eq $colGeburtsdatum) {
                $fehlerhaft = $true
                $fehlercode += "(06)"
            }
            elseif ($column.Name -eq $colStrasse) {
                $fehlerhaft = $true
                $fehlercode += "(07)"
            }
            elseif ($column.Name -eq $colHausnummer) {
                $fehlerhaft = $true
                $fehlercode += "(08)"
            }
            elseif ($column.Name -eq $colPLZ) {
                $fehlerhaft = $true
                $fehlercode += "(09)"
            }
            elseif ($column.Name -eq $colStadt) {
                $fehlerhaft = $true
                $fehlercode += "(0A)"
            }
            elseif ($column.Name -eq $colTelefon) {
                $fehlerhaft = $true
                $fehlercode += "(0B)"
            }
            elseif ($column.Name -eq $colMobil) {
                $fehlerhaft = $true
                $fehlercode += "(0C)"
            }
            elseif ($column.Name -eq $colEMail) {
                $fehlerhaft = $true
                $fehlercode += "(0D)"
            }
            elseif ($column.Name -eq $colFirma) {
                $fehlerhaft = $true
                $fehlercode += "(0E)"
            }
            elseif ($column.Name -eq $colFax) {
                $fehlerhaft = $true
                $fehlercode += "(0F)"
            }
            elseif ($column.Name -eq $colAktiv) {
                $fehlerhaft = $true
                $fehlercode += "(11)"
            }
        }
        if ($column.Name -eq $colAnrede) {
            if ($line.$($column.Name) -eq "$null") {
                $fehlerhaft = $true
                $fehlercode += "(13)"
            }
        }
        if ($column.Name -eq $colGeburtsdatum) {
            if ($fehlercode -like "*(14)*") {
                $fehlerhaft = $true
            }
            else {
                try {
                    $brithdate = Get-Date $line.$($column.Name)
                }
                catch {
                    $fehlerhaft = $true
                    $fehlercode += "(1F)"
                }
                $currentdate = Get-Date
                $age = $currentdate.Year - $brithdate.Year
                if ($age -gt 65) {
                    $fehlerhaft = $true
                    $fehlercode += "(1D)"
                }
                elseif ($age -lt 15) {
                    $fehlerhaft = $true
                    $fehlercode += "(1D)"
                }
            }
        }
    }

    if ($fehlerhaft -eq $true) {
        $line.'Zusatz 2' = $fehlerhaft
        $line.'Zusatz 3' = $fehlercode
    }
    else {
        if ($fehlercode -ne "$null") {
            $line.'Zusatz 3' = $fehlercode
        }
        $line.'Zusatz 2' = $fehlerhaft
    }
}

$csv | Export-Csv -Path ./test_data.csv -NoTypeInformation