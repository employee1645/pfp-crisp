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

    $accountPicPath = "$env:APPDATA\Microsoft\Windows\AccountPictures"
    if (!(Test-Path $accountPicPath)) {
        New-Item -ItemType Directory -Path $accountPicPath | Out-Null
    }

    Copy-Item $tmp "$accountPicPath\UserAccountPicture.jpg" -Force

    # Set registry to point to new picture
    $regPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AccountPicture"
    Set-ItemProperty -Path $regPath -Name "UserAccountPicture" -Value "$accountPicPath\UserAccountPicture.jpg"

    Remove-Item $tmp

    Show-Message "Profile picture updated successfully!" "Success" ([System.Windows.Forms.MessageBoxIcon]::Information)
}
catch {
    Show-Message "Failed to update profile picture:`n$($_.Exception.Message)" "Error" ([System.Windows.Forms.MessageBoxIcon]::Error)
}
