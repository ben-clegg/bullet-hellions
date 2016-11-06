package entities.player;
import com.haxepunk.graphics.Spritemap;
import global.Controls;
import src.entities.player.Player;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import global.Global;
/**
 * Define attributes unique to the Blue Player.
 */
class Blue extends Player
{
	
	public function new(startingLives:Int, xPos:Int, yPos:Int, xMin:Int, xMax:Int, yMin:Int, yMax:Int) 
	{
		super(startingLives, xPos, yPos, xMin, xMax, yMin, yMax);
		sprPlayer = new Spritemap("graphics/player_blue.png", 16, 16);
		sprPlayer.flipped = true;
		
		gamepad = Input.joystick(1);
		
		inpUp = "p2_up";
		inpDown = "p2_down";
		inpLeft = "p2_left";
		inpRight = "p2_right";
		
		inpFocus = "p2_focus";
		inpLight = "p2_light";
		inpMedium = "p2_medium";
		inpStrong = "p2_strong";
		
		enemyType = "red_bullet";
		type = "blue";
		isRed = false;
		
		lifeCounter = new LifeDisplay(Global.NATIVE_WIDTH - lifeOff, lifeY, false);
	}
}