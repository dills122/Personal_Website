<link rel="stylesheet" type="text/css" href="main.css"/>
<html>



<script type="text/javascript" src="http://static.fusioncharts.com/code/latest/fusioncharts.js"></script>
<script type="text/javascript" src="http://static.fusioncharts.com/code/latest/themes/fusioncharts.theme.fint.js?cacheBust=56"></script>
<script type="text/javascript">
  FusionCharts.ready(function(){
    var fusioncharts = new FusionCharts({
    type: 'mscolumn2d',
    renderAt: 'chart-container',
    width: '550',
    height: '400',
    dataFormat: 'json',
    dataSource: {
        "chart": {
            "caption": "Principle vs. Interest Paid",
            "xAxisname": "Years",
            "yAxisName": "Revenues (In USD)",
            "numberPrefix": "$",
            "plotFillAlpha": "80",

            //Cosmetics
            "paletteColors": "#0075c2,#1aaf5d",
            "baseFontColor": "#333333",
            "baseFont": "Helvetica Neue,Arial",
            "captionFontSize": "14",
            "subcaptionFontSize": "14",
            "subcaptionFontBold": "0",
            "showBorder": "0",
            "bgColor": "#ffffff",
            "showShadow": "0",
            "canvasBgColor": "#ffffff",
            "canvasBorderAlpha": "0",
            "divlineAlpha": "100",
            "divlineColor": "#999999",
            "divlineThickness": "1",
            "divLineIsDashed": "1",
            "divLineDashLen": "1",
            "divLineGapLen": "1",
            "usePlotGradientColor": "0",
            "showplotborder": "0",
            "valueFontColor": "#ffffff",
            "placeValuesInside": "1",
            "showHoverEffect": "1",
            "rotateValues": "1",
            "showXAxisLine": "1",
            "xAxisLineThickness": "1",
            "xAxisLineColor": "#999999",
            "showAlternateHGridColor": "0",
            "legendBgAlpha": "0",
            "legendBorderAlpha": "0",
            "legendShadow": "0",
            "legendItemFontSize": "10",
            "legendItemFontColor": "#666666"
        },
        "categories": [{
            "category": [
				<?php
$QueryStr = $_SERVER['QUERY_STRING'];

$SplitArry = explode('&', $QueryStr);
$Term =  substr($SplitArry[2], strpos($SplitArry[2], "=") + 1);

for ($x = 1; $x <= $Term; $x++) {
	echo "{\"label\": \"" . $x . " Year \"},";
}

  ?>
			]
        }],
        "dataset": [ 
			<?php 

$QueryStr = $_SERVER['QUERY_STRING'];

$SplitArry = explode('&', $QueryStr);

//This is the function i need to split and get the value
$Price =  substr($SplitArry[0], strpos($SplitArry[0], "=") + 1);
$Down =  substr($SplitArry[1], strpos($SplitArry[1], "=") + 1);
$Term =  substr($SplitArry[2], strpos($SplitArry[2], "=") + 1);
$Interest =  substr($SplitArry[3], strpos($SplitArry[3], "=") + 1);


    $MonthlyInt = $Interest/12;
	
	
	//Monthly Payment calculations
	$P = $Price - $Down;
    $i = $MonthlyInt;
    $n = $Term * 12;
    $power = pow((1 + $i), $n);
    //Monthly Payment
    $A = $P * (($i  * $power)/($power - 1));

$InterestPaid = 0;
    $PrinciplePaid = 0;
    $CurrBal = 0;
    $MonthlyPayment = $A;
    $TotalInt = 0;

	$YearlyInterest = 0;
	$YearlyPrinciple = 0;
	$PrincipleStr = "{\"seriesname\": \"Principle Paid\", \"data\": [";
	$InterestStr = "{\"seriesname\": \"Interest Paid\", \"data\": [";
	$counter = 0;
	for ($x = 0; $x < $n; $x++) {
		
		if ($x == 0) {
            $CurrBal = $Price;
            
        }

		$PrinciplePaid = $MonthlyPayment - ($CurrBal * $MonthlyInt);
		$InterestPaid = $MonthlyPayment - $PrinciplePaid;
		$CurrBal = $CurrBal - $PrinciplePaid;
		$TotalInt = $TotalInt + $InterestPaid;

		
		$YearlyInterest = $YearlyInterest + $InterestPaid;
		$YearlyPrinciple = $YearlyPrinciple + $PrinciplePaid;

		
		if ($counter == 10) {

			$PrincipleStr = $PrincipleStr . "{\"value\":\"" . number_format($YearlyPrinciple, 2, '.', '') . "\"},";

			$InterestStr = $InterestStr . "{\"value\":\"" . number_format($YearlyInterest, 2, '.', '') . "\"},";

			$YearlyInterest = 0;
			$YearlyPrinciple = 0;
			$counter = 0;
		}
		$counter++;
	}

$PrincipleStr = $PrincipleStr . "]},";
$InterestStr = $InterestStr . "]},";
echo $PrincipleStr . ' ' . $InterestStr;
?>]
    }
    
});
    fusioncharts.render();


    var fusion = new FusionCharts({
    type: 'pie2d',
    renderAt: 'pie-container',
    width: '550',
    height: '400',
    dataFormat: 'json',
    dataSource: {
        "chart": {
            "caption": "Interest v. Principle",
            "subCaption": "",
            "numberPrefix": "$",
            "showPercentInTooltip": "0",
            "decimals": "1",
            "useDataPlotColorForLabels": "1",
            //Theme
            "theme": "fint"
        },
        "data": [
            <?php 

$QueryStr = $_SERVER['QUERY_STRING'];

$SplitArry = explode('&', $QueryStr);

//This is the function i need to split and get the value
$Price =  substr($SplitArry[0], strpos($SplitArry[0], "=") + 1);
$Down =  substr($SplitArry[1], strpos($SplitArry[1], "=") + 1);
$Term =  substr($SplitArry[2], strpos($SplitArry[2], "=") + 1);
$Interest =  substr($SplitArry[3], strpos($SplitArry[3], "=") + 1);


    $MonthlyInt = $Interest/12;
	
	
	//Monthly Payment calculations
	$P = $Price - $Down;
    $i = $MonthlyInt;
    $n = $Term * 12;
    $power = pow((1 + $i), $n);
    //Monthly Payment
    $A = $P * (($i  * $power)/($power - 1));

$InterestPaid = 0;
    $PrinciplePaid = 0;
    $CurrBal = 0;
    $MonthlyPayment = $A;
    $TotalInt = 0;

	$YearlyInterest = 0;
	$YearlyPrinciple = 0;

	for ($x = 0; $x < $n; $x++) {
		
		if ($x == 0) {
            $CurrBal = $Price;
            
        }

		$PrinciplePaid = $MonthlyPayment - ($CurrBal * $MonthlyInt);
		$InterestPaid = $MonthlyPayment - $PrinciplePaid;
		$CurrBal = $CurrBal - $PrinciplePaid;
		$TotalInt = $TotalInt + $InterestPaid;
		
		$YearlyInterest = $YearlyInterest + $InterestPaid;
		$YearlyPrinciple = $YearlyPrinciple + $PrinciplePaid;

	}


echo "{\"label\": \"Principle Paid \", \"value\":\"" . $YearlyPrinciple . "\"}," .  "{\"label\": \"Interest Paid \", \"value\":\"" . $YearlyInterest . "\"}";
?>
        ]
    }
});
    fusion.render();
});
</script>
  

<head>
    <title>Amortization Breakdown</title>
    <link rel="stylesheet" type="text/css" href="main.css"/> <script src="valid.js"></script></head>

<body>
<br/>
<br/>
<div style="width:100%; margin: auto;">
<div id="chart-container" style=" float: left; margin-left: 200px">FusionCharts XT will load here!</div>
<div id="pie-container" style=" float: right; margin-right: 200px">FusionCharts XT will load here!</div>
</div>
<br/>
<br/>
<?php

$QueryStr = $_SERVER['QUERY_STRING'];

$SplitArry = explode('&', $QueryStr);

//This is the function i need to split and get the value
$Price =  substr($SplitArry[0], strpos($SplitArry[0], "=") + 1);
$Down =  substr($SplitArry[1], strpos($SplitArry[1], "=") + 1);
$Term =  substr($SplitArry[2], strpos($SplitArry[2], "=") + 1);
$Interest =  substr($SplitArry[3], strpos($SplitArry[3], "=") + 1);


    $MonthlyInt = $Interest/12;
	
	
	//Monthly Payment calculations
	$P = $Price - $Down;
    $i = $MonthlyInt;
    $n = $Term * 12;
    $power = pow((1 + $i), $n);
    //Monthly Payment
    $A = $P * (($i  * $power)/($power - 1));
	
	
	
	
	echo "<table class=\"mortTable\">";
	
	echo "<tr><th>Payment</th><th>Payment Amount</th><th>Balance</th><th>Balance After Payment</th><th>Interest Paid</th><th>Principle Paid</th></tr>";
	
    $InterestPaid = 0;
    $PrinciplePaid = 0;
    $CurrBal = 0;
    $MonthlyPayment = $A;
    $TotalInt = 0;

	for ($x = 0; $x < $n; $x++) {
		
		if ($x == 0) {
            $CurrBal = $P;
            
        }
		$PrinciplePaid = $MonthlyPayment - ($CurrBal * $MonthlyInt);
		$InterestPaid = $MonthlyPayment - $PrinciplePaid;
		$CurrBal = $CurrBal - $PrinciplePaid;
		$TotalInt = $TotalInt + $InterestPaid;
		
		echo "<tr><td>" . ($x +1) . "</td>" . "<td>" . number_format($MonthlyPayment,2) . "</td>" . "<td>" . number_format(($CurrBal + $PrinciplePaid),2) . "</td><td>" . number_format($CurrBal, 2) . "</td><td>" .  number_format($InterestPaid, 2) .  "</td><td>" .  number_format($PrinciplePaid, 2) . "</td><td>" . "</tr>";  
		
		
	}
	echo "</table>";
	


?>
</body>

</html>