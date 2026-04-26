#Utilisation de la boucle conditionnel Do While car celle-ci permet de mettre en place la condition de continuer l'exécution
Do {   
    #Affichage du menu des opérations
    Write-Host "`n1- Somme `n2- Soustraction `n3- Produit `n4- Division `n5- Sortir du Script"
    $Number = Read-Host "`nChoisir un chiffre entre 1 et 4 (5 pour sortir)"
    if ($Number -ge 1 -and $Number -le 4) {
	#Demande à l'utilisateur de choisir deux nombre entier naturel
        Write-Host "Vous allez choisir deux nombres qui doivent etre des entiers naturels"
        $First = [int](Read-Host "Choisissez votre Premier nombre")
        $Second = [int](Read-Host "Choisissez le deuxieme nombre")
		#Permet le calcul de nos deux nombre avec les 4 différentes opérations
        switch ($Number) {
            1 { $result = $First + $Second; $operateur = "+"; $type = "somme" }
            2 { $result = $First - $Second; $operateur = "-"; $type = "soustraction" }
            3 { $result = $First * $Second; $operateur = "*"; $type = "produit" }
            4 { $result = $First / $Second; $operateur = "/"; $type = "division" }
        }	
		#Affichage du résultat de l'opération choisie
        Write-Host "Voici la $type de vos deux nombres : $result"
        #Définit le chemin du fichier historique dans le même dossier que le script peu importe où il est exécuter
        $file = Join-Path -Path $PSScriptRoot -ChildPath "historique.txt"
        #Création du fichier historique s'il n'existe pas encore
        if (-not (Test-Path -Path $file)) {
            New-Item -Path $file -ItemType File | Out-Null
            Write-Host "Fichier historique cree : $file"
        }
		#ENregistrement du calcul effectué dans un fichier contenant la date et l'heure de celui-ci
        $line = "$(Get-Date -Format 'dd/MM/yyyy HH:mm:ss') : $First $operateur $Second = $result"
        Add-Content -Path $file -Value $line
        #Confirmation à l'utilisateur que le calcul a bien été sauvegardé dans le fichié 
        Write-Host "Votre calcul a ete enregistre dans le fichier suivant : $file"
    }
    elseif ($Number -eq 5) {
        Write-Host "Vous etes sorti du script"
    }
    else {
        Write-Warning "Veuillez choisir un chiffre entre 1 et 5"
    }
} While ($Number -ne 5)