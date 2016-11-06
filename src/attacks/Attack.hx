package attacks;
import com.haxepunk.Sfx;
import entities.bullets.Bullet;
import com.haxepunk.HXP;
/**
 * Base Class for Attacks.
 * Extended by individual Attacks, which should override createBullets().
 */
class Attack
{
	
	private var shotArc:Float = 0.5;
	private var bulletNum:Int = 5;
	private var centreAngle:Float = 0;
	
	//Use ammo, as this allows burst system as well as single shot.
	private var ammo:Int = 1; 
	private var maxAmmo:Int = 1;
	
	//Reload time, automatic if out of ammo, perhaps if not fired in some cases?
	//Low reload time, 1 ammo allows for full auto. 
	//Could do crazy patterns when combined with ammo amounts.
	private var relTime:Float = 1.0;
	public var maxRelTime:Float = 1.0;
	
	private var redTeam:Bool;
	
	private var sound:Sfx;
	private var volume:Float;

	public function new(redPlayer:Bool) 
	{
		redTeam = redPlayer;
		if (!redTeam)
		{
			centreAngle = Math.PI;
		}
	}
	
	public function setSound(newSound:Sfx, vol:Float)
	{
		sound = newSound;
		volume = vol;
	}
	
	public function fire(xPos:Float, yPos:Float):Void
	{
		createBullets(xPos, yPos);
		sound.play(volume, 0, false);
		ammo --;
		relTime = maxRelTime; //Reset reload if fired. Can always change behaviour.
	}
	
	private function createBullets(xPos:Float, yPos:Float):Void
	{
		//Specify how to create bullets.
		//Should be overridden.
	}
	
	public function canFire():Bool
	{
		//Return true if has ammo, false otherwise.
		if (ammo > 0)
		{
			return true;
		}
		return false;
	}
	
	public function reload():Void
	{
		//Should be called every frame, before firing in Player.
		//Refresh ammo even if it's not empty.
		if (ammo < maxAmmo)
		{
			relTime -= HXP.elapsed;
			if (relTime <= 0)
			{
				ammo = maxAmmo;
				relTime = maxRelTime;
			}
		}
	}
}