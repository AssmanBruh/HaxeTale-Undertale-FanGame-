package editor;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
class Tile extends FlxSprite{
    public var tileType:String = "collision";
    public function new (xX=0.0, yY=0.0, ?SimpleGraphic:FlxGraphicAsset){
        super(xX,yY, SimpleGraphic);
    }
}