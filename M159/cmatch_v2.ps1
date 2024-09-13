$csv = Import-Csv './test.csv' -Delimiter ","

foreach ($line in $csv) {
    #$nonASCII = $line.'Nr.' -cmatch '[^\x20-\x7F]'
    #$nonASCII = $line.Anrede -cmatch '[^\x20-\x7F]'
    #$nonASCII = $line.Titel -cmatch '[^\x20-\x7F]'
    $nonASCII = $line.Nachname -cmatch '[^\x20-\x7F|äöüÄÖÜ|�]'

    if ($nonASCII -eq $true) {
        Write-Host "Non ASCII character detected at line: " $line.'Nr.'
        Write-Host "Current user is: " $line.Nachname
    }
    #else {
    #    Write-Host "No non ASCII character detected."
    #    Write-Host "Current user is: " $line.Vorname
    #}
}