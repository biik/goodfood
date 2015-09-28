/**
 * Name: javascript.js
 */
/*
document.getElementById("registration").onclick = function () {
        location.href = "www.yoursite.com";
};
*/
function SetValue(controls) {
	for (var key in controls) {
		document.getElementById(key).value = controls[key];
	}
}

function SetRadioChecked(gender) {
	document.getElementById(gender).checked = true;
}

function getXMLHttpRequestObject()
{
	if (window.XMLHttpRequest) { // code for IE7+, Firefox, Chrome, Opera, Safari
		return(new XMLHttpRequest());
	} else if (window.ActiveXObject) { // code for IE6, IE5
		return(new ActiveXObject("Microsoft.XMLHTTP"));
	} else {
		return(null);
	}
}

function ajaxAddToCart(pkIdItem) {
	var address="CartAdd";
	var xmlhttpRequest = getXMLHttpRequestObject();
	xmlhttpRequest.open("POST", address, true);
	xmlhttpRequest.onreadystatechange = function() { showResponse(xmlhttpRequest, "s"); };
	xmlhttpRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttpRequest.send("idi="+pkIdItem+"&op=s");
}

function ajaxRemoveFromCart(pkIdItem) {
	var address="CartAdd";
	var xmlhttpRequest = getXMLHttpRequestObject();
	xmlhttpRequest.open("POST", address, true);
	xmlhttpRequest.onreadystatechange = function() { showResponse(xmlhttpRequest, "r"); };
	xmlhttpRequest.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttpRequest.send("idi="+pkIdItem+"&op=r");
}

function showResponse(xmlhttpRequest, op) {
	if ((xmlhttpRequest.readyState == 4) && (xmlhttpRequest.status == 200)) {
		if(xmlhttpRequest.responseText.substr(0,1) == "y") {
			var i;
			
			var idi = xmlhttpRequest.responseText.substr(1);
			for (i = 0; i < items.length; i++) {
				if(items[i][0] == idi)
					break;
			}
			if(op == "s") {
				if(i == items.length) {
					items.push([idi, 1]);
					AddToCartTable(idi, 1);
				}
				else {
					items[i][1]++;
					UpdateToCartTable(idi, items[i][1]);
				}
			} else if(op == "r") {
				if(i == items.length) {
					
				} else if(items[i][1] > 1) {
					items[i][1]--;
					UpdateToCartTable(idi, items[i][1]);
				} else {
					items.splice(i, 1);
					RemoveFromTable(idi);
				}
			}
		}
	}
}

function TotalPrice() {
	var count = 0;
	var shippingCost = 20;
	
	for (var i = 0; i < items.length; i++) {
		count += document.getElementById("itemprice"+items[i][0]).innerHTML*items[i][1];
	}
	
	return count + shippingCost;
}

function UpdateToCartTable(idi, count) {
	document.getElementById("itemcount"+idi).innerHTML = count;
	document.getElementById("totalprice").innerHTML = TotalPrice();
}

function AddToCartTable(idi, count) {
	var table = document.getElementById("orders");
	var rowCount = table.rows.length;
	var row = table.insertRow(rowCount);
	var cell1 = row.insertCell(0);
    var cell2 = row.insertCell(1);
    var cell3 = row.insertCell(2);
    var cell4 = row.insertCell(3);
    var cell5 = row.insertCell(4);
    cell1.innerHTML = rowCount + ") "; // No
    cell2.innerHTML = document.getElementById("itemname"+idi).innerHTML; // Name
    cell3.innerHTML = document.getElementById("itemprice"+idi).innerHTML; // Price
    cell4.innerHTML = "<span id='itemcount"+ idi +"'>"+count+"</span>"; // Count
    cell5.innerHTML = "<img alt=\"Increase\" onclick=\"ajaxAddToCart("+idi+")\" src=\"images/plus.png\" /><img alt=\"Decrease\" onclick=\"ajaxRemoveFromCart("+idi+")\" src=\"images/minus.png\" />";
    document.getElementById("totalprice").innerHTML = TotalPrice();
}

function RemoveFromTable(idi) {
	var i = document.getElementById("itemcount"+ idi).parentNode.parentNode.rowIndex;
	document.getElementById("orders").deleteRow(i);
	document.getElementById("totalprice").innerHTML = TotalPrice();
}

function ordering() {
	var minPrice = 50;
	
	if(TotalPrice() < minPrice)
		alert("Minimum order " + minPrice + " \u20AA");
	else
		location.href='Ordering';
}