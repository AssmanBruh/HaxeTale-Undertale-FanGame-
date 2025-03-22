package rooms;

import editor.Tile;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import haxe.Json;
import openfl.display.BitmapData;
import sys.FileSystem;
import sys.io.File;

using StringTools;
class Caca extends RoomState {
    var tiles:FlxTypedGroup<Tile>;
    var loadedImages:Array<{name:String, data:BitmapData}> = [];
    public function new(initialPositions:Array<Float>){
        super(initialPositions);
        // for back 
        // [1379, 276]

        // init
        // 315, 761
        // back
        // 298, 284
    }
    override  function create():Void {
        tiles = new FlxTypedGroup<Tile>();
        add(tiles);
        
        super.create();
        loadMapFromJson();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);

        for (tile in tiles.members){
             switch (tile.tileType){
                 case "collision.png":
                    FlxG.collide(tile, player);
                 case "doorChangeHitbox.png":
                    if (FlxG.pixelPerfectOverlap(tile, player)){
                        goToNextRoom();
                    }
             }
        }
    }
    // we not can change the room route :v
    // amenos de que tu lo edites en el switch
    public function goToNextRoom() {
        trace("switching");
        FlxG.switchState(new Room0([479, 510]));
    }

    function loadMapFromJson():Void {
        if (!FileSystem.exists("map.json")) {
            trace("No se encontró el archivo map.json");
            return;
        }

        var jsonString = File.getContent("map.json");
        var mapData:Array<{tileType:String, posiciones:{x:Int, y:Int}}> = Json.parse(jsonString);

        for (data in mapData) {
            var matchingTile = loadedImages.filter(t -> t.name == data.tileType);
            // if (matchingTile.length > 0) {
                var route = "assets/images/tiles/";
                if (data.tileType == "initRoom.png"){
                    route = "assets/images/rooms/";
                }else{
                    route = "assets/images/tiles/";
                }
                var newTile = new editor.Tile(data.posiciones.x, data.posiciones.y, route+data.tileType);
                newTile.tileType = data.tileType;
                if (newTile.tileType.startsWith("collision")){
                    newTile.immovable = true;
                }
                tiles.add(newTile);
            // } else {
                // trace("No se encontró la imagen para: " + data.tileType);
            // }
        }
    }
}
