#Création  d'un nouveau dossier dans le chemin indiqué
New-Item -Path "C:\POWERSHELL" -Name "temp" -ItemType "Directory"
#Mise en place d'un marque page sur le dossier actuel
Push-Location -Path "C:\POWERSHELL\temp"
#Boucle conditionnelle permettant la création de fichier .log de 1 à 200 
for ($i =1 ; $i -le 200 ; $i++){
	New-Item -Path "$i.log" -ItemType "File" -Value "Ceci est un fichier de log genere par mon script"
}
#Permet de revenir à notre marque page
Pop-Location

