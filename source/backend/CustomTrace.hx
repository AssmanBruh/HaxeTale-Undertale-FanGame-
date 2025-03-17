package backend;

class CustomTrace {
    public static function log(msg:String) {
        var date = Date.now(); // Obtiene la fecha y hora actual
        var timeString = '${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}';
        // var timeString = '${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}:${date.getMilliseconds()}';
		Log.traceColor('[${timeString}] ' + msg, "Verde");
    }
}
