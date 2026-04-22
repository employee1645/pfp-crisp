Add-Type -AssemblyName System.Windows.Forms

function Show-Message($text, $title, $icon) {
    [System.Windows.Forms.MessageBox]::Show($text, $title, [System.Windows.Forms.MessageBoxButtons]::OK, $icon)
}

$images = @(
    "https://i.pinimg.com/1200x/cb/1b/8b/cb1b8b960e4e59d669d03404d7daa31b.jpg",
    "https://i.pinimg.com/736x/92/4c/1c/924c1c5e58674241fa061aa356021c56.jpg",
    "https://i.pinimg.com/736x/c2/a3/f7/c2a3f762ba74b4bc3fec85cfaecc6e4f.jpg",
    "https://i.pinimg.com/736x/dd/c4/4f/ddc44f278d40955f73b007ef788ed7f6.jpg",
    "https://i.pinimg.com/736x/9d/0a/87/9d0a87fc480a8c12ea452608ec28aa81.jpg",
    "https://i.pinimg.com/736x/06/e9/06/06e9069001ab27adf947175fb02b863e.jpg",
    "https://i.pinimg.com/736x/d9/71/35/d9713540ff3cb3919d443b85957c4bf1.jpg",
    "https://i.pinimg.com/736x/f9/34/63/f934633e93fdee98dc4426736a5cccbc.jpg",
    "https://i.pinimg.com/736x/c5/7e/c7/c57ec79d8dd095185329a82b692031e5.jpg"
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
    Remove-Item $tmp

    Show-Message "Profile picture updated! Sign out and back in to see it." "Success" ([System.Windows.Forms.MessageBoxIcon]::Information)
}
catch {
    Show-Message "Error at line $($_.InvocationInfo.ScriptLineNumber):`n$($_.Exception.Message)" "Error" ([System.Windows.Forms.MessageBoxIcon]::Error)
}
