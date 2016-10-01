
function get_tram_timbus(id, callback){	
	var url = "http://localhost:8000/timbus/Engine/Business/Vehicle/action.ashx";			
  console.log(id);
	//*
  $.ajax({
		url: url,
		type: "post",
		dataType: "json",
		data: {
			act: 'partremained',
			State: 'false',
			StationId: id,
			FleetOver: ""
		},		
		success: function(res) {
			if (res.st == true) {
				data = decode_from_timbus(res.dt);	
        callback(data);
			}
		else 
			console.log('not found');
		},
		error: function() {
			console.log("error");
		},		
	});
	//*/
}

//get_tram_timbus(759);