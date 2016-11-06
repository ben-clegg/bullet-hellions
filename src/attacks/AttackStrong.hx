package attacks;
import com.haxepunk.HXP;
import entities.bullets.Bullet;
import entities.bullets.*;
import com.haxepunk.Sfx;

/**
 * Circular attack which leaves bullets on screen.
 * These will all be removed on a player death.
 * Lingering bullets adds zoning mechanic.
 */
class AttackStrong extends Attack
{
	private var lastUp:Bool = false;
	private static inline var ANGLE_CHANGE_A:Float = 0.3;
	private static inline var ANGLE_CHANGE_B:Float = 0.7;

	public function new(redPlayer:Bool)
	{
		super(redPlayer);
		maxRelTime = 1.1;
		setSound(new Sfx("audio/Strong.wav"), 1);
	}

	override private function createBullets(xPos:Float, yPos:Float):Void
	{
		/*
		var ang:Float = centreAngle - 0.275; //0.275 good, makes non-straight.
		
		for (i in 1...10) {
			var b:Bullet = new entities.bullets.BulletStrong(redTeam, xPos, yPos, 
				ang + (0.05 * i)); 
				// - (10 * i)
			HXP.scene.add(b);
		}
		*/
		
		var ang:Float = centreAngle;
		
		for (i in 1...4) {
			var b:Bullet = new entities.bullets.BulletStrong(redTeam, xPos, yPos, 
				ang + (0.05 * i)); 
			HXP.scene.add(b);
		}
		
		for (i in 1...4) {
			var b:Bullet = new entities.bullets.BulletStrong(redTeam, xPos, yPos, 
				ang - (0.05 * i)); 
			HXP.scene.add(b);
		}
	}
}
