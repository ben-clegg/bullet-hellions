package attacks;
import com.haxepunk.HXP;
import entities.bullets.Bullet;
import entities.bullets.BulletLightFocus;
import com.haxepunk.Sfx;

/**
 * Simple small projectiles, move ahead in straight line
 */
class AttackLightFocus extends Attack
{

	public function new(redPlayer:Bool)
	{
		super(redPlayer);
		maxRelTime = 0.2;
		setSound(new Sfx("audio/LightFocus.wav"), 1);
	}

	override private function createBullets(xPos:Float, yPos:Float):Void
	{
		var ang:Float = centreAngle;

		var bA:Bullet = new BulletLightFocus(redTeam, xPos, yPos, ang);

		HXP.scene.add(bA);
	}
}
