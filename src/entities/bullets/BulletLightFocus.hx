package entities.bullets;
import com.haxepunk.graphics.Spritemap;

/**
 * Bullets simply move forwards.
 */
class BulletLightFocus extends Bullet
{

	public function new(isRed:Bool, xPos:Float, yPos:Float, dirAngle:Float) 
	{
		sprBullet = new Spritemap("graphics/bullet_weak_focus.png", 8, 6);
		
		super(isRed, xPos, yPos, dirAngle);
		speed = 240;
		dps = 10;
		setHitbox(5, 4, 2, 2);
		
		if (!isRed)
		{
			sprBullet.flipped = true;
			setHitbox(5, 4, 3, 2);
		}
		
		sprBullet.centerOrigin;
	}
	
}