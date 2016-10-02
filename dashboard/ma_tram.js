function add_tram(ds_ss, ds, callback){
  for(var i = 0; i < ds.length; ++i){
    var obj = ds[i];
    //console.log(obj);
    ds_ss[obj.ObjectID] = obj;
  }
  callback();
}

function get_tram_tren_duong_timbus(ds_ss, id, callback){
  //var url = "http://localhost:8000/timbus/Engine/Business/Search/action.ashx";			 		
  var url = "http://net12k44.herokuapp.com/timbus/Engine/Business/Search/action.ashx";			 		
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
        add_tram(ds_ss, dt.Go.Station, callback);
        add_tram(ds_ss, dt.Re.Station, callback)
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
  var ds_ss = {};
  tuyen = [22, 35, 50, 51, 5];  
  var cnt = 0;
  for(var i = 0; i < tuyen.length; ++i)
    get_tram_tren_duong_timbus(ds_ss, tuyen[i], function(e){
      cnt++;
      if (cnt == tuyen.length*2){
        str = JSON.stringify(ds_ss);
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