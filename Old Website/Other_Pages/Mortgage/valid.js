function calcTerm() {

    var YearlyTerm = document.getElementById('MortTerm').value;
    if (YearlyTerm == 0) {
        document.getElementById('MortTermMonths').value = null;
    } else {
        var Month = YearlyTerm * 12;
        document.getElementById('MortTermMonths').value = Month;
    }

}

function calcLoan() {

    var HomePrice = document.getElementById('HomePrice').value;
    var DownPayment = document.getElementById('DownPay').value;
    if (HomePrice != '' || HomePrice != null || HomePrice != 0 ) {
        if (DownPayment == 0) {
            document.getElementById('LoanAmount').value = HomePrice;
        } else {
            var adjusted = HomePrice - DownPayment;
            document.getElementById('LoanAmount').value = adjusted;
        }
    }
}

function isNumberKey(evt) {
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode != 46 && charCode > 31
        && (charCode < 48 || charCode > 57))
        return false;

    return true;
}

function OpenPage() {
    var Cost = document.getElementById('HomePrice').value;
    var DownPayment = document.getElementById('DownPay').value; 
    var Term = document.getElementById('MortTerm').value;
    var Interest = document.getElementById('AnnInter').value; 
    Interest = Interest/100;

    var URL = "\main.php" + "?Cost=" + Cost + "&DownPayment=" + DownPayment + "&Term=" + Term + "&Interest=" + Interest;

    window.open(URL);

}