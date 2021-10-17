<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head><link rel="stylesheet" href="../../css/admin_in.css">
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
	google.charts.load('current', {
		'packages' : [ 'bar' ]
	});
	//google.charts.setOnLoadCallback(drawChart);

	//===================================== FUNCIONES PROPIAS =============================

	function consultar(t) {
		if (t==1){
			var tipo = "cliente";
		} else if (t==0){
			var tipo = "producto";
		}
		var http = new XMLHttpRequest();
		var url = '/TiendaVirtualGrupo02Ecoshop/consultarVentas';
		var params = "tipo=" + tipo;
		http.open('POST', url, true);

		//Send the proper header information along with the request
		http.setRequestHeader('Content-type',
				'application/x-www-form-urlencoded');

		http.onreadystatechange = function() {//Call a function when the state changes.
			if (http.readyState == 4 && http.status == 200) {

				//alert(http.responseText);
				//CreateTableFromJSON(http.responseText);

				var datos = http.responseText;
				datos = datos.replace('[', '').replace(']', '');
				var tokens = datos.split(',');
				var tabla = [];
				tabla.push(["Item","Total"]);
				for (var i = 0; i < tokens.length; i++) {
					var tokens2 = tokens[i].split(';');
					var reg=[];
					reg.push(tokens2[0].replace('"',''));
					reg.push(parseInt(tokens2[1].replace('"','')));
					tabla.push(reg);
				}
				drawChart(tabla);
			}
		}
		http.send(params);
	}

	// ======================================= FIN DE FUNCIONES PROPIAS ===============================================

	function drawChart(tabla) {
		
		var data = google.visualization.arrayToDataTable(tabla);
		
		var options = {
			chart : {
				title : 'Reporte de ventas de ropa 2021',
				subtitle : 'Tienda EcoShop Store Grupo 02',
			},
			bars : 'horizontal' // Required for Material Bar Charts.
		};

		var chart = new google.charts.Bar(document
				.getElementById('barchart_material'));

		chart.draw(data, google.charts.Bar.convertOptions(options));
	}
</script>
</head>
<body>
	<button onclick="consultar(0)">Consultar por producto</button>
	<br>
	<button onclick="consultar(1)">Consultar por cliente</button>
	<br>
	<a class="back" href="../../admin.html">Atras</a>
	<br>
	<br>
	<div id="barchart_material" style="width: 900px; height: 500px;"></div>
	<br>
	<br>
	
</body>
</html>