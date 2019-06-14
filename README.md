# Get-DerivedColumn

PowerShell function useful for regular-expression based manipulation of columns in CSV files.

## Installation

If your machine's `Get-ExecutionPolicy` is set to something suitably permissive, you can clone this repository, source the `derive-column.ps1` script, and call the `Get-DerivedColumn` function.

```ps
git clone git@github.com:smashwilson/derive-column.git
cd derive-column
. .\derive-column.ps1

Get-DerivedColumn
```

Otherwise, you can always copy and paste the [raw view](https://raw.githubusercontent.com/smashwilson/derive-column/master/derive-column.ps1) of the `derive-column.ps1` file from this repo into an open terminal and call the function that way.

## Usage

Once the function is defined, call it with the following parameters:

```ps
Get-DerivedColumn
    -InCSV .\in.csv
    -InField "Column Two"
    -OutCSV .\out.csv
    -OutField "Modified"
    -Pattern '.*(\d\d)\d.*'
    -Replacement 'just $1'
```

This will:

- Read a `.csv` file at the path given as `-InCSV`.
- Apply the regular expression specified as `-Pattern` to the chosen `-InField` of each row.
- Generate a new column for that row called `-OutField` whose contents are derived from the `-Replacement` text. Groups from the regexp are available as `$1`, `$2`, and so on, but _make sure that you use single quotes around the replacement string_ or PowerShell will try to interpolate them as variables before calling the function.
- Write a new `.csv` file to the path given to `-OutCSV`. This will contain the complete original `.csv` file with the derived `-OutField` as an appended column.

For example, given this CSV input in a file called `in.csv` in the current directory:

```csv
"Column One","Column Two","Column Three"
"aaa000","aaa111","aaa222"
"bbb000","bbb111","bbb222"
```

The command above will produce a file called `out.csv` with the following contents:

```csv
"Column One","Column Two","Column Three","Modified"
"aaa000","aaa111","aaa222","just 11"
"bbb000","bbb111","bbb222","just 11"
```
