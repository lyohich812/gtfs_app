// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree
//= require leaflet
//= require jquery
//= require jquery_ujs

function showStops() {
    if (forward){
        for (var i=0; i<markersArray.length; i++){
            markersArray[i].setOpacity(1).bindPopup(stopnames[i]);
        }
    }
    else {
        for (var i=0; i<markersBackArray.length; i++){
            markersBackArray[i].setOpacity(1).bindPopup(stopnamesBack[i]);
        }
    }
    
};
    
function hideStops() {
    if (forward){
        for (var i=0; i<markersArray.length; i++){
            markersArray[i].setOpacity(0).unbindPopup();
        }
    }
    else {
        for (var i=0; i<markersBackArray.length; i++){
            markersBackArray[i].setOpacity(0).unbindPopup();
        }
    }

};

function showForward() {
    hideStops();
    forward = true;
    for (var i=0; i<polylineBackArray.length; i++){
        polylineBackArray[i].setStyle({opacity: 0});
    }
    // zoom the map to the polyline 
    mymap.fitBounds(polylineArray[1].getBounds()); 

    for (var i=0; i<polylineArray.length; i++){
        polylineArray[i].setStyle({opacity: 1});
    }
};

function showBack() {
    hideStops();
    forward = false;
    for (var i=0; i<polylineBackArray.length; i++){
        polylineBackArray[i].setStyle({opacity: 1});
    }
    // zoom the map to the polyline 
    mymap.fitBounds(polylineArray[1].getBounds()); 

    for (var i=0; i<polylineArray.length; i++){
        polylineArray[i].setStyle({opacity: 0});
    }
};
// for sorting array by vehicle id for further work
function compare( a, b ) {
    if ( a.vehicleId < b.vehicleId ){
      return -1;
    }
    if ( a.vehicleId > b.vehicleId ){
      return 1;
    }
    return 0;
  }
  

  // for calculating distance
  function toRad(n) {
    return n * Math.PI / 180;
   };
   function distVincenty(lat1, lon1, lat2, lon2) {
    var a = 6378137,
        b = 6356752.3142,
        f = 1 / 298.257223563, // WGS-84 ellipsoid params
        L = toRad(lon2-lon1),
        U1 = Math.atan((1 - f) * Math.tan(toRad(lat1))),
        U2 = Math.atan((1 - f) * Math.tan(toRad(lat2))),
        sinU1 = Math.sin(U1),
        cosU1 = Math.cos(U1),
        sinU2 = Math.sin(U2),
        cosU2 = Math.cos(U2),
        lambda = L,
        lambdaP,
        iterLimit = 100;
    do {
     var sinLambda = Math.sin(lambda),
         cosLambda = Math.cos(lambda),
         sinSigma = Math.sqrt((cosU2 * sinLambda) * (cosU2 * sinLambda) + (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda) * (cosU1 * sinU2 - sinU1 * cosU2 * cosLambda));
     if (0 === sinSigma) {
      return 0; // co-incident points
     };
     var cosSigma = sinU1 * sinU2 + cosU1 * cosU2 * cosLambda,
         sigma = Math.atan2(sinSigma, cosSigma),
         sinAlpha = cosU1 * cosU2 * sinLambda / sinSigma,
         cosSqAlpha = 1 - sinAlpha * sinAlpha,
         cos2SigmaM = cosSigma - 2 * sinU1 * sinU2 / cosSqAlpha,
         C = f / 16 * cosSqAlpha * (4 + f * (4 - 3 * cosSqAlpha));
     if (isNaN(cos2SigmaM)) {
      cos2SigmaM = 0; // equatorial line: cosSqAlpha = 0 (§6)
     };
     lambdaP = lambda;
     lambda = L + (1 - C) * f * sinAlpha * (sigma + C * sinSigma * (cos2SigmaM + C * cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM)));
    } while (Math.abs(lambda - lambdaP) > 1e-12 && --iterLimit > 0);
   
    if (!iterLimit) {
     return NaN; // formula failed to converge
    };
   
    var uSq = cosSqAlpha * (a * a - b * b) / (b * b),
        A = 1 + uSq / 16384 * (4096 + uSq * (-768 + uSq * (320 - 175 * uSq))),
        B = uSq / 1024 * (256 + uSq * (-128 + uSq * (74 - 47 * uSq))),
        deltaSigma = B * sinSigma * (cos2SigmaM + B / 4 * (cosSigma * (-1 + 2 * cos2SigmaM * cos2SigmaM) - B / 6 * cos2SigmaM * (-3 + 4 * sinSigma * sinSigma) * (-3 + 4 * cos2SigmaM * cos2SigmaM))),
        s = b * A * (sigma - deltaSigma);
    return s.toFixed(3); // round to 1mm precision
   };

   function getVehicles() {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
        vehicles = JSON.parse(this.responseText);
        vehicles.result.sort( compare );
        numberOfVehicles = vehicles.result.length;
      }
    };
    xmlhttp.open("GET", api, true);
    xmlhttp.send();
  }


   function initPosArray(Array) {
    Array.length = 0; 
    for (var i=0; i<numberOfVehicles; i++) {
      Array.push([vehicles.result[i].position, vehicles.result[i].timestamp]);
    }
  }

  function initArrays() {
    initPosArray(FirstPositionArr);
    setTimeout(initPosArray, 10000, SecondPositionArr);
    setTimeout(initDistArray, 11000, DistArr);
    setTimeout(initSpeedArray, 12000, SpeedArr);
    setTimeout(initArrays, 15000);
  }

  function initDistArray(Array) {
    Array.length = 0;
    for (var i=0; i<numberOfVehicles; i++) {
        Array.push(distVincenty(FirstPositionArr[i][0].lat, FirstPositionArr[i][0].lon, SecondPositionArr[i][0].lat, SecondPositionArr[i][0].lon));
      }
  }
  
  function initSpeedArray(Array) {
      Array.length = 0;
      for (var i=0; i<numberOfVehicles; i++) {
          Array.push(DistArr[i]/((Date.parse(SecondPositionArr[i][1])-Date.parse(FirstPositionArr[i][1]))/1000)); //20 secs between cords
      }
      calculateAverage();
  }

  function calculateAverage() {
    var count = 0;
    var v = 0;
        for (var i=0; i<SpeedArr.length; i++) {
            if (SpeedArr[i] > 0) { //stoyachie ne schitautsa
                v=v+SpeedArr[i];
                count++;    
            }
        }
      AverageV = (v/count*3.6).toFixed(1);
      
  }

 