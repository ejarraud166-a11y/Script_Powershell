#Utilisation de la boucle conditionnel Do While car celle-ci permet de mettre en place la condition de continuer l'exécution
Do {
    
    #Affichage du menu des opérations
    Write-Host "`n1- Somme `n2- Soustraction `n3- Produit `n4- Division `n5- Sortir du Script"
    $Number = Read-Host "`nChoisir un chiffre entre 1 et 4 (5 pour sortir)"

    if ($Number -ge 1 -and $Number -le 4) {
	
	#Demande à l'utilisateur de choisir deux nombre entier
        Write-Host "Vous allez choisir deux nombres"
        $First = [int](Read-Host "Choisissez votre Premier nombre")
        $Second = [int](Read-Host "Choisissez le deuxieme nombre")

        switch ($Number) {
            1 { $result = $First + $Second; $op = "+"; $label = "somme" }
            2 { $result = $First - $Second; $op = "-"; $label = "soustraction" }
            3 { $result = $First * $Second; $op = "*"; $label = "produit" }
            4 { 
		#Vérification que si l'utilisateur a choisi un diviseur égal à zéro
                if ($Second -eq 0) {
                    Write-Warning "Division par zéro impossible"
                    continue
                }
                $result = $First / $Second; $op = "/"; $label = "division"
            }
        }
	
	#Affichage du résultat de l'opération choisie
        Write-Host "Voici la $label de vos deux nombres : $result"
	
	#ENregistrement du calcul effectué dans un fichier nommé 
        Write-Host "Voici la $label de vos deux nombres : $result"

        #Définit le chemin du fichier historique dans le même dossier que le script
        $file = Join-Path -Path $PSScriptRoot -ChildPath "historique.txt"

        #Création du fichier historique s'il n'existe pas encore
        if (-not (Test-Path -Path $file)) {
            New-Item -Path $file -ItemType File | Out-Null
            Write-Host "Fichier historique cree : $file"
        }

        Write-Host "Votre calcul a ete enregistre dans : $file"
    }

    elseif ($Number -eq 5) {
        Write-Host "Vous etes sorti du script"
    }

    else {
        Write-Warning "Veuillez choisir un chiffre entre 1 et 5"
    }

} While ($Number -ne 5)