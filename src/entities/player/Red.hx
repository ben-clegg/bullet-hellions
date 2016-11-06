package entities.player;
import com.haxepunk.graphics.Spritemap;
import global.Controls;
import src.entities.player.Player;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
/**
 * Define attributes unique to the Red Player.
 */
class Red extends Player
{
	
	public function new(startingLives:Int, xPos:Int, yPos:Int, xMin:Int, xMax:Int, yMin:Int, yMax:Int) 
	{
		super(startingLives, xPos, yPos, xMin, xMax, yMin, yMax);
		sprPlayer = new Spritemap("graphics/player_red.png", 16, 16);
		sprPlayer.flipped = false;
		
		gamepad = Input.joystick(0);
		
		inpUp = "p1_up";
		inpDown = "p1_down";
		inpLeft = "p1_left";
		inpRight = "p1_right";
		
		inpFocus = "p1_focus";
		inpLight = "p1_light";
		inpMedium = "p1_medium";
		inpStrong = "p1_strong";
		
		enemyType = "blue_bullet";
		type = "red";
		isRed = true;
		
		lifeCounter = new LifeDisplay(lifeOff, lifeY, true);
	}
}