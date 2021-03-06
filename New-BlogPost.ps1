    [CmdletBinding()]
    param (
        # Name
        [Parameter(Mandatory)]
        [string]
        $Name, 
        # Date
        [Parameter()]
        [String]
        $Date = (Get-Date -Format yyyy-M-d),
        # auther
        [Parameter()]
        [string]
        $Auther = "Tom",
        # Categories
        [Parameter()]
        [String[]]
        $Categories = "general",
        # content
        [Parameter()]
        [string]
        $Content,
        # Path 
        [Parameter()]
        [string]
        $Path = ".\_posts",
        # OpenInCode
        [Parameter()]
        [switch]
        $OpenWithCode
    )
    
    begin {
        if ((Test-Path -Path $Path) -eq $false) {
            Write-Error -Message "Can not find $path"
            break
        }
    }
    
    process {
        $Date = $Date | Get-Date -Format "yyyy-M-d"
        $FileName = "$($date.ToString())-$($name.Replace(" ","-")).md"

        $Blog = New-Object -TypeName "System.Text.StringBuilder"
        [void]$Blog.Append("---`n") 
        [void]$Blog.Append("layout: post`n")
        [void]$Blog.Append("title: $Name`n") 
        [void]$Blog.Append("date: $Date`n")
        [void]$Blog.Append("auther: $Auther`n")
        [void]$Blog.Append("categories:`n")
        ForEach ($item in $categories){
            $item = $item.tolower()
            [void]$Blog.Append("    - `"$item`"`n")
        }
        [void]$Blog.Append("---`n") 
        [void]$Blog.Append($Content)
        $Blog = $Blog.toString()

        $NewBlogPath = Join-Path -ChildPath $FileName -Path $Path

        Set-Content -Value $Blog -Path $NewBlogPath
        Write-Output (Get-ChildItem $NewBlogPath)

        if ($OpenWithCode) {
            code $NewBlogPath
        }
    }
    
    end {
    }
