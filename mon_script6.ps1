$FilePath = Read-Host "Entrez le chemin du fichier texte contenant la liste des noms des machines"
if (-not (Test-Path -Path $FilePath)) {
  Write-Warning "Fichier introuvable : $FilePath"
  exit
}
$Machines = Get-Content -Path $FilePath
$Date = Get-Date -Format "dd-MM-yyyy_HH-mm-ss"
$ReportFile = Join-Path -Path $PSScriptRoot -ChildPath "rapport_machines.txt"
Add-Content -Path $ReportFile -Value "---------------------------------------------------------"
Add-Content -Path $ReportFile -Value "Rapport du : $(Get-Date -Format 'dd/MM/yyyy HH:mm:ss')"
Write-Host "`nFichier de rapport cree : $ReportFile"

$Joignable = 0
$NJoignable = 0

foreach ($Machine in $Machines) {
  Write-Host "Le ping de la machine $Machine est en cours..."
  $Ping = Test-Connection $Machine -Count 1 -Quiet -ErrorAction SilentlyContinue

  if ($Ping -eq $true) {
    Write-Host "$Machine est JOIGNABLE"
    Add-Content "rapport_machines.txt" "$Date | $Machine est JOIGNABLE"
    $Joignable++
  }
  else {
    Write-Host "$Machine n'est pas JOIGNABLE"
    Add-Content "rapport_machines.txt" "$Date | $Machine n'est pas JOIGNABLE"
    $NJoignable++
  }
}
Add-Content -Path $ReportFile -Value "---------------------------------------------------------"
Write-Host "`n ---Resume---"
Write-Host "Total de machine JOIGNABLE : $Joignable"
Write-Host "Total de machine non JOIGNABLE : $NJoignable"
Write-Host "`nLe script a corectement ete execute"
Write-Host "Rapport enregistre dans : $ReportFile"
