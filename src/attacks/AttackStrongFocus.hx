package attacks;
import com.haxepunk.HXP;
import entities.bullets.*;
import com.haxepunk.Sfx;

/**
 * Two bullets spawn at once, but with counter-phase wave movement. 
 */
class AttackStrongFocus extends Attack
{

	public function new(redPlayer:Bool)
	{
		super(redPlayer);
		maxRelTime = 0.6;
		setSound(new Sfx("audio/StrongFocus.wav"), 1);
	}

	override private function createBullets(xPos:Float, yPos:Float):Void
	{
		var ang:Float = centreAngle;
		
		var off:Int = 3;
		if (!redTeam)
		{
			off = -3;
		}
		
		var bA:Bullet = new BulletStrongFocus(redTeam, xPos + off, yPos, ang, true);
		var bB:Bullet = new BulletStrongFocus(redTeam, xPos + off, yPos, ang, false);
		
		HXP.scene.add(bA);
		HXP.scene.add(bB);
	}
}
