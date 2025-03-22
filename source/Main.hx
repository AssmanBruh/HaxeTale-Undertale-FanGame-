package;

import flixel.FlxG;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
import rooms.InitialRoom;
import sys.io.File;
import sys.io.Process;

class Main extends Sprite
{
	public static var isGamepad:Bool = false;
	var gameFrame:Int = 60;
	var fps:FPS;
	// public function main() {}
	public function new()
	{
		super();
		fps = new FPS(10,10);
		addChild(new FlxGame(0, 0, TitleScreen, gameFrame, gameFrame, true, false));
		FlxG.autoPause = false;

		addChild(fps);
		var os = Sys.systemName();

		switch (os)
		{
			case "Windows":
				Log.traceColor("Windows", "Blue");
				var nombreJuego = "UNDERTALE: GREEN";
				var rutaJuego = Sys.getCwd() + "\\UtGreen.exe";
				var rutaAccesoDirecto = Sys.getEnv("USERPROFILE") + "\\Desktop\\" + nombreJuego + ".lnk";

				// // Construcción del comando sin $s
				// var script = 'powershell -Command "' + '(New-Object -COM WScript.Shell).CreateShortcut(\'' + rutaAccesoDirecto + '\').TargetPath = \''
				// 	+ rutaJuego + '\'; ' + '(New-Object -COM WScript.Shell).CreateShortcut(\'' + rutaAccesoDirecto + '\').Save();' + '"';

				// // Ejecutar el script en CMD
				// var process = new Process("cmd", ["/c", script]);
				// process.close();
				// Crear un archivo BAT
				var batContent = '@echo off\n' + 'set shell=WScript.CreateObject("WScript.Shell")\n' + 'set shortcut=shell.CreateShortcut("'
					+ rutaAccesoDirecto + '")\n' + 'shortcut.TargetPath="' + rutaJuego + '"\n' + 'shortcut.Save()\n' + 'exit';

				var batPath = Sys.getCwd() + "\\crearAccesoDirecto.bat";
				File.saveContent(batPath, batContent);

				// Ejecutar el BAT
				var process = new Process("cmd", ["/c", batPath]);
				process.close();
			case "Mac":
				Log.traceColor("Mac", "Cyan");
				var nombreJuego = "UNDERTALE: GREEN";
				var rutaJuego = Sys.getCwd() + "/UtGreen.app";
				var rutaAccesoDirecto = Sys.getEnv("HOME") + "/Desktop/" + nombreJuego + " Alias";

				var script = 'osascript -e \'tell application "Finder" to make alias file to POSIX file "'
					+ rutaJuego
					+ '" at POSIX file "'
					+ rutaAccesoDirecto
					+ '"\'';
				var process = new Process("/bin/sh", ["-c", script]);
			// Aquí puedes crear un alias en Mac
			case "Linux":
				Log.traceColor("Linux", "Negro");
				var nombreJuego = "UNDERTALE: GREEN";
				var rutaJuego = Sys.getCwd() + "/UtGreen";
				var rutaAccesoDirecto = Sys.getEnv("HOME") + "/Desktop/" + nombreJuego + ".desktop";

				var contenido = "[Desktop Entry]\n" + "Version=1.0\n" + "Type=Application\n" + "Name=" + nombreJuego + "\n" + "Exec=" + rutaJuego + "\n"
					+ "Icon=application-x-executable\n" + "Terminal=false\n";

				File.saveContent(rutaAccesoDirecto, contenido);
				Sys.command("chmod +x " + rutaAccesoDirecto); // Dar permisos de ejecución
			// Aquí puedes crear un archivo .desktop en Linux
			default:
				Log.traceColor("Sistema Operativo no encontrado.", "Rojo");
		}
		
	}
}
