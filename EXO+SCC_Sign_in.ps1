# If you return any errors, ensure that scripting is enabled on the machine. Then rerun the script
# Get-ExecutionPolicy -Scope CurrentUser
# Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

function Connect-EXO {
  $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $credential -Authentication Basic -AllowRedirection
  Import-PSSession $Session -AllowClobber -DisableNameChecking
}

function Connect-SCC {
  $ccSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $credential -Authentication Basic -AllowRedirection
  Import-PSSession $ccSession -AllowClobber
}

function Connect-SCCP {
  $ccSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $credential -Authentication Basic -AllowRedirection
  Import-PSSession $ccSession -Prefix cc -AllowClobber
}

# Script 
$WindowsID = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$WindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($WindowsID)
$AdminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

if ($WindowsPrincipal.IsInRole($AdminRole)) {
    Write-Host = "Please enter your credentials once prompted."
    Sleep -s 5
    $credential = Get-Credential
    $ConnectRequest = Read-Host "Do you want to connect to Exchange Online (EXO) or the Security & Compliance Center (SCC), or both? (please type either EXO, SCC or both)"
    $EXO = "EXO"
    $SCC = "SCC"
    $both = "both"
    if($ConnectRequest -eq "$EXO") {
      Clear-Host
      Write-Host "Connecting to Exchange Online.."
      Connect-EXO
      Clear-host 
      Write-Host "You are now connected to Exchange Online."
    }
    elseif($ConnectRequest -eq "$SCC") {
      Clear-Host
      Write-Host "Connecting to Security & Compliance Center.."
      Connect-SCC 
      Clear-Host
      Write-Host "You are now connected to the Security & Compliance Center."
    }
    elseif($ConnectRequest -eq "$both") {
      Clear-Host
      Write-Host "Connecting to both Exchange Online and the Security & Compliance Center."
      Connect-EXO
      Connect-SCCP
      Clear-Host
      Write-Host "You are now connected to both Exchange Online and the Security & Compliance Center. `nTo differeniate between EXO and SCC PowerShell cmdlets, please use the 'cc' prefix. (example: EXO uses: Search-AdminAuditLog while SCC uses: Search-ccAdminAuditLog)."
    }
}
else {
    Write-Host "`nPlease run this script in an elevated PowerShell window."
}