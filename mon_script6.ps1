#Demande à l'utilisateur d'indiquer le chemin où se trouve la liste des noms des machines
$FilePath = Read-Host "Entrez le chemin du fichier texte contenant la liste des noms des machines"
#Vérification de l'existence du chemin indiqué avec une boucle "for".
#Si le chemin est invalide alors, il retourne une erreur
if (-not (Test-Path -Path $FilePath)) {
  Write-Warning "Fichier introuvable : $FilePath"
  exit
}
#Va lire toutes les lignes du fichier des machines pour ensuite les intégrer à la variable "$Machines"
$Machines = Get-Content -Path $FilePath
$Date = Get-Date -Format "dd-MM-yyyy_HH-mm-ss"
#Création du fichier "rapport_machines.txt"
$ReportFile = Join-Path -Path $PSScriptRoot -ChildPath "rapport_machines.txt"
#Affichage érgonomique et distinct lors que plusieurs rapports seront effectués
Add-Content -Path $ReportFile -Value "---------------------------------------------------------"
Add-Content -Path $ReportFile -Value "Rapport du : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')"
Write-Host "`nFichier de rapport cree : $ReportFile"

#Création des variables $Joignable et $NJoignable pour à la fin faire un décompte des machines qui l'ont été ou non
$Joignable = 0
$Joignable = 0

#Boucle "foreach" qui nous permet d'exécuter notre bloc de code
#"$Machine" prend la valeur de l'élément suivant dans "$Machines", jusqu'au moment que tous aient bien été traités
foreach ($Machine in $Machines) {
  Write-Host "Le ping de la machine $Machine est en cours..."
  #A l'aide de la fonction "Test-Connection" nous allons pouvoir établir un Ping à notre variable $Machine
  $Ping = Test-Connection $Machine -Count 1 -Quiet -ErrorAction SilentlyContinue

  #Si il y a bien eu une connexion d'établie alors, il informera l'utilisateur et l'indiquera dans le rapport
  if ($Ping -eq $true) {
    Write-Host "$Machine est JOIGNABLE"
    Add-Content "rapport_machines.txt" "$Date | $Machine est JOIGNABLE"
    #Incrémentation de notre variable "$Joignable" pour le comptage en fin de script
    $Joignable++
  }
  #Dans le cas contaire, alors il informera l'utilisateur et l'indiquera dans le rapport que le Ping n'a pas réussi
  else {
    Write-Host "$Machine n'est pas JOIGNABLE"
    Add-Content "rapport_machines.txt" "$Date | $Machine n'est pas JOIGNABLE"
    #Incrémentation de notre variable "$NJoignable" pour le comptage
    $NJoignable++
  }
}
#Délimitation du rapport dans le fichier rapport
Add-Content -Path $ReportFile -Value "---------------------------------------------------------"
Write-Host "`n ---Resume---"
#Indiquation du nombre totals de machines joignable ou non 
Write-Host "Total de machine JOIGNABLE : $Joignable"
Write-Host "Total de machine non JOIGNABLE : $NJoignable"
Write-Host "`nLe script a corectement ete execute"
Write-Host "Rapport enregistre dans : $ReportFile"
