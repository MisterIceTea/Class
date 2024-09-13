$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

#[string[]] $formats = 'yyMMdd', 'yyyyMMdd', 'dd/MM/yyyy', 'dd-MM-yyyy'

[string[]]$formats = "dd.MM.yyyy", "MM/dd/yyyy", "yyyy-MM-dd"


foreach ($line in $csv) {
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
        Write-Host "User" $line.'Nr.' "has" $date
    }
    catch{
        try {
            $unix = Get-Date -UnixTimeSeconds $line.Geburtsdatum
            Write-Host "User" $line.'Nr.' "has" $unix
        }
        catch {
            Write-Host "Problem with User" $line.'Nr.' "has date" $datum
        }
    }
}
