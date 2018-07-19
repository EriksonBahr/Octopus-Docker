function Write-Log
{
  param (
    [string] $message
  )

  $timestamp = ([System.DateTime]::UTCNow).ToString("yyyy'-'MM'-'dd'T'HH':'mm':'ss")
  Write-Host "[$timestamp] $message"
}

function Execute-Command ($exe, $arguments)
{
  Write-Log "Executing command '$exe $($arguments -join ' ')'"
  $output = .$exe $arguments

  Write-CommandOutput $output
  if (($LASTEXITCODE -ne $null) -and ($LASTEXITCODE -ne 0)) {
    Write-Error "Command returned exit code $LASTEXITCODE. Aborting."
    exit 1
  }
  Write-Log "done."
}



$TentacleExe="C:\Program Files\Octopus Deploy\Tentacle\Tentacle.exe";
$TentacleConfig="C:\Octopus\Tentacle.config";
$TentacleConfigTemp="C:\Tentacle.config.orig"; # work around https://github.com/docker/docker/issues/20127
