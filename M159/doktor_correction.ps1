$csv = Import-Csv './export_Kunden_DE_H.csv' -Delimiter ";"

foreach ($line in $csv) {
    if ($line.Nachname -like "Dr.*") {
        $
    }
}