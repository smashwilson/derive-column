# About regular expressions:
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_regular_expressions?view=powershell-6
#
# -replace operator:
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-6#replacement-operator


# Append a derived column to an existing CSV file, then write it to a new CSV file.
function Get-DerivedColumn {
    Param (
        [Parameter(Mandatory = $true)][String] $InCSV,
        [Parameter(Mandatory = $true)][String] $InField,
        [Parameter(Mandatory = $true)][String] $OutCSV,
        [Parameter(Mandatory = $true)][String] $OutField,
        [Parameter(Mandatory = $true)][String] $Pattern,
        [Parameter(Mandatory = $true)][String] $Replacement
    )

    $table = Import-Csv -Path $InCSV

    for ($row = 0; $row -lt $table.Count; $row++) {
        $newEntry = ($table[$row] | Select-Object -ExpandProperty $InField) -replace $Pattern, $Replacement
        $table[$row] | Add-Member -Name $OutField -MemberType NoteProperty -Value $newEntry
    }

    $table | Export-Csv -NoTypeInformation -Path $OutCSV
}