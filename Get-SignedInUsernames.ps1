# First, you should load all computer names you want into a variable $Computers
foreach ($Computer in $Computers) {
	if (Test-Connection -BufferSize 32 -Count 1 -ComputerName $Computer -Quiet) {
		Write-Host "$Computer is online." -ForegroundColor 'Green'
		$SignInCheck = quser /Server:"$Computer" 2>$null # 2>$null supresses error output
		if ($SignInCheck) {
			$UserNames = $SignInCheck[1..($SignInCheck.count -1)] | foreach {
				$_ -replace '^ (\S+) .*','$1' -replace 'username' # Return just the signed in usernames.
			}
			# Now you have an array of signed in $UserNames on $Computer
			# Do something with them here before the next computer loop runs
		}
		else {
			Write-Host "No users are signed into $Computer." -ForegroundColor 'Yellow'
	 	}
	}
	else {
		Write-Host "Can't reach $Computer, it might offline." -ForegroundColor 'Red'
	}
}
