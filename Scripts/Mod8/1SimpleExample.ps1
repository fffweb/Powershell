Function set-stuff{
    [cmdletbinding(SupportsShouldProcess=$true,
                    confirmImpact='Medium')]
    param(
        [Parameter(Mandatory=$True)]
        [string]$computername   
    )
    Process{
    # should try -verbose and -confirm
        If ($psCmdlet.shouldProcess("$Computername","Mess it up seriously!")){
            Write-Output 'Im changing something right now'
        }
    }
}
