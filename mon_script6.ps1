$FilePath = Read-Host "Entrez le chemin du fichier texte contenant la liste des noms des machines"
if (-not (Test-Path -Path $FilePath)) {
  Write-Warning "Fichier introuvable : $FilePath"
  exit
}
$Machines = Get-Content -Path $FilePath
$Date = Get-Date -Format "dd-MM-yyyy_HH-mm-ss"
$ReportFile = Join-Path -Path $PSScriptRoot -ChildPath "rapport_machines_$Date.txt"
New-Item -Path $ReportFile -ItemType File -Force | Out-Null
Write-Host "`nFichier de rapport cree : $ReportFile"

$Joignable = 0
$NJoignable = 0

foreach ($Machine in $Machines) {
  Write-Host "Le ping de la machine $Machine est en cours..."
  $Ping = Test-Connection $Machine -Count 1 -Quiet -ErrorAction SilentlyContinue

  if ($Ping -eq $true) {
    Write-Host "$Machine est JOIGNABLE"
    Add-Content "rapport_machines_$Date.txt" "$Date | $Machine est JOIGNABLE"
    $Joignable++
  }
  else {
    Write-Host "$Machine n'est pas JOIGNABLE"
    Add-Content "rapport_machines_$Date.txt" "$Date | $Machine n'est pas JOIGNABLE"
    $NJoignable++
  }
}
Write-Host "`nTotal de machine JOIGNABLE : $Joignable"
Write-Host "Total de machine non JOIGNABLE : $NJoignable"
Write-Host "`nLe script a corectement ete execute"
Write-Host "Historique enregistre dans : $ReportFile"
