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
            #Utilisation de la commande "Get-NetIPAddress" qui va nous permettre de récuperer les adresses IP
            #Ce bloque de code permet de récupérer les adresses IPv4 des interfaces Ethernet et WIFI
            #Filtre et exlcus les adresses qui commence par 169 car il s'agit d'adresses APIPA généré automatiquement par Windows
            $LocalIP = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "*Ethernet*","*Wi-Fi*" | 
                Where-Object { $_.IPAddress -notlike "169.*" } | 
                Select-Object -First 1).IPAddress

            $ReportFile = Join-Path -Path $PSScriptRoot -ChildPath "rapport_ip.txt"
            $Plage = $LocalIP -replace "\.\d+$", ""
            #Boucle "foreach" pour répéter le processus 254 fois ce qui correspond au nombre d'adresses max pouvant être présente dans un réseau
            foreach ($i in 1..254) {
                $IP = "$Plage.$i"
                #Utilisation de la commande "Test-Connection" pour effectuer des ping ce qui nous permet de savoir si une machine
                #répond, si l'ip répond au ping cela veut dire qu'une machine utilise déjà et à l'inverse si il n'y aucune réponse
                #cela veut donc dire qu'elle n'est pas occupé
                $Ping = Test-Connection -ComputerName $IP -Count 1 -Quiet -ErrorAction SilentlyContinue
                #Boucle conditionnelle "for" pour informer l'utilisateur que le ping a répondue "$true"
                #Affiche donc un message en rouge pour indiquer que l'adresse est déjà prise
                if ($Ping) {
                    Write-Host "$IP est actuellement OCCUPEE" -ForegroundColor Red
                    Add-Content -Path $ReportFile -Value "$IP | OCCUPEE"
                    
                } 
                #Même chose mais cette fois-ci si le ping répond par "$false"
                #ffiche donc un message en vert pour indiquer que l'adresse est libre
                else {
                    Write-Host "$IP est actuellement LIBRE" -ForegroundColor Green
                    Add-Content -Path $ReportFile -Value "$IP | LIBRE"
                }
            }
        }
        2 {
            $FilePath = Read-Host "Veuillez entrer le chemin du fichier"
            if (Test-Path $FilePath) {
                Get-Content -Path $FilePath
            } 
            else {
                Write-Warning "Aucun rapport trouve, lancez d abord un scan"
            }
        }
        3 { Write-Host "Sortie du script" }
        default { Write-Warning "Choisissez un chiffre entre 1 et 3" }
    }
} While ($Number -ne 3)
