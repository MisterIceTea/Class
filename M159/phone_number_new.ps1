$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

$tel_format8 = '"+49" ### #####'
$tel_format9 = '"+49" ### ######'
$tel_format10 = '"+49" ### #######'
$tel_format11 = '"+49" ### ########'
$tel_format12 = '"+49" ### #########'

foreach ($line in $csv) {
    $telefon_in = $line.Telefon
    $telefon_slash = $telefon_in.Replace("/", "")
    $telefon_space = $telefon_slash.Replace(" ", "")
    $telefon_dot = $telefon_space.Replace(".", "")
    $telefon_strip = $telefon_dot.Replace("-", "")
    $telefon_49 = $telefon_strip.Replace("+49", "")
    $telefon_00 = $telefon_49.Replace("(0)", "")
    $telefon_q = $telefon_00.Replace("�", "")
    $telefon_0 = $telefon_q.TrimStart("0")
    if ($telefon_0.Length -eq 8) {
        $format_tel = "{0:$tel_format8}" -f [int64]$telefon_0
        $format_tel
    }
    elseif ($telefon_0.Length -eq 9) {
        $format_tel = "{0:$tel_format9}" -f [int64]$telefon_0
        $format_tel
    }
    elseif ($telefon_0.Length -eq 10) {
        $format_tel = "{0:$tel_format10}" -f [int64]$telefon_0
        $format_tel
    }
    elseif ($telefon_0.Length -eq 11) {
        $format_tel = "{0:$tel_format11}" -f [int64]$telefon_0
        $format_tel
    }
    elseif ($telefon_0.Length -eq 12) {
        $format_tel = "{0:$tel_format12}" -f [int64]$telefon_0
        $format_tel
    }
    else {
        Write-Host "actual length" $telefon_0.Length
    }
}