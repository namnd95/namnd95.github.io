function get_tram_timbus(id){
	var url = "http://timbus.vn/Engine/Business/Vehicle/action.ashx"
	$.ajax({
        url: url,
        type: "post",
        dataType: "json",
        data: {
            act: 'partremained',
            State: false,
            StationId: id,
			FleetOver: ""
        },		
        success: function(res) {
            if (res.st == true) {
                tram = decode_from_timbus(res.dt);
                console.log(tram);
            }
			else 
				console.log('not found');
        },
        error: function() {
			console.log("error");
		}
    });
}