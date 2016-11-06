package entities.bullets;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
/**
 * Bullet part of a wave, each bullet in which has different angle and start speed.
 * Accelerates to a max speed.
 */
class BulletMediumFocus extends Bullet
{
	public static inline var MAX_SPEED:Int = 140;
	public static inline var ACCEL:Int = 30;
	

	public function new(isRed:Bool, xPos:Float, yPos:Float, dirAngle:Float, startSpeed:Float)
	{
		sprBullet = new Spritemap("graphics/bullet_medium_focus.png", 12, 7);

		super(isRed, xPos, yPos, dirAngle);
		speed = startSpeed;
		setHitbox(5, 5, 2, 2);
		
		rotateSprite();
	}
	
	override public function uniqueModifiers():Void 
	{
		if (speed < MAX_SPEED) 
		{
			speed += HXP.elapsed * ACCEL;
		}
		else 
		{
			speed = MAX_SPEED;
		}
		updateAngles();
	}

}
