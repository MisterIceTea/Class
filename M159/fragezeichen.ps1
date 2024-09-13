$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

$counter = 0

foreach ($line in $csv) {
    if ($line.'Nr.' -like "*�*") {
        $counter += 1
    }
}

$counter