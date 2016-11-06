package global;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;

/**
 * Input definitions.
 */
class Controls
{
	

	public function new() 
	{
		
	}
	
	public static function defineInputs():Void
	{
		Input.define("p1_up", [Key.W]);
		Input.define("p1_down", [Key.S]);
		Input.define("p1_left", [Key.A]);
		Input.define("p1_right", [Key.D]);
		
		Input.define("p1_focus", [Key.SHIFT]);
		Input.define("p1_light", [Key.C]);
		Input.define("p1_medium", [Key.V]);
		Input.define("p1_strong", [Key.B]);
		
		Input.define("p2_up", [Key.UP]);
		Input.define("p2_down", [Key.DOWN]);
		Input.define("p2_left", [Key.LEFT]);
		Input.define("p2_right", [Key.RIGHT]);
		
		Input.define("p2_focus", [Key.O]);
		Input.define("p2_light", [Key.P]);
		Input.define("p2_medium", [Key.LEFT_SQUARE_BRACKET]);
		Input.define("p2_strong", [Key.RIGHT_SQUARE_BRACKET]);
	}
	
}

class PAD_360
{
	//Alternate 360 button mapping.
	//NOTE: This may only work on Windows deployment.
	//May need to change for Mac / Linux
	//References https://github.com/julsam/HaxePunk-Gamepad-Demo
	
	//Buttons
	public static inline var A_BUTTON:Int = 0;
	public static inline var B_BUTTON:Int = 1;
	public static inline var X_BUTTON:Int = 2;
	public static inline var Y_BUTTON:Int = 3;
	public static inline var LB_BUTTON:Int = 4;
	public static inline var RB_BUTTON:Int = 5;
	public static inline var BACK_BUTTON:Int = 6;
	public static inline var START_BUTTON:Int = 7;
	public static inline var LEFT_ANALOGUE_BUTTON:Int = 8;
	public static inline var RIGHT_ANALOGUE_BUTTON:Int = 9;
	
	//public static inline var XBOX_BUTTON:Int = 14;
	
	public static inline var DPAD_UP:Int = 0;
	public static inline var DPAD_DOWN:Int = 1;
	public static inline var DPAD_LEFT:Int = 2;
	public static inline var DPAD_RIGHT:Int = 3;
	
	//Axis array indices
	public static inline var LEFT_ANALOGUE_X:Int = 0;
	public static inline var LEFT_ANALOGUE_Y:Int = 1;
	//public static inline var RIGHT_ANALOGUE_X:Int = 2;
	//public static inline var RIGHT_ANALOGUE_Y:Int = 3;
	public static inline var LEFT_TRIGGER:Int = 2;
	public static inline var RIGHT_TRIGGER:Int = 5;
	
	public static inline var TRIGGER:Int = 3;
}