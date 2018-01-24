function get-latency( $x ) 
{
    $x.Results.TimeSpan.Latency.Bucket | Foreach-Object {
        $_.Percentile,$_.ReadMilliseconds,$_.WriteMilliseconds -join "`t"
    }
}

function New-DiskSpdAnalysis
{
    [CmdLetBinding()]
    Param(
        [string]$Path
        ,
        [string]$OutputPath
    )

    $l = @(); foreach ($i in 25,50,75,90,95,99,99.9,100) { $l += ,[string]$i }
    
    $reportFiles = Get-ChildItem -Path $Path -Filter *.xml
    
    $analysis = $reportFiles | ForEach-Object {

        $x = [xml](Get-Content $_.FullName)
        #$lf = $_.fullname -replace '.xml','.lat.tsv'
        $lf = $_.fullname.Replace('.xml','.lat.tsv');
        if (-not [io.file]::Exists($lf)) {
            get-latency $x > $lf
        }
        $system = $x.Results.System.ComputerName
        $t = $x.Results.TimeSpan.TestTimeSeconds
        # extract the subset of latency percentiles as specified above in $l
        $h = @{}; $x.Results.TimeSpan.Latency.Bucket |% { $h[$_.Percentile] = $_ }
        $ls = $l |% {
            $b = $h[$_];
            if ($b.ReadMilliseconds) { $b.ReadMilliseconds } else { "" }
            if ($b.WriteMilliseconds) { $b.WriteMilliseconds } else { "" }
        }
        # sum read and write iops across all threads and targets
        $ri = ($x.Results.TimeSpan.Thread.Target | Measure-Object -sum -Property ReadCount).Sum
        $wi = ($x.Results.TimeSpan.Thread.Target | Measure-Object -sum -Property WriteCount).Sum
        $rb = ($x.Results.TimeSpan.Thread.Target | Measure-Object -sum -Property ReadBytes).Sum
        $wb = ($x.Results.TimeSpan.Thread.Target | Measure-Object -sum -Property WriteBytes).Sum
    
        # output tab-separated fields. note that with runs specified on the command
        # line, only a single write ratio, outstanding request count and blocksize
        # can be specified, so sampling the one used for the first thread is
        # sufficient.
        (($system,
        ($x.Results.Profile.TimeSpans.TimeSpan.Targets.Target.WriteRatio |
        Select-Object -first 1),
        $x.Results.TimeSpan.ThreadCount,
        ($x.Results.Profile.TimeSpans.TimeSpan.Targets.Target.RequestCount |
        Select-Object -first 1),
        ($x.Results.Profile.TimeSpans.TimeSpan.Targets.Target.BlockSize |
        Select-Object -first 1),
        # calculate iops
        ($ri / $t),
        ($rb / $t),
        ($wi / $t),
        ($wb / $t)) -join "`t"),
        ($ls -join "`t") -join "`t"
    }
    
        
    $analysis | Out-File (Join-Path -Path $OutputPath -ChildPath result.tsv) -Encoding ascii -Width 9999 

}

New-DiskSpdAnalysis -Path .\XmlResults -OutputPath .

