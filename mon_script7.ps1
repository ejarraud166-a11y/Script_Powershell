#J'ai choisi de faire un script qui permet de faire un scan réseau.
#Il effectuera un scan réseau et enregistrera toutes les ip dans un fichier txt
#Pouvant ainsi permettre la détection d'adresse non utilisé dans le réseau,
#ce qui peut être pratique dans le cas où nous voulons a attribuer une adresse
#à un poste mais que nous ne savons pas qu'elles adresses sont déja occupé.
Do {
    Write-Host "`n1- Lancer le scan reseau `n2- Lister les adresses d un fichier `n3- Sortir du script"
    $Number = Read-Host "Choisir un chiffre entre 1 et 2 (3 pour sortir)"

    switch ($Number) {

        1 {
            $LocalIP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "*Ethernet*","*Wi-Fi*" | 
                Where-Object { $_.IPAddress -notlike "169.*" } | 
                Select-Object -First 1).IPAddress

            $ReportFile = Join-Path -Path $PSScriptRoot -ChildPath "rapport_ip.txt"
            $Plage      = $LocalIP -replace "\.\d+$", ""

            foreach ($i in 1..254) {
                $IP   = "$Plage.$i"
                $Ping = Test-Connection -ComputerName $IP -Count 1 -Quiet -ErrorAction SilentlyContinue

                if ($Ping) {
                    Write-Host "$IP est actuellement OCCUPEE" -ForegroundColor Red
                    Add-Content -Path $ReportFile -Value "$IP | OCCUPEE"
                } else {
                    Write-Host "$IP est actuellement LIBRE" -ForegroundColor Green
                    Add-Content -Path $ReportFile -Value "$IP | LIBRE"
                }
            }
        }
        2 {
            $FilePath = Read-Host "Veuillez entrer le chemin du fichier"
            if (Test-Path $FilePath) {
                Get-Content -Path $FilePath
            } else {
                Write-Warning "Aucun rapport trouve, lancez d abord un scan"
            }
        }
        3 { Write-Host "Sortie du script" }
        default { Write-Warning "Choisissez un chiffre entre 1 et 3" }
    }
} While ($Number -ne 3)
