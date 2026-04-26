$FilePath = Read-Host "Entrez le chemin du fichier texte contenant la liste des noms des machines"
if (-not (Test-Path -Path $FilePath)) {
  Write-Warning "Fichier introuvable : $FilePath"
}
$Machines = Get-Content -Path $FilePath
$Date = Get-Date -Format "dd/MM/yyyy_HH/mm/ss"
$ReportFile = Join-Path -Path $PSScriptRoot -ChildPath "rapport_machines_$Datee.txt"
New-Item -Path $ReportFile -ItemType File | Out-Null
Write-Host "`nFichier de rapport cree : $ReportFile"

foreach ($Machines in $Machines) {
  Write-Host "Le ping de la machine $Machines est en cours..."
  $Ping = Test-Connection $Machines -Count 1 -Quiet -ErrorAction SilentlyContinue

  if ($Ping -eq $true) {
    Add-Content "rapport_machines_$Datee.txt" "$Machines est JOIGNABLE"
  }
  else {
    Add-Content "rapport_machines_$Datee.txt" "$Machines n'est pas JOIGNABLE"
  }
}
