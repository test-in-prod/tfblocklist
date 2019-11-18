#!/usr/bin/pwsh

$ListUrl = "https://www.spamhaus.org/drop/drop.txt"

$ListRequest = Invoke-WebRequest -Uri $ListUrl -Method Get

$ListContent = New-Object System.IO.StringReader -ArgumentList $ListRequest.Content

$List = New-Object System.Collections.ArrayList

while($null -ne ($line = $ListContent.ReadLine())) {
    if($line.TrimStart().StartsWith(";")) {
        continue # comment
    }

    $match = $line | Select-String -Pattern "\b(([2]([0-4][0-9]|[5][0-5])|[0-1]?[0-9]?[0-9])[.]){3}(([2]([0-4][0-9]|[5][0-5])|[0-1]?[0-9]?[0-9]))\b\/\b([0-9]|[12][0-9]|3[0-2])\b"

    if($match.Matches.Count -gt 0) {
        $ip = $match.Matches[0].Value
        $List.Add($ip) | Out-Null
    }
}

$Formatted = [string]::Join(",", $List.ToArray())

$Result = @{
    List = $Formatted
}
$Result | ConvertTo-Json

