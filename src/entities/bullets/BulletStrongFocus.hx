package entities.bullets;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;


/**
 * One of two bullets spawning at once, but with counter-phase wave movement. 
 */
class BulletStrongFocus extends Bullet
{
	private static inline var AMPLITUDE:Int = 20;
	private static inline var CHANGE_RATE:Int = 7;
	private var phase:Bool = true;
	private var startY:Float = 0;
	private var theta:Float = 0;
	
	public function new(isRed:Bool, xPos:Float, yPos:Float, dirAngle:Float, inPhase:Bool) 
	{
		sprBullet = new Spritemap("graphics/bullet_strong_focus.png", 12, 9);
		
		super(isRed, xPos, yPos, dirAngle);
		speed = 170;
		dps = 10;
		sprBullet.centerOrigin();
		setHitbox(8, 7, 5, 3);
		
		phase = inPhase;
		startY = yPos;
	}
	
	override public function uniqueModifiers():Void
	{
		if (phase) { theta += CHANGE_RATE * HXP.elapsed; } 
		else { theta -= CHANGE_RATE * HXP.elapsed; }
		
		this.y = startY + (AMPLITUDE * Math.sin(theta));
		
		rotateSprite();
	}
}