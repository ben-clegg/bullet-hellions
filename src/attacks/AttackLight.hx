package attacks;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import entities.bullets.*;
/**
 * Spawn projectiles, alternating between 2 shallow angles focused about centre.
 */
class AttackLight extends Attack
{
	private var lastUp:Bool = false;
	private static inline var ANGLE_CHANGE:Float = 0.3;

	public function new(redPlayer:Bool)
	{
		super(redPlayer);
		maxRelTime = 0.12;
		setSound(new Sfx("audio/Light.wav"), 1);
	}

	override private function createBullets(xPos:Float, yPos:Float):Void
	{
		var ang:Float = centreAngle;
		if (lastUp)
		{
			ang -= ANGLE_CHANGE;
			lastUp = false;
		}
		else
		{
			ang += ANGLE_CHANGE;
			lastUp = true;
		}

		var bA:Bullet = new BulletLight(redTeam, xPos, yPos, ang);

		HXP.scene.add(bA);
	}
}
