#J'ai choisi de faire un script qui permet de faire un scan réseau.
#Il effectuera un scan réseau et enregistrera toutes les ip dans un fichier txt
#Pouvant ainsi permettre la détection d'adresse non utilisé dans le réseau,
#ce qui peut être pratique dans le cas où nous voulons a attribuer une adresse
#à un poste mais que nous ne savons pas qu'elles adresses sont déja occupé.

Do {
Write-Host "`n1- Lancer le scan réseau `n2- Lister les adresses d un fichier 3- Sortir du script"
$Number = Read-Host "Choisir un chiffre entre 1 et 2 (3 pour sortir)"
switch ($Number) {
        
        1 { $LocalIP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "*Ethernet*","*Wi-Fi*" | 
            Where-Object { $_.IPAddress -notlike "169.*" } | 
            Select-Object -First 1).IPAddress
        $ReportFile = Join-Path -Path $PSScriptRoot -ChildPath "rapport_ip.txt"
        Add-Content -Path $ReportFile -Value "$LocalIP"
        $Plage = $LocalIP -replace "\.\d+$" }
 
} While ($Number -ne 3) 
