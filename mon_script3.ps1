#Utilisation de la boucle conditionnel Do While car celle-ci permet de mettre en place la condition de continuer l'exécution
#du script tant que le chiffre 5 n'est pas sélectionné 
Do {
	#Correspond au message qui demande à l'utilisateur de choisir un chiffre entre 1 et 4 pour effectuer une action,
	#ensuite la valeur est stocké dans une variable nommée $Number
	Write-Host "`n1- Veuillez indiquer le nom d'un fichier `n2- Veuillez indiquer le nom d'un dossier `n3- Veuillez indiquer un nom de fichier et son contenu sera affiche `n4- Liste des fichiers/dossiers de l'empacement courant `n5- Sortir du Script"
	$Number = Read-Host "`nChoisir un chiffre entre 1 et 4 pour effectuer une action (5 pour sortir)"
	 
	switch ($Number) { #Utilisation de notre variable avec la fonctionnalité Switch qui permet d'effectuer une action dite
	#Permet la création de fichier dans le dossier courant
	1 { $Name = Read-Host "Indiquez le nom du fichier";
		New-Item -Path "$Name.txt" -ItemType "File";
		Write-Host "Le fichier a corectement ete cree `n" }
	#Permet la création d'un dossier dans un répertoir que l'utilisateur choisi
	2 { $Path = Read-Host "Entrez le chemin du repertoire";
		$Result = Test-Path -Path $Path;
		if ($Result -eq $true) {
			$Name = Read-Host "Indiquez le nom du dossier"
			New-Item -Path "$Path\$Name" -ItemType "Directory"
			Write-Host "Le dossier a corectement ete cree `n"
		}
		else {
			Write-Warning "Le chemin specifie n'est pas correct `n"
		} }
	#Permet de voir le contenu d'un fichier dit dans un réperertoir choisi par l'utilisateur
	3 { $Path = Read-Host "Entrez le chemin du repertoire";
		$Result = Test-Path -Path $Path;
		if ($Result -eq $true) {
			$Name = Read-Host "Indiquez le nom du fichier"
			Get-Content -Path "$Path\$Name"
		}
		else {
			Write-Warning "Le chemin specifie n'est pas correct `n"
		} }
	#Permet de lister le contenu d'un répertoir choisi par l'utilisateur	
	4 { $Path = Read-Host "Entrez le chemin du repertoire";
		$Result = Test-Path -Path $Path;
		if ($Result -eq $true) {
			Get-ChildItem -Path $Path
		}
		else {
			Write-Warning "Le chemin specifie n'est pas correct `n"
		} }
	#Permet d'arrêter l'exécution du script dès que le chiffre 5 a été choisi par l'utilisateur	
	5 { Write-Host "Vous etes sortie du Script `n" }
	
	#Permet de prévenir l'utilisateur que la valeur choisi n'est pas comprise dans la plage mise à disposition
	default { Write-Warning "`nVeuillez choisir un chiffre compris entre 1 et 5" }
	}
} While ($Number -ne 5)
