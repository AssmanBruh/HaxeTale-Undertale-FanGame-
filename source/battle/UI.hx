package battle;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;

class UI extends FlxSpriteGroup{
    public var lv:Int = 1; // love of violence :D
    public var hpPercent:Int = 20; 
    public var name:String = "CHARA";

    var nameTxt:FlxText;
    var lvText:FlxText;
    var hpBar:FlxBar;
    var hpLabel:FlxText;
    var hpText:FlxText;
    var fontSize:Int = 18;
    var nameColor:FlxColor = FlxColor.WHITE;

    var curSelelected:Int = 0;
    var battleButtonNames:Array<String> = ["FIGHT", "ACT", "ITEMS", "MERCY"];
    // sup. not'ng of groups
    var battleButtons:Array<FlxSprite> = [];
    var input:InputConstants;
    var soulX:Float = 0;
    public function new(name:String, lv:Int, hpPercent:Int){
        super();

        this.name = name;
        this.lv = lv;
        this.hpPercent = hpPercent;
        input = new InputConstants();

        nameTxt = new FlxText(30, 403, 0, name, fontSize);
        nameTxt.setFormat(font(), fontSize, nameColor, LEFT);
        add(nameTxt);

        battleButtons = [];

        for (i in 0...battleButtonNames.length){
             // the split space between buttons
             var sep = 44;
             var xx = [40.05, 193.35, 353.1, 508.05];
             var button = new FlxSprite(xx[i], 432.1).loadGraphic(AssetPaths.img("battle/ui/uibattle"), true, 110, 42);
            //  idle
             button.animation.add("FIGHT", [2], 7, true);
             button.animation.add("ACT", [0], 7, true);
             button.animation.add("ITEMS", [4], 7, true);
             button.animation.add("MERCY", [6], 7, true);
             //  selections
             button.animation.add("FIGHT-YELLOW", [3], 7, true);
             button.animation.add("ACT-YELLOW", [1], 7, true);
             button.animation.add("ITEMS-YELLOW", [5], 7, true);
             button.animation.add("MERCY-YELLOW", [7], 7, true);
             //  end
             button.animation.play(battleButtonNames[i]);
             button.ID = i;
             button.antialiasing = false;
             button.updateHitbox();
             add(button);
             battleButtons.push(button);
        }
        change();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        input.initInput();

        if (input.LEFT){
            change(-1);
        }else if (input.RIGHT){
            change(1);
        }
    }

    function change(b:Int=0) {
        curSelelected = FlxMath.wrap(curSelelected+b, 0, battleButtons.length-1);

        for (item in battleButtons){
             item.animation.play(battleButtonNames[item.ID]);
            if (item.ID == curSelelected){
             item.animation.play(battleButtonNames[curSelelected]+"-YELLOW");
             soulX = (item.x + 46);
            }
        }
    }

    function font() {
        return AssetPaths.font("Mars Needs Cunnilingus.ttf");
    }
}