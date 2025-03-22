package editor;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.mouse.FlxMouseEvent;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.util.FlxColor;
import haxe.Json;
import sys.io.File;

class MapEditorANAL extends FlxState {
    var gridSize:Int = 40;
    var tiles:FlxTypedGroup<FlxSprite>;
    var selectedTile:FlxSprite;
    var tileSet:FlxSprite;
    
    override public function create():Void {
        super.create();
        drawGrid();
        
        tiles = new FlxTypedGroup<FlxSprite>();
        add(tiles);
        
        tileSet = new FlxSprite(10, 10, AssetPaths.img("tiles/collision"));
        tileSet.scale.set(0.5, 0.5);
        add(tileSet);
        
        selectedTile = new FlxSprite();
        selectedTile.makeGraphic(gridSize, gridSize, FlxColor.WHITE);
        selectedTile.alpha = 0.5;
        add(selectedTile);
        
        FlxG.mouse.visible = true;
        
        FlxMouseEvent.add(tileSet, onTileSelect);
    }
    
    function drawGrid():Void {
        // for (y in 0...Std.int(FlxG.height / gridSize)) {
        //     for (x in 0...Std.int(FlxG.width / gridSize)) {
        //         var gridTile = new FlxSprite(x * gridSize, y * gridSize);
        //         gridTile.makeGraphic(gridSize, gridSize, FlxColor.TRANSPARENT);
        //         gridTile.pixels.fillRect(gridTile.pixels.rect, 0x22FFFFFF);
        //         add(gridTile);
        //     }
        // }
        var gridBG = FlxGridOverlay.create(gridSize, gridSize, -1, -1, true, 0xFF282b42, 0xFF1f2030);
        gridBG.screenCenter();
        add(gridBG);
    }
    
    function onTileSelect(sprite:FlxSprite):Void {
        selectedTile.loadGraphic(AssetPaths.img("tiles/collision"));
    }
    
    override public function update(elapsed:Float):Void {
        super.update(elapsed);
        selectedTile.setPosition(FlxG.mouse.x - (FlxG.mouse.x % gridSize), FlxG.mouse.y - (FlxG.mouse.y % gridSize));
        
        if (FlxG.mouse.pressed) {
            var tileX = FlxG.mouse.x - (FlxG.mouse.x % gridSize);
            var tileY = FlxG.mouse.y - (FlxG.mouse.y % gridSize);
            
            if (!isTilePlaced(tileX, tileY)) {
                var tile = new FlxSprite(tileX, tileY, AssetPaths.img("tiles/collision"));
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
