package entities.bullets;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
/**
 * Angle continously changes, until reaching a particular value, where the bullets stop.
 * The bullets remain on screen (until a Player is hit), so the attack can be used for zoning.
 */
class BulletStrong extends Bullet
{
	public static inline var ACCEL:Int = 10;
	public static inline var ANG_CHANGE:Float = 64;
	
	private var angFactor:Int = 1;
	private static inline var MAX_ANG:Int = 6;
	
	private var startAngle:Float = 0;
	
	private var sfxLock:Sfx = new Sfx("audio/StrongLock.wav");
	private var played:Bool = false;
	
	public function new(isRed:Bool, xPos:Float, yPos:Float, dirAngle:Float)
	{
		sprBullet = new Spritemap("graphics/bullet_strong.png", 12, 12);
		
		super(isRed, xPos, yPos, dirAngle);
		setHitbox(10, 10, 5, 5);
		sprBullet.centerOrigin();
		
		speed = 80;
		
		startAngle = dirAngle;
		
		if (redTeam)
		{
			if (dirAngle < 0) {
				angFactor = -1;
			}
		}
		else
		{
			if (dirAngle < Math.PI) {
				angFactor = -1;
			}
		}
		
	}
	
	override public function uniqueModifiers():Void
	{
		if (redTeam)
		{
			if (Math.abs(angle) < MAX_ANG)
			{
				angle += (0.02 * angle);
				updateAngles();
			}
			else 
			{
				//angle = MAX_ANG;
				if (!played)
				{
					sfxLock.play(0.5, 0, false);
					played = true;
				}
				xVel = 0;
				yVel = 0;
			}
		}
		else
		{
			if ((Math.abs(angle - Math.PI)) < (MAX_ANG))
			{
				angle += (0.02 * (angle - Math.PI));
				updateAngles();
			}
			else 
			{
				if (!played)
				{
					sfxLock.play(0.5, 0, false);
					played = true;
				}
				
				xVel = 0;
				yVel = 0;
			}
		}
		
		
		rotateSprite();
	}

}
