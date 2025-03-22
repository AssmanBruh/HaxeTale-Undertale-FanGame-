package editor;

import entities.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEvent;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import haxe.Json;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.events.Event;
import openfl.net.FileReference;
import openfl.utils.Future;
import sys.FileSystem;
import sys.io.File;

class MapEditor extends FlxState {
    var gridSize:Int = 40;
    var tiles:FlxTypedGroup<Tile>;
    var selectedTile:Tile;
    var tileSet:Tile;
    var loadedImages:Array<{name:String, data:BitmapData}> = [];
    var tileButtons:FlxTypedGroup<Tile>;
    var fileRef:FileReference;
    var loadTileButton:FlxButton;
    var addPlayerButton:FlxButton;
    var cameraSpeed:Float = 200;
    var saveMapButton:FlxButton;
    var player:Player;
    var ppt:FlxText;
    override public function create():Void {
        super.create();
        drawGrid();
        // var fallRoom = new FlxSprite(0, -40).loadGraphic(AssetPaths.initRoom__png);
        // fallRoom.antialiasing = false;
        // // not be necss to reScale the sprite
        // fallRoom.updateHitbox();
        // add(fallRoom);

        tiles = new FlxTypedGroup<Tile>();
        add(tiles);
        
        tileButtons = new FlxTypedGroup<Tile>();
        add(tileButtons);
         
        // var loadTileButton = new FlxButton(10, 10, "Cargar Tile", function() {
        //     loadImageFromFile();
        // });
        // add(loadTileButton);
        loadTileButton = new FlxButton(FlxG.width-10, 10, "Cargar Imagen", function() {
            loadImageFromFile();
        });
        loadTileButton.x = FlxG.width - loadTileButton.width - 10;
        add(loadTileButton);
        saveMapButton = new FlxButton(loadTileButton.x, loadTileButton.y+40, "Guardar Mapa", function() {
            saveMapToJson();
        });
        add(saveMapButton);

        addPlayerButton = new FlxButton(loadTileButton.x, loadTileButton.y+80, "Add Player Ref??", function() {
            if (player == null){
            addPlayer();
            ppt = new FlxText(10, FlxG.height - 45, 0, "PLAYER-X : "+player.x+"\nPLAYER-Y: "+player.y, 35);
            ppt.color = FlxColor.BLACK;
            add(ppt);
            }
        });
        add(addPlayerButton);
        
        selectedTile = new Tile();
        selectedTile.makeGraphic(gridSize, gridSize, FlxColor.WHITE);
        selectedTile.alpha = 0.5;
        add(selectedTile);
        
        FlxG.mouse.visible = true;
    }
    
    function loadImageFromFile():Void {
        fileRef = new FileReference();
        fileRef.addEventListener(Event.SELECT, function(_) {
            fileRef.load();
        });
        fileRef.addEventListener(Event.COMPLETE, function(_) {
            BitmapData.loadFromBytes(fileRef.data).onComplete(function(loader:BitmapData) {
                var imagePath = fileRef.name;
                loadedImages.push({name: imagePath, data: loader});
                addTileButton(imagePath, loader);
                Log.traceColor("Supposssed image: NAME: "+imagePath+", "+loader, "Magenta");
            });
        });
        fileRef.browse();
    }
    
    var selectinFile:Bool = false;
    function addTileButton(name:String, bitmapData:BitmapData):Void {
        // var btnY = 10 + (tileButtons.length * (gridSize + 5));
        var tileButton = new Tile(180 + (tileButtons.length * (gridSize + 5)), 10, bitmapData);
        tileButton.setGraphicSize(gridSize, gridSize);
        tileButton.updateHitbox();
        tileButtons.add(tileButton);
        add(tileButton);
        
        FlxMouseEvent.add(tileButton, function(_) {
            selectedTile.loadGraphic(bitmapData);
            selectedTile.tileType = name;
        }, function(object:Tile/**onUp**/){
        },
        function(object:Tile/**onmouseover**/){
            selectinFile = true;
        },
        function(object:Tile/**onmouseout**/){
            selectinFile = false;
        });
    }
    
    function drawGrid():Void {
        var gridBG = FlxGridOverlay.create(gridSize, gridSize, -1, -1, true, 0xFF282b42, 0xFF1f2030);
        gridBG.screenCenter();
        add(gridBG);
    }
    
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
            selectedTile.visible = !FlxG.mouse.overlaps(loadTileButton);
        selectedTile.setPosition(FlxG.mouse.x - (FlxG.mouse.x % gridSize), FlxG.mouse.y - (FlxG.mouse.y % gridSize));

        // so sorry
        for (tileButton in tileButtons.members){
        if (FlxG.mouse.overlaps(tileButton)){
            selectedTile.visible = false;
        }else if (!FlxG.mouse.overlaps(loadTileButton)){
            selectedTile.visible = true;
        }
        }
        
        if (FlxG.mouse.pressed) {
            if (player != null){
                if (FlxG.mouse.overlaps(player)){
                    player.setPosition(FlxG.mouse.x - (FlxG.mouse.x % gridSize), FlxG.mouse.y - (FlxG.mouse.y % gridSize));
                }else{
                    var tileX = FlxG.mouse.x - (FlxG.mouse.x % gridSize);
                    var tileY = FlxG.mouse.y - (FlxG.mouse.y % gridSize);
                    
                    if (!isTilePlaced(tileX, tileY) && !FlxG.mouse.overlaps(loadTileButton) && !selectinFile) {
                        var tile = new Tile(tileX, tileY, selectedTile.pixels);
                        tile.tileType = selectedTile.tileType;
                        tiles.add(tile);
                    }
                }
            }else{
                var tileX = FlxG.mouse.x - (FlxG.mouse.x % gridSize);
                var tileY = FlxG.mouse.y - (FlxG.mouse.y % gridSize);
                
                if (!isTilePlaced(tileX, tileY) && !FlxG.mouse.overlaps(loadTileButton) && !selectinFile) {
                    var tile = new Tile(tileX, tileY, selectedTile.pixels);
                    tile.tileType = selectedTile.tileType;
                    tiles.add(tile);
                }
            }
        }

        if (FlxG.mouse.pressedRight) {
            var tileX = FlxG.mouse.x - (FlxG.mouse.x % gridSize);
            var tileY = FlxG.mouse.y - (FlxG.mouse.y % gridSize);
            removeTile(tileX, tileY);
        }

        if (FlxG.keys.justPressed.BACKSPACE){
            FlxG.switchState(new rooms.Caca([280, 240]));
        }

        if (FlxG.mouse.justReleased){
            if (player!= null){
                if (FlxG.mouse.overlaps(player)){
                    ppt.text = "PLAYER-X : "+player.x+"\nPLAYER-Y: "+player.y;
                }
            }
        }

         // Cámara: Movimiento con WASD o flechas
         if (FlxG.keys.pressed.W || FlxG.keys.pressed.UP) {
            FlxG.camera.scroll.y -= cameraSpeed * elapsed;
        }
        if (FlxG.keys.pressed.S || FlxG.keys.pressed.DOWN) {
            FlxG.camera.scroll.y += cameraSpeed * elapsed;
        }
        if (FlxG.keys.pressed.A || FlxG.keys.pressed.LEFT) {
            FlxG.camera.scroll.x -= cameraSpeed * elapsed;
        }
        if (FlxG.keys.pressed.D || FlxG.keys.pressed.RIGHT) {
            FlxG.camera.scroll.x += cameraSpeed * elapsed;
        }

         // Cámara: Zoom con la rueda del mouse
         if (FlxG.mouse.wheel != 0) {
            FlxG.camera.zoom += FlxG.mouse.wheel * 0.1;
        }
    }

    function addPlayer(){
        player = new Player(FlxG.mouse.x - (FlxG.mouse.x % gridSize), FlxG.mouse.y - (FlxG.mouse.y % gridSize));
        add(player);
		// player.x -= Constants.gameXAdds + 18;
		// player.y -= Constants.gameYAdds + 27;
    }
    
    function isTilePlaced(x:Int, y:Int):Bool {
        for (tile in tiles.members) {
            if (tile.x == x && tile.y == y) {
                return true;
            }
        }
        return false;
    }

    function removeTile(x:Int, y:Int):Void {
        for (tile in tiles.members) {
            if (tile.x == x && tile.y == y) {
                tiles.remove(tile, true);
                tile.destroy();
                break;
            }
        }
    }

    function saveMapToJson():Void {
        var mapData:Array<{tileType:String, posiciones:{x:Int, y:Int}}> = [];
        for (tile in tiles.members) {
            mapData.push({tileType: tile.tileType, posiciones: {x: Std.int(tile.x), y: Std.int(tile.y)}});
        }
        var jsonString = Json.stringify(mapData);
        File.saveContent("map.json", jsonString);
    }
}
