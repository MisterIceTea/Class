$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

#[string[]] $formats = 'yyMMdd', 'yyyyMMdd', 'dd/MM/yyyy', 'dd-MM-yyyy'

[string[]]$date_formats = @("dd.MM.yyyy", "MM/dd/yyyy", "yyyy-MM-dd")
$formatted_date = $null

foreach ($line in $csv) {
    [string[]] $datum = $line.Geburtsdatum
    foreach ($format in $date_formats) {
        $erfolgreich = $false
        Write-Host "User:" $line.'Nr.' "has date:" $datum "try to parse with:" $format
        $conversion = [DateTime]::TryParseExact($datum, $format, [ref]$formatted_date)
        if ($conversion) {
            $erfolgreich = $true
            break
        }
    }
    if ($erfolgreich -eq $true) {
        #return $formatted_date.ToString("dd.MM.yyyy")
        $successful_dateconvert = $formatted_date.ToString("dd.MM.yyyy")
        Write-Host "User" $line.'Nr.' "has" $successful_dateconvert
    }
    else {
        try {
            $unixZeitstempel = [int]$datum
            $datum = Get-Date -Date "1970-01-01 00:00:00" -UFormat "%s" | ForEach-Object { ($_ + $unixZeitstempel) | Get-Date }
        }
        catch {
            Write-Host "Something went wrong with User" $line.'Nr.' "has" $date
        }
    }
}


<#foreach ($line in $csv) {
    [string[]] $datum = $line.Geburtsdatum
    $date = $datum | ForEach-Object {
        [datetime]::ParseExact(
            $_,
            $formats,
            [cultureinfo]::InvariantCulture,
            [System.Globalization.DateTimeStyles]::None
        )
    }
    Write-Host "User" $line.'Nr.' "has" $date
}#>

<#$datesToTest = '1605221412', '09/02/2022', '02-09-2022'
[string[]] $formats = 'yyMMddHHmm', 'yyyyMMddHHmm', 'dd/MM/yyyy', 'dd-MM-yyyy'
$datesToTest | ForEach-Object {
    [datetime]::ParseExact(
        $_,
        $formats,
        [cultureinfo]::InvariantCulture,
        [System.Globalization.DateTimeStyles]::None)
}#>