Import-Module ActiveDirectory

$csv = Import-Csv '.\test_data.csv' -Delimiter ","

foreach ($user in $csv) {
    try {
        #Hier muss unbedingt noch die abfrage gemacht werden ob der user fehlerhaft ist, um den OU variablenpfad zu definieren
        
        $Password = "X$($user.'Zusatz 1')!rst*"

        if ($user.'Zusatz 2' -eq $true) {
            if ($user.'Aktiv' -eq $true) {
                $OU = "OU=Zu pruefende Benutzer,OU=Benutzer,OU=DE,OU=Intersped AG,DC=interspedag,DC=local"
            }
            elseif ($user.'Aktiv' -eq $false) {
                $OU = "OU=Deaktivierte Benutzer,OU=Benutzer,OU=DE,OU=Intersped AG,DC=interspedag,DC=local"
            }
            else {
                $OU = "OU=Zu pruefende Benutzer,OU=Benutzer,OU=DE,OU=Intersped AG,DC=interspedag,DC=local"
            }
        }
        elseif ($user.'Zusatz 2' -eq $false) {
            if ($user.'Aktiv' -eq $true) {
                $OU = "OU=Benutzer,OU=Benutzer,OU=DE,OU=Intersped AG,DC=interspedag,DC=local"
            }
            else {
                $OU = "OU=Deaktivierte Benutzer,OU=Benutzer,OU=DE,OU=Intersped AG,DC=interspedag,DC=local"
            }
        }

        $NewUserParams = @{
            Name                  = "$($user.'Vorname') $($user.'Nachname')"
            GivenName             = $user.'Vorname'
            Surname               = $user.'Nachname'
            DisplayName           = "$($user.'Vorname') $($user.'Nachname')"
            UserPrincipalName     = $user.'Zusatz 1'
            SamAccountName        = $user.'Zusatz 1'
            StreetAddress         = "$($user.'Strasse') $($user.'Hausnummer')"
            City                  = $user.'Stadt'
            State                 = $user.'Bundesland'
            PostalCode            = $user.'Postleitzahl'
            Country               = "DE"
            Company               = $user.'Firma'
            Path                  = $OU
            Description           = $user.'Zusatz 3'
            OfficePhone           = $user.'Telefon'
            EmailAddress          = $user.'EMail'
            MobilePhone           = $user.'Mobil'
            Fax                   = $user.'Fax'
            AccountPassword       = (ConvertTo-SecureString "$Password" -AsPlainText -Force)
            Enabled               = if ($user.'Aktiv' -eq $true) { $true } else { $false }
            ChangePasswordAtLogon = $true # Set the "User must change password at next logon"
        }
        #$NewUserParams
        #$Password
        New-ADUser @NewUserParams
        Write-Host "User $($user.'Zusatz 1') has been successfully created" -ForegroundColor Green

    }
    catch {
        Write-Host "Failed to create user $($User.'User logon name') - $($_.Exception.Message)" -ForegroundColor Red
    }
}