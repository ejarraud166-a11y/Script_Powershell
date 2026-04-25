#Demande à l'utilisateur d'entrer le chemin du répertoire cible
$Path = Read-Host "Entrez le chemin du repertoire pour la suppression de fichier .log"
#Vérification que le chemin entré soit correct
$Result = Test-Path -Path $Path
#Supprime tous les fichiers .log dans le répertoire spécifié
#Force la suppression des fichiers en lecture seule
#Ignore les erreurs silencieusement
if ($Result -eq $true) {
	Remove-Item -Path "$Path\*.log" -Force -ErrorAction SilentlyContinue
	#Confirmation au près de l'utilisateur que la suppession s'est corectement déroulé
	Write-Host "Les fichier de logs on bien ete supprimes"
}
else {
	#Avertit l'utilisateur que le chemin spécifié n'est présent dans le système
	Write-Warning "Le chemin specifie n'est pas correct"
}
