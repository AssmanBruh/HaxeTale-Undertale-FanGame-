package backend;

class Log {
    static var colorMap:Map<String, String> = [
        "Negro" => "30",
        "Rojo" => "31",
        "Verde" => "32",
        "Amarillo" => "33",
        "Azul" => "34",
        "Magenta" => "35",
        "Cyan" => "36",
        "Blanco" => "37"
    ];

    public static function traceColor(message:String, colorName:String = "Blanco") {
        var timestamp = Date.now().toString().split(" ")[1]; // Obtener la hora actual
        var colorCode = colorMap.exists(colorName) ? colorMap.get(colorName) : "37"; // Default: Blanco
        var coloredMessage = '\x1b[${colorCode}m[$timestamp] - [TRACE]: $message\x1b[0m';
        trace(coloredMessage);
    }
}
