package attacks;
import com.haxepunk.HXP;
import entities.bullets.Bullet;
import entities.bullets.*;
import com.haxepunk.Sfx;

/**
 * "Wave" style attack
 * Spawn multiple bullets with different starting angles and speeds.
 */
class AttackMediumFocus extends Attack
{
	private var burstType:Bool = false;
	private static inline var ANGLE_CHANGE_A:Float = 0.1;
	private static inline var ANGLE_CHANGE_B:Float = 0.2;

	public function new(redPlayer:Bool)
	{
		super(redPlayer);
		maxRelTime = 0.8;
		setSound(new Sfx("audio/MediumFocus.wav"), 1);
	}

	override private function createBullets(xPos:Float, yPos:Float):Void
	{
		var ang:Float = centreAngle;
		var speedDiff:Int = 20;
		var s = BulletMediumFocus.MAX_SPEED;
		
		if (!redTeam)
		{
			xPos --;
		}
		
		
		if (burstType)
		{
			var bA:Bullet = new BulletMediumFocus(redTeam, xPos, yPos, ang - ANGLE_CHANGE_A, s);
			var bB:Bullet = new BulletMediumFocus(redTeam, xPos, yPos, ang, s - (speedDiff * 1));
			var bC:Bullet = new BulletMediumFocus(redTeam, xPos, yPos, ang + ANGLE_CHANGE_A, s - (speedDiff * 2));
			var bD:Bullet = new BulletMediumFocus(redTeam, xPos, yPos, ang + ANGLE_CHANGE_B, s - (speedDiff * 3));
			
			HXP.scene.add(bA);
			HXP.scene.add(bB);
			HXP.scene.add(bC);
			HXP.scene.add(bD);
			
			burstType = false;
		}
		else
		{
			var bA:Bullet = new BulletMediumFocus(redTeam, xPos, yPos, ang + ANGLE_CHANGE_A, s);
			var bB:Bullet = new BulletMediumFocus(redTeam, xPos, yPos, ang, s - (speedDiff * 1));
			var bC:Bullet = new BulletMediumFocus(redTeam, xPos, yPos, ang - ANGLE_CHANGE_A, s - (speedDiff * 2));
			var bD:Bullet = new BulletMediumFocus(redTeam, xPos, yPos, ang - ANGLE_CHANGE_B, s - (speedDiff * 3));
			
			HXP.scene.add(bA);
			HXP.scene.add(bB);
			HXP.scene.add(bC);
			HXP.scene.add(bD);
			
			burstType = true;
		}
	}
}
