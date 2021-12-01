<div style="text-align: right"><a href="#" onclick="$('#widget-bar').hide();return false">Hide map</a></div>
<div id="map_canvas" style="width: 854px; height: 350px;margin:10px;"></div>
{literal}
<script type="text/javascript">
    $.getScript("https://maps.googleapis.com/maps/api/js?sensor=false&region=nz&async=2&callback=MapApiLoaded", function () {});
    var map;
    function MapApiLoaded() {
        var centerCoord = new google.maps.LatLng(30, 0); // Puerto Rico
        var mapOptions = {
            zoom: 2,
            center: centerCoord,
            disableDefaultUI: true,
            panControl: true,
            zoomControl: true,
            scaleControl:true,
            mapTypeId: google.maps.MapTypeId.ROADMAP
        };
        map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
        updateMap();
    }
    var markersArray = [];


        function addMarker(location,alt ) {
          marker = new google.maps.Marker({
            position: location,
            map: map,
            title:alt
          });
          markersArray.push(marker);
        }

        function clearOverlays() {
          if (markersArray) {
            for (i in markersArray) {
              markersArray[i].setMap(null);
            }
          }
        }

    function updateMap() {
       clearOverlays();
        $('.location:visible','#locations').each(function(){
            var l =new google.maps.LatLng(parseFloat($(this).attr('latitude')),parseFloat($(this).attr('longitude')));
            addMarker(l,$(this).text());
        });
    }


   
  
</script>
{/literal}