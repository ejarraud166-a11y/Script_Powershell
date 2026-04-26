$FilePath = Read-Host "Entrez le chemin du fichier texte contenant la liste des noms des machines"
if (-not (Test-Path -Path $FilePath)) {
  Write-Warning "Fichier introuvable : $FilePath"
}
$Machines = Get-Content -Path $FilePath
$ReportFile = Join-Path -Path $PSScriptRoot -ChildPath "rapport_machines.txt"
