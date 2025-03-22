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
    override public function create():Void {
        super.create();
        drawGrid();
        var fallRoom = new FlxSprite(0, -40).loadGraphic(AssetPaths.initRoom__png);
        fallRoom.antialiasing = false;
        // not be necss to reScale the sprite
        fallRoom.updateHitbox();
        add(fallRoom);
        tiles = new FlxTypedGroup<FlxSprite>();
        add(tiles);
        
        tileButtons = new FlxTypedGroup<FlxSprite>();
        add(tileButtons);
         
        // var loadTileButton = new FlxButton(10, 10, "Cargar Tile", function() {
        //     loadImageFromFile();
        // });
        // add(loadTileButton);
        var loadTileButton = new FlxSprite(10, 10);
        loadTileButton.makeGraphic(100, 30, FlxColor.GRAY);
        loadTileButton.screenCenter();
        loadTileButton.updateHitbox();
        add(loadTileButton);
        
        FlxMouseEvent.add(loadTileButton, function(_) {
            loadImageFromFile();
        });
        
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
                addTileButton(imagePath, loader);
            });
        });
        fileRef.browse();
    }
    
    function addTileButton(imagePath:String, bitmapData:BitmapData):Void {
        var btnY = 10 + (tileButtons.length * 25);
        var tileButton = new FlxButton(10, btnY, "Tile ${tileButtons.length + 1}", function() {
            selectedTile.loadGraphic(bitmapData);
        });
        tileButtons.add(tileButton);
        add(tileButton);
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
            
            if (!isTilePlaced(tileX, tileY)) {
                var tile = new FlxSprite(tileX, tileY, selectedTile.pixels);
                tiles.add(tile);
            }
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
}
