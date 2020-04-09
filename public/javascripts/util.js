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

function yesnoCheck(that) {
  if (that.value == "new category") {
      document.getElementById("ifYes").style.display = "block";
      document.getElementById("create category").name = "category_name";
  } else {
      document.getElementById("ifYes").style.display = "none";
      document.getElementById("create category").name = "no_name";
  }
}

