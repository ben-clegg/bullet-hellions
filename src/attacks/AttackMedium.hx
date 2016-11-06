package attacks;
import com.haxepunk.HXP;
import entities.bullets.Bullet;
import entities.bullets.*;
import com.haxepunk.Sfx;

/**
 * "Shotgun" bullets, spread alternates between shots
 */
class AttackMedium extends Attack
{
	private var burstType:Bool = false;
	private static inline var ANGLE_CHANGE_A:Float = 0.27;
	private static inline var ANGLE_CHANGE_B:Float = 0.7;
	private static inline var ANGLE_CHANGE_C:Float = 0.4;

	public function new(redPlayer:Bool)
	{
		super(redPlayer);
		maxRelTime = 0.5;
		setSound(new Sfx("audio/Medium.wav"), 1);
	}

	override private function createBullets(xPos:Float, yPos:Float):Void
	{
		var ang:Float = centreAngle;
		
		if (burstType)
		{
			var bA:Bullet = new BulletMedium(redTeam, xPos, yPos, ang + ANGLE_CHANGE_A);
			var bB:Bullet = new BulletMedium(redTeam, xPos, yPos, ang - ANGLE_CHANGE_A);
			var bC:Bullet = new BulletMedium(redTeam, xPos, yPos, ang + ANGLE_CHANGE_B);
			var bD:Bullet = new BulletMedium(redTeam, xPos, yPos, ang - ANGLE_CHANGE_B);
			
			HXP.scene.add(bA);
			HXP.scene.add(bB);
			HXP.scene.add(bC);
			HXP.scene.add(bD);
			
			burstType = false;
		}
		else
		{
			var bA:Bullet = new BulletMedium(redTeam, xPos, yPos, ang);
			var bB:Bullet = new BulletMedium(redTeam, xPos, yPos, ang + ANGLE_CHANGE_C);
			var bC:Bullet = new BulletMedium(redTeam, xPos, yPos, ang - ANGLE_CHANGE_C);
			
			HXP.scene.add(bA);
			HXP.scene.add(bB);
			HXP.scene.add(bC);
			
			burstType = true;
		}
	}
}
