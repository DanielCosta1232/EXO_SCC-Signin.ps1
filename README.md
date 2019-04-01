### EXO_SCC-Signin.ps1
Script prompts 1 of 3 sign in options. Exchange Online, Security & Compliance or both. The 'both' option utilizies the prefix -cc for Security & Compliance cmdlets to differentiate between similar EXO cmdlets.

If you return any errors, ensure that scripting is enabled on the machine using the cmdlets below, then re-run the script.
Get-ExecutionPolicy -Scope CurrentUser
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned