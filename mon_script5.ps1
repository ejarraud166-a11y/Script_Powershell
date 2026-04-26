Do {
	$FilePath = Read-Host "Entrez le chemin du fichier texte contenant la liste des utilisateurs"

	#Vérification de la précense du fichier dans le système
	if (-not (Test-Path -Path $FilePath)) {
		Write-Warning "Fichier introuvable : $FilePath"
		exit
	}
	#Demande à l'utilisateur l'action qu'il veut faire 
	Write-Host "1- Creer les utilisateurs"
	Write-Host "2- Supprimer les utilisateurs"
	Write-Host "3- Sortie du Script"
	$Number = Read-Host "Choisissez une action 1 ou 2 (3 pour sortir)"
	#Définit le chemin du fichier pour l'historique des utilisateurs qui seront créés ou supprimés
	$HistoFile = Join-Path -Path $PSScriptRoot -ChildPath "historique_users.txt"
	#Crée le fichier historique dans le cas où il n'existe toujours pas
	if (-not (Test-Path -Path $HistoFile)) {
		New-Item -Path $HistoFile -ItemType File | Out-Null
		Write-Host "`nFichier historique cree : $HistoFile"
	}
	#Va lire toutes les lignes du fichier indiqué
	$Lines = Get-Content -Path $FilePath
	#Utilisattion de la boucle foreach pour l'exécution notre gros bloc de code
	foreach ($Line in $Lines) {
		#Séparrtion du nom et du type de l'utilisateur "administrateur" ou "utilisateur" 
		$Username, $Type = $Line -split ":"
		#Vérification que le type est "adm" ou "usr"
		if ($Type -ne "adm" -and $Type -ne "usr") {
			Write-Warning "`nType invalide pour '$Username' : $Type (attendu : adm ou usr)"      
		}	
		if ($Number -ge 1 -and $Number -le 3) {		
			switch ($Number) {
				1 {
					#Utilisation de la fonction "Get-LocalUser" pour obetnir le nom d'host de l'utilisateurVérifie si l'utilisateur existe déjà
					if (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue) {
						Write-Warning "`nL'utilisateur '$Username' existe deja"
						break
					}
					#Définit un mot de passe par défaut "caribou23" pour le nouvel utilisateur créé
					#Convertion du mdp qui est en clair en en objet de type "SecureString" ce qui permet de chiffrer le mdp
					#"-AsPlainText" Permet d'indiquer au "SecureString" que nous donnons du texte en clair
					$Password = ConvertTo-SecureString "caribou23" -AsPlainText -Force
					#Création de l'utilisateur en local
					New-LocalUser -Name $Username -Password $Password -FullName $Username -Description "Cree par mon script" | Out-Null
					#Ajout de l'utilisateur à un groupe à l'aide de la fonction "Add-LocalGroupMember" tout en lui spécifiant son groupe auquel il appartient
					if ($Type -eq "adm") {
						Add-LocalGroupMember -Group "Administrators" -Member $Username
						$GroupLabel = "Administrateur"
					} else {
						Add-LocalGroupMember -Group "Utilisateurs" -Member $Username
						$GroupLabel = "Utilisateur"
					}
					Write-Host "Utilisateur cree : $Username  |  Groupe : $GroupLabel"
					#Enregistrement de la création de l'utilisateur dans le fichier historique_users.txt
					$DateLine = "$(Get-Date -Format 'dd/MM/yyyy HH:mm:ss') | CREATION | $Username | $GroupLabel"
					Add-Content -Path $HistoFile -Value $DateLine
					Write-Host "Le script a corectement ete execute`n"
					Write-Host "Historique enregistre dans : $HistoFile"
					continue
				}
	
				2 {
					#Vérification de l'existence de l'utilisateur pour savoir si il existe ou pas 
					#avant de le supprimer toujours avec l'utilisation de "Get-LocalUser"
					if (-not (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue)) {
						Write-Warning "L'utilisateur '$Username' n'existe pas"
						break
					}
					#Supprime l'utilisateur local avec cette fois-ci "Remove-LocalUser"
					Remove-LocalUser -Name $Username
					Write-Host "Utilisateur supprime : $Username"
					#Enregistrement de la suppression de l'utilisateur dans le fichier historique_users.txt
					$DateLine = "$(Get-Date -Format 'dd/MM/yyyy HH:mm:ss') | SUPPRESSION | $Username"
					Add-Content -Path $HistoFile -Value $DateLine
					Write-Host "Le script a corectement ete execute"
					Write-Host "Historique enregistre dans : $HistoFile"
					continue
				}
				
				3 { Write-Host "Vous etes sortie du script" 
					break
				}
				
				default {
					Write-Warning "Veuillez choisir un chiffre entre 1 et 2 (3 pour sortir)."
					exit
				}
			}
		}	
	}
}While ($Number -ne 3)
# 