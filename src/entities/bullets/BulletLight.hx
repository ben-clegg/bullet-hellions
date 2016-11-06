package entities.bullets;
import com.haxepunk.graphics.Spritemap;

/**
 * Light attack bullet.
 * Bullets move forwards but have alternating up and down.
 * Sprite angle should be set on creation.
 */
class BulletLight extends Bullet
{

	public function new(isRed:Bool, xPos:Float, yPos:Float, dirAngle:Float)
	{
		sprBullet = new Spritemap("graphics/bullet_weak.png", 5, 6);

		super(isRed, xPos, yPos, dirAngle);
		speed = 120;
		
		setHitbox(4, 4, 2, 2);
		
		rotateSprite();
	}

}
