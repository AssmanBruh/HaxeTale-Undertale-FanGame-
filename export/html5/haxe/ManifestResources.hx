package;

import haxe.io.Bytes;
import haxe.io.Path;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

#if disable_preloader_assets
@:dox(hide) class ManifestResources {
	public static var preloadLibraries:Array<Dynamic>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;

	public static function init (config:Dynamic):Void {
		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();
	}
}
#else
@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

			if(!StringTools.endsWith (rootPath, "/")) {

				rootPath += "/";

			}

		}

		if (rootPath == null) {

			#if (ios || tvos || webassembly)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif (console || sys)
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_mars_needs_cunnilingus_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_fonts_monsterfriendfore_otf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		data = '{"name":null,"assets":"aoy4:pathy34:assets%2Fdata%2Fdata-goes-here.txty4:sizezy4:typey4:TEXTy2:idR1y7:preloadtgoR2i10720R3y4:FONTy9:classNamey48:__ASSET__assets_fonts_mars_needs_cunnilingus_ttfR5y47:assets%2Ffonts%2FMars%20Needs%20Cunnilingus.ttfR6tgoR2i7340R3R7R8y43:__ASSET__assets_fonts_monsterfriendfore_otfR5y38:assets%2Ffonts%2FMonsterFriendFore.otfR6tgoR0y50:assets%2Fimages%2Fbattle%2Fbackground%2FbossBG.aseR2i7779R3y6:BINARYR5R13R6tgoR0y50:assets%2Fimages%2Fbattle%2Fbackground%2FbossBG.pngR2i1379R3y5:IMAGER5R15R6tgoR0y53:assets%2Fimages%2Fbattle%2Fbackground%2FmonsterBG.pngR2i1195R3R16R5R17R6tgoR0y42:assets%2Fimages%2Fbattle%2Fbox%2Fblack.pngR2i423R3R16R5R18R6tgoR0y42:assets%2Fimages%2Fbattle%2Fbox%2Fwhite.pngR2i467R3R16R5R19R6tgoR0y52:assets%2Fimages%2Fbattle%2Fskibidi%2FskibidiHead.pngR2i556R3R16R5R20R6tgoR0y52:assets%2Fimages%2Fbattle%2Fskibidi%2FskibidiNeck.pngR2i560R3R16R5R21R6tgoR0y54:assets%2Fimages%2Fbattle%2Fskibidi%2FskibidiToilet.pngR2i761R3R16R5R22R6tgoR0y53:assets%2Fimages%2Fbattle%2Fsoul%2FsoulSpriteSheet.pngR2i343R3R16R5R23R6tgoR0y43:assets%2Fimages%2Fbattle%2Fui%2FhpLabel.aseR2i578R3R14R5R24R6tgoR0y44:assets%2Fimages%2Fbattle%2Fui%2Fuibattle.pngR2i2017R3R16R5R25R6tgoR0y38:assets%2Fimages%2Fborders%2Fborder.pngR2i235167R3R16R5R26R6tgoR0y39:assets%2Fimages%2Fborders%2Fborder1.pngR2i235167R3R16R5R27R6tgoR0y39:assets%2Fimages%2Fborders%2Fborder2.pngR2i279145R3R16R5R28R6tgoR0y39:assets%2Fimages%2Fborders%2Fborder3.pngR2i293154R3R16R5R29R6tgoR0y39:assets%2Fimages%2Fborders%2Fborder4.pngR2i3316R3R16R5R30R6tgoR0y42:assets%2Fimages%2Fborders%2FbordersAse.aseR2i854761R3R14R5R31R6tgoR0y36:assets%2Fimages%2Fimages-go-here.txtR2zR3R4R5R32R6tgoR0y48:assets%2Fimages%2Fmonsters%2Fflowey%2Fflowey.aseR2i5533R3R14R5R33R6tgoR0y55:assets%2Fimages%2Fmonsters%2Fflowey%2FfloweySprites.aseR2i4601R3R14R5R34R6tgoR0y59:assets%2Fimages%2Fmonsters%2Fflowey%2FfloweySpriteSheet.pngR2i2155R3R16R5R35R6tgoR0y48:assets%2Fimages%2Fplayer%2Ffrisk-spritesheet.pngR2i1463R3R16R5R36R6tgoR0y38:assets%2Fimages%2Frooms%2FinitRoom.aseR2i11374R3R14R5R37R6tgoR0y38:assets%2Fimages%2Frooms%2FinitRoom.pngR2i7827R3R16R5R38R6tgoR0y35:assets%2Fimages%2Frooms%2Froom0.pngR2i4347R3R16R5R39R6tgoR0y39:assets%2Fimages%2Ftiles%2Fcollision.pngR2i446R3R16R5R40R6tgoR0y46:assets%2Fimages%2Ftiles%2FdoorChangeHitbox.aseR2i1038R3R14R5R41R6tgoR0y46:assets%2Fimages%2Ftiles%2FdoorChangeHitbox.pngR2i915R3R16R5R42R6tgoR0y39:assets%2Fimages%2Ftitlescene%2Ftest.pngR2i20114R3R16R5R43R6tgoR0y36:assets%2Fmusic%2Fmusic-goes-here.txtR2zR3R4R5R44R6tgoR2i13140R3y5:SOUNDR5y40:assets%2Fsounds%2Fcountdown%20finish.oggy9:pathGroupaR46hR6tgoR2i6542R3R45R5y31:assets%2Fsounds%2Fcountdown.oggR47aR48hR6tgoR2i15745R3R45R5y28:assets%2Fsounds%2Fnotice.oggR47aR49hR6tgoR0y36:assets%2Fsounds%2Fsounds-go-here.txtR2zR3R4R5R50R6tgoR2i8220R3y5:MUSICR5y26:flixel%2Fsounds%2Fbeep.mp3R47aR52y26:flixel%2Fsounds%2Fbeep.ogghR6tgoR2i39706R3R51R5y28:flixel%2Fsounds%2Fflixel.mp3R47aR54y28:flixel%2Fsounds%2Fflixel.ogghR6tgoR2i6840R3R45R5R53R47aR52R53hgoR2i33629R3R45R5R55R47aR54R55hgoR2i15744R3R7R8y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR6tgoR2i29724R3R7R8y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR6tgoR0y33:flixel%2Fimages%2Fui%2Fbutton.pngR2i222R3R16R5R60R6tgoR0y36:flixel%2Fimages%2Flogo%2Fdefault.pngR2i484R3R16R5R61R6tgoR0y42:flixel%2Fimages%2Ftransitions%2Fcircle.pngR2i299R3R16R5R62R6tgoR0y53:flixel%2Fimages%2Ftransitions%2Fdiagonal_gradient.pngR2i730R3R16R5R63R6tgoR0y43:flixel%2Fimages%2Ftransitions%2Fdiamond.pngR2i236R3R16R5R64R6tgoR0y42:flixel%2Fimages%2Ftransitions%2Fsquare.pngR2i209R3R16R5R65R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Fbox.pngR2i75R3R16R5R66R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fbutton.pngR2i211R3R16R5R67R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_down.pngR2i216R3R16R5R68R6tgoR0y48:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_left.pngR2i222R3R16R5R69R6tgoR0y49:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_right.pngR2i238R3R16R5R70R6tgoR0y46:flixel%2Fflixel-ui%2Fimg%2Fbutton_arrow_up.pngR2i227R3R16R5R71R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fbutton_thin.pngR2i118R3R16R5R72R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fbutton_toggle.pngR2i254R3R16R5R73R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fcheck_box.pngR2i101R3R16R5R74R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fcheck_mark.pngR2i97R3R16R5R75R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fchrome.pngR2i135R3R16R5R76R6tgoR0y42:flixel%2Fflixel-ui%2Fimg%2Fchrome_flat.pngR2i124R3R16R5R77R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_inset.pngR2i102R3R16R5R78R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Fchrome_light.pngR2i118R3R16R5R79R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Fdropdown_mark.pngR2i86R3R16R5R80R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Ffinger_big.pngR2i1337R3R16R5R81R6tgoR0y43:flixel%2Fflixel-ui%2Fimg%2Ffinger_small.pngR2i157R3R16R5R82R6tgoR0y38:flixel%2Fflixel-ui%2Fimg%2Fhilight.pngR2i74R3R16R5R83R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Finvis.pngR2i72R3R16R5R84R6tgoR0y41:flixel%2Fflixel-ui%2Fimg%2Fminus_mark.pngR2i77R3R16R5R85R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fplus_mark.pngR2i83R3R16R5R86R6tgoR0y36:flixel%2Fflixel-ui%2Fimg%2Fradio.pngR2i108R3R16R5R87R6tgoR0y40:flixel%2Fflixel-ui%2Fimg%2Fradio_dot.pngR2i81R3R16R5R88R6tgoR0y37:flixel%2Fflixel-ui%2Fimg%2Fswatch.pngR2i94R3R16R5R89R6tgoR0y34:flixel%2Fflixel-ui%2Fimg%2Ftab.pngR2i106R3R16R5R90R6tgoR0y39:flixel%2Fflixel-ui%2Fimg%2Ftab_back.pngR2i111R3R16R5R91R6tgoR0y44:flixel%2Fflixel-ui%2Fimg%2Ftooltip_arrow.pngR2i176R3R16R5R92R6tgoR0y39:flixel%2Fflixel-ui%2Fxml%2Fdefaults.xmlR2i1263R3R4R5R93R6tgoR0y53:flixel%2Fflixel-ui%2Fxml%2Fdefault_loading_screen.xmlR2i1953R3R4R5R94R6tgoR0y44:flixel%2Fflixel-ui%2Fxml%2Fdefault_popup.xmlR2i1848R3R4R5R95R6tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

	}


}

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_mars_needs_cunnilingus_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_fonts_monsterfriendfore_otf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_background_bossbg_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_background_bossbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_background_monsterbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_box_black_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_box_white_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_skibidi_skibidihead_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_skibidi_skibidineck_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_skibidi_skibiditoilet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_soul_soulspritesheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_ui_hplabel_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_battle_ui_uibattle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_borders_border_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_borders_border1_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_borders_border2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_borders_border3_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_borders_border4_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_borders_bordersase_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_monsters_flowey_flowey_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_monsters_flowey_floweysprites_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_monsters_flowey_floweyspritesheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_player_frisk_spritesheet_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_initroom_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_initroom_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_rooms_room0_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_tiles_collision_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_tiles_doorchangehitbox_ase extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_tiles_doorchangehitbox_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_titlescene_test_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_countdown_finish_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_countdown_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_notice_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_circle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_diagonal_gradient_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_diamond_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_square_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/Mars Needs Cunnilingus.ttf") @:noCompletion #if display private #end class __ASSET__assets_fonts_mars_needs_cunnilingus_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/MonsterFriendFore.otf") @:noCompletion #if display private #end class __ASSET__assets_fonts_monsterfriendfore_otf extends lime.text.Font {}
@:keep @:file("assets/images/battle/background/bossBG.ase") @:noCompletion #if display private #end class __ASSET__assets_images_battle_background_bossbg_ase extends haxe.io.Bytes {}
@:keep @:image("assets/images/battle/background/bossBG.png") @:noCompletion #if display private #end class __ASSET__assets_images_battle_background_bossbg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/battle/background/monsterBG.png") @:noCompletion #if display private #end class __ASSET__assets_images_battle_background_monsterbg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/battle/box/black.png") @:noCompletion #if display private #end class __ASSET__assets_images_battle_box_black_png extends lime.graphics.Image {}
@:keep @:image("assets/images/battle/box/white.png") @:noCompletion #if display private #end class __ASSET__assets_images_battle_box_white_png extends lime.graphics.Image {}
@:keep @:image("assets/images/battle/skibidi/skibidiHead.png") @:noCompletion #if display private #end class __ASSET__assets_images_battle_skibidi_skibidihead_png extends lime.graphics.Image {}
@:keep @:image("assets/images/battle/skibidi/skibidiNeck.png") @:noCompletion #if display private #end class __ASSET__assets_images_battle_skibidi_skibidineck_png extends lime.graphics.Image {}
@:keep @:image("assets/images/battle/skibidi/skibidiToilet.png") @:noCompletion #if display private #end class __ASSET__assets_images_battle_skibidi_skibiditoilet_png extends lime.graphics.Image {}
@:keep @:image("assets/images/battle/soul/soulSpriteSheet.png") @:noCompletion #if display private #end class __ASSET__assets_images_battle_soul_soulspritesheet_png extends lime.graphics.Image {}
@:keep @:file("assets/images/battle/ui/hpLabel.ase") @:noCompletion #if display private #end class __ASSET__assets_images_battle_ui_hplabel_ase extends haxe.io.Bytes {}
@:keep @:image("assets/images/battle/ui/uibattle.png") @:noCompletion #if display private #end class __ASSET__assets_images_battle_ui_uibattle_png extends lime.graphics.Image {}
@:keep @:image("assets/images/borders/border.png") @:noCompletion #if display private #end class __ASSET__assets_images_borders_border_png extends lime.graphics.Image {}
@:keep @:image("assets/images/borders/border1.png") @:noCompletion #if display private #end class __ASSET__assets_images_borders_border1_png extends lime.graphics.Image {}
@:keep @:image("assets/images/borders/border2.png") @:noCompletion #if display private #end class __ASSET__assets_images_borders_border2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/borders/border3.png") @:noCompletion #if display private #end class __ASSET__assets_images_borders_border3_png extends lime.graphics.Image {}
@:keep @:image("assets/images/borders/border4.png") @:noCompletion #if display private #end class __ASSET__assets_images_borders_border4_png extends lime.graphics.Image {}
@:keep @:file("assets/images/borders/bordersAse.ase") @:noCompletion #if display private #end class __ASSET__assets_images_borders_bordersase_ase extends haxe.io.Bytes {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/images/monsters/flowey/flowey.ase") @:noCompletion #if display private #end class __ASSET__assets_images_monsters_flowey_flowey_ase extends haxe.io.Bytes {}
@:keep @:file("assets/images/monsters/flowey/floweySprites.ase") @:noCompletion #if display private #end class __ASSET__assets_images_monsters_flowey_floweysprites_ase extends haxe.io.Bytes {}
@:keep @:image("assets/images/monsters/flowey/floweySpriteSheet.png") @:noCompletion #if display private #end class __ASSET__assets_images_monsters_flowey_floweyspritesheet_png extends lime.graphics.Image {}
@:keep @:image("assets/images/player/frisk-spritesheet.png") @:noCompletion #if display private #end class __ASSET__assets_images_player_frisk_spritesheet_png extends lime.graphics.Image {}
@:keep @:file("assets/images/rooms/initRoom.ase") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_initroom_ase extends haxe.io.Bytes {}
@:keep @:image("assets/images/rooms/initRoom.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_initroom_png extends lime.graphics.Image {}
@:keep @:image("assets/images/rooms/room0.png") @:noCompletion #if display private #end class __ASSET__assets_images_rooms_room0_png extends lime.graphics.Image {}
@:keep @:image("assets/images/tiles/collision.png") @:noCompletion #if display private #end class __ASSET__assets_images_tiles_collision_png extends lime.graphics.Image {}
@:keep @:file("assets/images/tiles/doorChangeHitbox.ase") @:noCompletion #if display private #end class __ASSET__assets_images_tiles_doorchangehitbox_ase extends haxe.io.Bytes {}
@:keep @:image("assets/images/tiles/doorChangeHitbox.png") @:noCompletion #if display private #end class __ASSET__assets_images_tiles_doorchangehitbox_png extends lime.graphics.Image {}
@:keep @:image("assets/images/titlescene/test.png") @:noCompletion #if display private #end class __ASSET__assets_images_titlescene_test_png extends lime.graphics.Image {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/countdown finish.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_countdown_finish_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/countdown.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_countdown_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/notice.ogg") @:noCompletion #if display private #end class __ASSET__assets_sounds_notice_ogg extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/5,9,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/5,9,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/5,9,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/5,9,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/5,9,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/5,9,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-addons/3,3,2/assets/images/transitions/circle.png") @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_circle_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-addons/3,3,2/assets/images/transitions/diagonal_gradient.png") @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_diagonal_gradient_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-addons/3,3,2/assets/images/transitions/diamond.png") @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_diamond_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-addons/3,3,2/assets/images/transitions/square.png") @:noCompletion #if display private #end class __ASSET__flixel_images_transitions_square_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/button.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/button_arrow_down.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_down_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/button_arrow_left.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_left_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/button_arrow_right.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_right_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/button_arrow_up.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_arrow_up_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/button_thin.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_thin_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/button_toggle.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_button_toggle_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/check_box.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_box_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/check_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_check_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/chrome.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/chrome_flat.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_flat_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/chrome_inset.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_inset_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/chrome_light.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_chrome_light_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/dropdown_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_dropdown_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/finger_big.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_big_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/finger_small.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_finger_small_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/hilight.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_hilight_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/invis.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_invis_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/minus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_minus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/plus_mark.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_plus_mark_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/radio.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/radio_dot.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_radio_dot_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/swatch.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_swatch_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/tab.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/tab_back.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tab_back_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/images/tooltip_arrow.png") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_img_tooltip_arrow_png extends lime.graphics.Image {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/xml/defaults.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_defaults_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/xml/default_loading_screen.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_loading_screen_xml extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel-ui/2,6,3/assets/xml/default_popup.xml") @:noCompletion #if display private #end class __ASSET__flixel_flixel_ui_xml_default_popup_xml extends haxe.io.Bytes {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_fonts_mars_needs_cunnilingus_ttf') @:noCompletion #if display private #end class __ASSET__assets_fonts_mars_needs_cunnilingus_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/Mars Needs Cunnilingus"; #else ascender = 1536; descender = -512; height = 2048; numGlyphs = 236; underlinePosition = -292; underlineThickness = 150; unitsPerEM = 2048; #end name = "Mars Needs Cunnilingus"; super (); }}
@:keep @:expose('__ASSET__assets_fonts_monsterfriendfore_otf') @:noCompletion #if display private #end class __ASSET__assets_fonts_monsterfriendfore_otf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/fonts/MonsterFriendFore"; #else ascender = 900; descender = -100; height = 1000; numGlyphs = 99; underlinePosition = -250; underlineThickness = 100; unitsPerEM = 1000; #end name = "Monster Friend Fore"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_fonts_mars_needs_cunnilingus_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_mars_needs_cunnilingus_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_mars_needs_cunnilingus_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_monsterfriendfore_otf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_monsterfriendfore_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_monsterfriendfore_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_fonts_mars_needs_cunnilingus_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_mars_needs_cunnilingus_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_mars_needs_cunnilingus_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__assets_fonts_monsterfriendfore_otf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_fonts_monsterfriendfore_otf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_fonts_monsterfriendfore_otf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end