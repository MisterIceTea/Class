# Define a hashtable with character replacements
$replacements = @{
    'ä' = 'ue'
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

# Path to your CSV file
$csvFilePath = "C:\path\to\your\file.csv"

# Column to exclude from replacement
$excludeColumn = 'ColumnNameToExclude'

# Read the CSV file
$data = Import-Csv -Path $csvFilePath

# Loop through each row
foreach ($row in $data) {
    # Loop through each column
    foreach ($column in $row.psobject.Properties) {
        # Check if the column is not the one to exclude
        if ($column.Name -ne $excludeColumn) {
            # Replace characters in each column except the excluded one
            foreach ($key in $replacements.Keys) {
                $row.$($column.Name) = $row.$($column.Name) -replace $key, $replacements[$key]
            }
        }
    }
}

# Export the modified data back to the CSV file
$data | Export-Csv -Path $csvFilePath -NoTypeInformation