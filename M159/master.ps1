$csv = Import-Csv './export_Kunden_DE_L.csv' -Delimiter ";"

$tel_format8 = '"+49" ### #####'
$tel_format9 = '"+49" ### ######'
$tel_format10 = '"+49" ### #######'
$tel_format11 = '"+49" ### ########'
$tel_format12 = '"+49" ### #########'

[string[]]$formats = "dd.MM.yyyy", "MM/dd/yyyy", "yyyy-MM-dd"

$username = 110001 #zusatz 1
$fehlerhaft = $false #zusatz 2
$fehlercode = "" #zusatz 3


foreach ($line in $csv) {

    $fehlerhaft = $false
    $fehlercode = ""

    $line.'Zusatz 1' = $username
    $username += 1

    #################################
    # Split Street/Nr. and ZIP/City # OK
    # & replace str. to strasse     #
    #################################

    if ($line.Hausnummer -eq "$null") {
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
    if ($line.Strasse -like "*str.") {
        try {
            $line.Strasse = $line.Strasse.Replace("str.", "strasse")
        }
        catch {
            $fehlerhaft = $true
            $fehlercode += "(15)"
        }
    }
    if ($line.Postleitzahl -eq "$null") {
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

    #################################
    # Correct upper and lowercase   # OK
    #################################

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

    $line.Vorname = $cultured_name
    $line.Nachname = $cultured_surname
    $line.Strasse = $cultured_street
    $line.Stadt = $cultured_city
    $line.EMail = $lower_email
    $line.Firma = $cultured_firma

    #################################
    # Replace sharp german S        # OK
    #################################

    try {
        $line.Vorname = $line.Vorname.Replace("ß", "ss")
        $line.Nachname = $line.Nachname.Replace("ß", "ss")
        $line.Strasse = $line.Strasse.Replace("ß", "ss")
        $line.Stadt = $line.Stadt.Replace("ß", "ss")
        $line.Firma = $line.Firma.Replace("ß", "ss")
    }
    catch {
        $fehlerhaft = $true
        $fehlercode += "(00)"
    }

    #################################
    # Replace umlaute (ä,ö,ü)       # OK
    #################################

    try {
        $line.Vorname = $line.Vorname.Replace("ä", "ae")
        $line.Vorname = $line.Vorname.Replace("ö", "oe")
        $line.Vorname = $line.Vorname.Replace("ü", "ue")
        $line.Vorname = $line.Vorname.Replace("Ä", "Ae")
        $line.Vorname = $line.Vorname.Replace("Ö", "Oe")
        $line.Vorname = $line.Vorname.Replace("Ü", "Ue")
        $line.Nachname = $line.Nachname.Replace("ä", "ae")
        $line.Nachname = $line.Nachname.Replace("ö", "oe")
        $line.Nachname = $line.Nachname.Replace("ü", "ue")
        $line.Nachname = $line.Nachname.Replace("Ä", "Ae")
        $line.Nachname = $line.Nachname.Replace("Ö", "Oe")
        $line.Nachname = $line.Nachname.Replace("Ü", "Ue")
        $line.Strasse = $line.Strasse.Replace("ä", "ae")
        $line.Strasse = $line.Strasse.Replace("ö", "oe")
        $line.Strasse = $line.Strasse.Replace("ü", "ue")
        $line.Strasse = $line.Strasse.Replace("Ä", "Ae")
        $line.Strasse = $line.Strasse.Replace("Ö", "Oe")
        $line.Strasse = $line.Strasse.Replace("Ü", "Ue")
        $line.Stadt = $line.Stadt.Replace("ä", "ae")
        $line.Stadt = $line.Stadt.Replace("ö", "oe")
        $line.Stadt = $line.Stadt.Replace("ü", "ue")
        $line.Stadt = $line.Stadt.Replace("Ä", "Ae")
        $line.Stadt = $line.Stadt.Replace("Ö", "Oe")
        $line.Stadt = $line.Stadt.Replace("Ü", "Ue")
        $line.Firma = $line.Firma.Replace("ä", "ae")
        $line.Firma = $line.Firma.Replace("ö", "oe")
        $line.Firma = $line.Firma.Replace("ü", "ue")
        $line.Firma = $line.Firma.Replace("Ä", "Ae")
        $line.Firma = $line.Firma.Replace("Ö", "Oe")
        $line.Firma = $line.Firma.Replace("Ü", "Ue")
    }
    catch {
        $fehlerhaft = $true
        $fehlercode += "(00)"
    }

    #################################
    # Check EMail for ä,ö,ü,ß       #
    #################################

    if ($line.EMail -like "*ä*") {
        $fehlerhaft = $true
        $fehlercode += "(19)"
    }
    if ($line.EMail -like "*ö*") {
        $fehlerhaft = $true
        $fehlercode += "(19)"
    }
    if ($line.EMail -like "*ü*") {
        $fehlerhaft = $true
        $fehlercode += "(19)"
    }

    #################################
    # Correct name of company       # OK
    #################################

    try {
        if ($line.Firma -like "*gmbh &*") {
            $line.Firma = $line.Firma.Replace("Gmbh & Co. Kg", "GmbH & Co. KG")
        }
        elseif ($line.Firma -like "*gmbh*") {
            $line.Firma = $line.Firma.Replace("Gmbh", "GmbH")
        }
        elseif ($line.Firma -like "*kg") {
            $line.Firma = $line.Firma.Replace("Kg", "KG")
        }
        elseif ($line.Firma -like "*kgaa") {
            $line.Firma = $line.Firma.Replace("Kgaa", "KGaA")
        }
        elseif ($line.Firma -like "*ag") {
            $line.Firma = $line.Firma.Replace("Ag", "AG")
        }
        elseif ($line.Firma -like "*ug") {
            $line.Firma = $line.Firma.Replace("Ug", "UG")
        }
        elseif ($line.Firma -like "*ohg") {
            $line.Firma = $line.Firma.Replace("Ohg", "OHG")
        }
        elseif ($line.Firma -like "*gbr") {
            $line.Firma = $line.Firma.Replace("Gbr", "GbR")
        }

        if ($line.Firma -like "* und *") {
            $line.Firma = $line.Firma.Replace("Und", "und")
        }
    }
    catch {
        $fehlerhaft = $true
        $fehlercode += "(1A)"
    }

    #################################
    # Correct Dr. Title             # OK
    #################################

    try {
        if ($line.Nachname -like "Dr. Dr.*") {
            $line.Nachname = $line.Nachname.TrimStart("Dr. Dr.")
            $line.Titel = "Dr. Dr."
        }
        elseif ($line.Nachname -like "Dr.*") {
            $line.Nachname = $line.Nachname.TrimStart("Dr.")
            $line.Titel = "Dr."
        }
        elseif ($line.Nachname -like "Prof. Dr. Dr.*") {   
            $line.Nachname = $line.Nachname.TrimStart("Prof. Dr. Dr.")
            $line.Titel = "Prof. Dr. Dr."
        }
        elseif ($line.Nachname -like "Prof. Dr.*") {
            $line.Nachname = $line.Nachname.TrimStart("Prof. Dr.")
            $line.Titel = "Prof. Dr."
        }
        elseif ($line.Nachname -like "Prof.*") {
            $line.Nachname = $line.Nachname.TrimStart("Prof.")
            $line.Titel = "Prof."
        }
    }
    catch {
        $fehlerhaft = $true
        $fehlercode += "(12)"
    }

    #################################
    # Correct Date format           # OK
    #################################

    [string[]] $datum = $line.Geburtsdatum
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
        $line.Geburtsdatum = $date_format
    }
    catch{
        try {
            $unix = Get-Date -UnixTimeSeconds $line.Geburtsdatum -Format "dd.MM.yyyy"
            $line.Geburtsdatum = $unix
        }
        catch {
            $fehlerhaft = $true
            $fehlercode += "(14)"
        }
    }

    #################################
    # Phone Number "Telefon"        # OK
    #################################

    $telefon_in = $line.Telefon
    $telefon_slash = $telefon_in.Replace("/", "")
    $telefon_space = $telefon_slash.Replace(" ", "")
    $telefon_dot = $telefon_space.Replace(".", "")
    $telefon_strip = $telefon_dot.Replace("-", "")
    $telefon_49 = $telefon_strip.Replace("+49", "")
    $telefon_00 = $telefon_49.Replace("(0)", "")
    $telefon_0 = $telefon_00.TrimStart("0")
    try {
        if ($telefon_0.Length -eq 8) {
            $format_tel = "{0:$tel_format8}" -f [int64]$telefon_0
            $line.Telefon = $format_tel
        }
        elseif ($telefon_0.Length -eq 9) {
            $format_tel = "{0:$tel_format9}" -f [int64]$telefon_0
            $line.Telefon = $format_tel
        }
        elseif ($telefon_0.Length -eq 10) {
            $format_tel = "{0:$tel_format10}" -f [int64]$telefon_0
            $line.Telefon = $format_tel
        }
        elseif ($telefon_0.Length -eq 11) {
            $format_tel = "{0:$tel_format11}" -f [int64]$telefon_0
            $line.Telefon = $format_tel
        }
        elseif ($telefon_0.Length -eq 12) {
            $format_tel = "{0:$tel_format12}" -f [int64]$telefon_0
            $line.Telefon = $format_tel
        }
    }
    catch {
        $fehlerhaft = $true
        $fehlercode += "(17)"
    }

    #################################
    # Phone Number "Mobil"          # OK
    #################################

    if ($line.Mobil -ne "$null") {
        $mobil_in = $line.Mobil
        $mobil_slash = $mobil_in.Replace("/", "")
        $mobil_space = $mobil_slash.Replace(" ", "")
        $mobil_dot = $mobil_space.Replace(".", "")
        $mobil_strip = $mobil_dot.Replace("-", "")
        $mobil_49 = $mobil_strip.Replace("+49", "")
        $mobil_00 = $mobil_49.Replace("(0)", "")
        $mobil_0 = $mobil_00.TrimStart("0")
        try {
            if ($mobil_0.Length -eq 8) {
                $format_mobil = "{0:$tel_format8}" -f [int64]$mobil_0
                $line.Mobil = $format_mobil
            }
            elseif ($mobil_0.Length -eq 9) {
                $format_mobil = "{0:$tel_format9}" -f [int64]$mobil_0
                $line.Mobil = $format_mobil
            }
            elseif ($mobil_0.Length -eq 10) {
                $format_mobil = "{0:$tel_format10}" -f [int64]$mobil_0
                $line.Mobil = $format_mobil
            }
            elseif ($mobil_0.Length -eq 11) {
                $format_mobil = "{0:$tel_format11}" -f [int64]$mobil_0
                $line.Mobil = $format_mobil
            }
            elseif ($mobil_0.Length -eq 12) {
                $format_mobil = "{0:$tel_format12}" -f [int64]$mobil_0
                $line.Mobil = $format_mobil
            }
        }
        catch {
            $fehlerhaft = $true
            $fehlercode += "(18)"
        }
    }

    #################################
    # Phone Number "Fax"            # OK
    #################################

    if ($line.Fax -ne "$null") {
        $fax_in = $line.Fax
        $fax_slash = $fax_in.Replace("/", "")
        $fax_space = $fax_slash.Replace(" ", "")
        $fax_dot = $fax_space.Replace(".", "")
        $fax_strip = $fax_dot.Replace("-", "")
        $fax_49 = $fax_strip.Replace("+49", "")
        $fax_00 = $fax_49.Replace("(0)", "")
        $fax_0 = $fax_00.TrimStart("0")
        try {
            if ($fax_0.Length -eq 8) {
                $format_fax = "{0:$tel_format8}" -f [int64]$fax_0
                $line.Fax = $format_fax
            }
            elseif ($fax_0.Length -eq 9) {
                $format_fax = "{0:$tel_format9}" -f [int64]$fax_0
                $line.Fax = $format_fax
            }
            elseif ($fax_0.Length -eq 10) {
                $format_fax = "{0:$tel_format10}" -f [int64]$fax_0
                $line.Fax = $format_fax
            }
            elseif ($fax_0.Length -eq 11) {
                $format_fax = "{0:$tel_format11}" -f [int64]$fax_0
                $line.Fax = $format_fax
            }
            elseif ($fax_0.Length -eq 12) {
                $format_fax = "{0:$tel_format12}" -f [int64]$fax_0
                $line.Fax = $format_fax
            }
        }
        catch {
            $fehlerhaft = $true
            $fehlercode += "(1B)"
        }
    }

    #################################
    # Trim empty spaces from the    # OK
    # end and the beginning         #
    #################################

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

    #################################
    # set active param              # OK
    #################################

    $line.Aktiv = $line.Aktiv.ToLower()

    if ($line.Aktiv -like "ja") {
        $line.Aktiv = $line.Aktiv.Replace("ja", "$true")
    }
    elseif ($line.Aktiv -like "nein") {
        $line.Aktiv = $line.Aktiv.Replace("nein", "$false")
    }
    elseif ($line.Aktiv -eq "$null") {
        $fehlerhaft = $true
        $fehlercode += "(1C)"
    }

    #################################
    # Other data check              # OK
    #################################
    
    if ($line.'Nr.' -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(01)"
    }
    if ($line.Anrede -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(03)"
    }
    if ($line.Anrede -eq "$null") {
        $fehlerhaft = $true
        $fehlercode += "(13)"
    }
    if ($line.Titel -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(02)"
    }
    if ($line.Vorname -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(04)"
    }
    if ($line.Nachname -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(05)"
    }
    if ($line.Geburtsdatum -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(06)"
    }
    if ($line.Strasse -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(07)"
    }
    if ($line.Hausnummer -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(08)"
    }
    if ($line.Postleitzahl -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(09)"
    }
    if ($line.Stadt -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(0A)"
    }
    if ($line.Telefon -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(0B)"
    }
    if ($line.Mobil -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(0C)"
    }
    if ($line.EMail -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(0D)"
    }
    if ($line.Firma -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(0E)"
    }
    if ($line.Bundesland -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(0F)"
    }
    if ($line.Fax -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(10)"
    }
    if ($line.Aktiv -like "*�*") {
        $fehlerhaft = $true
        $fehlercode += "(11)"
    }

    #################################
    # Make error visible in user    # OK
    #################################

    if ($fehlerhaft -eq $true) {
        $line.'Zusatz 2' = $fehlerhaft
        $line.'Zusatz 3' = $fehlercode
    }
    else {
        $line.'Zusatz 2' = $fehlerhaft
    }
}

$csv | Export-Csv -Path ./clean_data_2.csv -NoTypeInformation