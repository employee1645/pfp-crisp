Add-Type -AssemblyName System.Windows.Forms

function Show-Message($text, $title, $icon) {
    [System.Windows.Forms.MessageBox]::Show($text, $title, [System.Windows.Forms.MessageBoxButtons]::OK, $icon)
}

$images = @(
    "https://picsum.photos/400"
)

try {
    $url = $images | Get-Random
    $tmp = "$env:TEMP\pfp_$(Get-Random).jpg"

    Invoke-WebRequest -Uri $url -OutFile $tmp -ErrorAction Stop

    $dest = "$env:PUBLIC\AccountPictures\$env:USERNAME.jpg"
    if (!(Test-Path (Split-Path $dest))) {
        New-Item -ItemType Directory -Path (Split-Path $dest) | Out-Null
    }

    Copy-Item $tmp $dest -Force

    rundll32.exe "C:\Windows\system32\shimgvw.dll,ImageView_Fullscreen" $dest

    Remove-Item $tmp

    Show-Message "Profile picture updated! You may need to sign out and back in." "Success" ([System.Windows.Forms.MessageBoxIcon]::Information)
}
catch {
    Show-Message "Error at line $($_.InvocationInfo.ScriptLineNumber):`n$($_.Exception.Message)" "Error" ([System.Windows.Forms.MessageBoxIcon]::Error)
}
