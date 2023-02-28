Param([string]$num = $(Read-Host))


Write-Host Decimal number: $num


try {
    [double]$num = $num     
}
catch{
    Write-Host Number is wrong
    return
}


$sign=""
if ($num -lt 0){
    $num = -1 * $num
    $sign="-"
}
$dec = [math]::Truncate($num)


$resd = ""


# Перевод целой части
while($dec -ne 0){
    [string]$ost = $dec % 8
    $resd = $ost + $resd
    $dec = [math]::Truncate($dec / 8)
}


if ($resd -eq ""){
    $resd = "0"
}


#Если число с дробной частью
if([int]$num -ne [double]$num){
    $frac = $num - [math]::Truncate($num)
    $resf = ""


    [int]$i = 0
    [string]$num = $num
    #Точность
    do{
        $i = $i + 1
    }while($num[$i-1] -ne ".")
    [int]$len = $num.Length - $i
    $n = [math]::Pow(10, $len)
    $x = 1
    while ([math]::Pow(8, $x) -lt $n){
        $x = $x + 1
    }
    #Перевод дробной части
    for ($i = 0; $i -lt $x; $i++){
        if ($frac -eq 0){
            break
        }
        $frac *=8
        [string]$foo = [math]::Truncate($frac)
        [string]$resf = $resf + $foo
        if ($frac -ge 1.0){
            $frac -= 1.0 
        }
    }
    Write-Host Octal number: $sign$resd'.'$resf
}
else{
    Write-Host Octal number: $sign$resd
} 
