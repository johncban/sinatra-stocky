function calculate() {
    var mB1 = document.getElementById('qty').value; 
    var mB2 = document.getElementById('prc').value;
    var total = document.getElementById('total'); 
    var myResult = mB1 * mB2;
      document.getElementById('total').value = myResult;
}

function clearfield() {
  window.location.reload(true);
  document.getElementById('prc').value = "";
}


