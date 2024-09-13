$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

foreach ($line in $csv) {
    #$nonASCII = $line.'Nr.' -cmatch '[^\x20-\x7F]'
    #$nonASCII = $line.Anrede -cmatch '[^\x20-\x7F]'
    #$nonASCII = $line.Titel -cmatch '[^\x20-\x7F]'
    $nonASCII = $line.Vorname -cmatch '[^\x20-\x7F]'

    if ($nonASCII -eq $true) {
        if ($line.Vorname -like "*ä*") {
            $line.Vorname = $line.Vorname.Replace("ä","ae")
        }
        $nonASCII = $line.Vorname -cmatch '[^\x20-\x7F]'
        if ($nonASCII -eq $true) {
            Write-Host Write-Host "Non ASCII character detected at line: " $line.'Nr.'
        }
    }

    #if ($nonASCII -eq $true) {
    #    Write-Host "Non ASCII character detected at line: " $line.'Nr.'
    #}
    #else {
    #    Write-Host "No non ASCII character detected."
    #}
}