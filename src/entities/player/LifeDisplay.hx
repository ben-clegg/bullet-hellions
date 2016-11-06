package entities.player;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;

/**
 * Entity to display the life count of a player.
 */
class LifeDisplay extends Entity
{
	private var sprNum:Spritemap;
	private var currentFrame:Int = 0;
	
	public function new(xPos:Int, yPos:Int, isRed:Bool) 
	{
		super(xPos, yPos);
		if (isRed)
		{
			sprNum = new Spritemap("graphics/lifecount_red.png", 8, 12);
		}
		else
		{
			sprNum = new Spritemap("graphics/lifecount_blue.png", 8, 12);
		}
		
		sprNum.playFrames([currentFrame]);
		sprNum.smooth = false;
		addGraphic(sprNum);
		sprNum.centerOrigin();
		
		layer = -2000;
	}
	
	public function loseLife():Void
	{
		if (currentFrame < 4)
		{
			currentFrame ++;
			sprNum.playFrames([currentFrame]);
		}
		else 
		{
			sprNum.visible = false;
		}
	}
	
	
	public function vanish():Void
	{
		sprNum.visible = false;
	}
}