# SetProfilePic.ps1
Add-Type -AssemblyName System.Windows.Forms

function Show-Message($text, $title, $icon) {
    [System.Windows.Forms.MessageBox]::Show($text, $title, [System.Windows.Forms.MessageBoxButtons]::OK, $icon)
}

$images = @(
    "https://example.com/image1.jpg",
    "https://example.com/image2.jpg",
    "https://example.com/image3.jpg"
)

try {
    $url = $images | Get-Random
    $tmp = "$env:TEMP\pfp_$(Get-Random).jpg"

    Invoke-WebRequest -Uri $url -OutFile $tmp -ErrorAction Stop

    Add-Type -AssemblyName System.Runtime.WindowsRuntime
    $null = [Windows.System.UserProfile.UserInformation,Windows.System.UserProfile,ContentType=WindowsRuntime]

    $file = [Windows.Storage.StorageFile]::GetFileFromPathAsync($tmp).GetAwaiter().GetResult()
    [Windows.System.UserProfile.UserInformation]::SetAccountPictureAsync($file).GetAwaiter().GetResult()

    Remove-Item $tmp

    Show-Message "Profile picture updated successfully!" "Success" ([System.Windows.Forms.MessageBoxIcon]::Information)
}
catch {
    Show-Message "Failed to update profile picture:`n$($_.Exception.Message)" "Error" ([System.Windows.Forms.MessageBoxIcon]::Error)
}
