function Convert-StringToASCIIChars {
    <#
    .SYNOPSIS
    Convert cryptic files containing unfriendly characters to raw string output.
    
    .DESCRIPTION
    
    
    .PARAMETER Path
    Path to the file.
    
    .EXAMPLE
    Convert-StringToASCIIChars -Path Test.txt
    
    .NOTES
    Assumes that anything alphanumeric, punctuation, carriage returns, line feeds, and tabs are good.
    
    Contact information:
    https://github.com/BradyDonovan
    #>
    
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [ValidateScript ( { IF(Test-Path $_) {$true} ELSE {throw "Valid file not specified or access denied."} } )]
        [string]$Path
    )
    Try {
        $content = Get-Content $Path -raw
    
        # convert content to an array, for each char convert to raw ASCII value if alphanumeric, punctuation, CR, LF, or tab, then convert back to char
        $convertString = $content.ToCharArray() | ForEach-Object {
            $asciiIndex = [int][char]$_
            IF (((32..127) -contains $asciiIndex) -or (@(13, 10) -contains $asciiIndex) -or ($asciiIndex -eq 9)) {
                [char][int]$asciiIndex
            }
        }
        
        return [String]::new($convertString)
    }
    Catch {
        throw "$_"
    }
}
