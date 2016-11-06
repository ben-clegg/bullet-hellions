package entities.bullets;
import com.haxepunk.graphics.Spritemap;

/**
 * Bullet moves in a straight line. 
 * Multiple bullets are spawned with different angles by attack.
 */
class BulletMedium extends Bullet
{

	public function new(isRed:Bool, xPos:Float, yPos:Float, dirAngle:Float)
	{
		sprBullet = new Spritemap("graphics/bullet_medium.png", 8, 8);
		
		super(isRed, xPos, yPos, dirAngle);
		speed = 130;
		setHitbox(6, 6, 3, 3);
	}

}
