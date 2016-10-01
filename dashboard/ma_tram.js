function add_tram(ds_tram, ds, callback){
  for(var i = 0; i < ds.length; ++i){
    var obj = ds[i];
    //console.log(obj);
    ds_tram[obj.ObjectID] = obj;
  }
  callback();
}

function get_tram_tren_duong_timbus(ds_tram, id, callback){
  var url = "http://localhost:8000/timbus/Engine/Business/Search/action.ashx";			 		
	//*
  $.ajax({
		url: url,
		type: "post",
		dataType: "json",
		data: {
			act: 'fleetdetail',
			fid: id
		},		
		success: function(res) {
			if (res.st == true) {
				dt = decode_from_timbus(res.dt);
        add_tram(ds_tram, dt.Go.Station, callback);
        add_tram(ds_tram, dt.Re.Station, callback)
        return dt;
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

function khoi_tao_tram_tren_duong_timbus(){
  ds_tram = {};
  tuyen = [22, 35, 50, 51];  
  var cnt = 0;
  for(var i = 0; i < tuyen.length; ++i)
    get_tram_tren_duong_timbus(ds_tram, tuyen[i], function(e){
      cnt++;
      if (cnt == tuyen.length){
        str = JSON.stringify(ds_tram);
        $("#text").html(str);
      }
    });  
}

function get_ds_tram(callback){
  var url = "data_tram.json";
  $.getJSON("data_tram.json",{}, function( res ){      
			callback(res)
  });		  
}