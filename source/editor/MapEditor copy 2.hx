package editor;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEvent;
import flixel.input.mouse.FlxMouseEventManager;
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
    var tiles:FlxTypedGroup<FlxSprite>;
    var selectedTile:FlxSprite;
    var tileSet:FlxSprite;
    var loadedImages:Array<String> = [];
    var tileButtons:FlxTypedGroup<FlxSprite>;
    var fileRef:FileReference;
    var loadTileButton:FlxButton;
    var cameraSpeed:Float = 200;
    var saveMapButton:FlxButton;
    override public function create():Void {
        super.create();
        drawGrid();
        // var fallRoom = new FlxSprite(0, -40).loadGraphic(AssetPaths.initRoom__png);
        // fallRoom.antialiasing = false;
        // // not be necss to reScale the sprite
        // fallRoom.updateHitbox();
        // add(fallRoom);

        tiles = new FlxTypedGroup<FlxSprite>();
        add(tiles);
        
        tileButtons = new FlxTypedGroup<FlxSprite>();
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
        saveMapButton = new FlxButton(loadTileButton.x, .loadTileButton+40, "Guardar Mapa", function() {
            saveMapToJson();
        });
        add(saveMapButton);
        
        selectedTile = new FlxSprite();
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
                loadedImages.push(imagePath);
                Log.traceColor("Supposssed image: "+loader, "Magenta");
                addTileButton(loader);
            });
        });
        fileRef.browse();
    }
    
    var selectinFile:Bool = false;
    function addTileButton(bitmapData:BitmapData):Void {
        // var btnY = 10 + (tileButtons.length * (gridSize + 5));
        var tileButton = new FlxSprite(180 + (tileButtons.length * (gridSize + 5)), 10, bitmapData);
        tileButton.setGraphicSize(gridSize, gridSize);
        tileButton.updateHitbox();
        tileButtons.add(tileButton);
        add(tileButton);
        
        FlxMouseEvent.add(tileButton, function(_) {
            selectedTile.loadGraphic(bitmapData);
        }, function(object:FlxSprite/**onUp**/){
        },
        function(object:FlxSprite/**onmouseover**/){
            selectinFile = true;
        },
        function(object:FlxSprite/**onmouseout**/){
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
        selectedTile.setPosition(FlxG.mouse.x - (FlxG.mouse.x % gridSize), FlxG.mouse.y - (FlxG.mouse.y % gridSize));
        
        if (FlxG.mouse.pressed) {
            var tileX = FlxG.mouse.x - (FlxG.mouse.x % gridSize);
            var tileY = FlxG.mouse.y - (FlxG.mouse.y % gridSize);
            
            if (!isTilePlaced(tileX, tileY) && !FlxG.mouse.overlaps(loadTileButton) && !selectinFile) {
                var tile = new FlxSprite(tileX, tileY, selectedTile.pixels);
                tiles.add(tile);
            }
        }

        if (FlxG.mouse.pressedRight) {
            var tileX = FlxG.mouse.x - (FlxG.mouse.x % gridSize);
            var tileY = FlxG.mouse.y - (FlxG.mouse.y % gridSize);
            removeTile(tileX, tileY);
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
            mapData.push({tileType: "tile", posiciones: {x: Std.int(tile.x), y: Std.int(tile.y)}});
        }
        var jsonString = Json.stringify(mapData, true);
        File.saveContent("map.json", jsonString);
    }
}
