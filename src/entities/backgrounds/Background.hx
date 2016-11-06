package entities.backgrounds;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import global.Global;
import com.haxepunk.HXP;

/**
 * Background object. Scrolls continuously with parallax effect.
 */
class Background extends Entity
{
	private var bd:Backdrop;
	private var scrollRate:Float = 1;

	public function new(yPos:Float) 
	{
		super(0, yPos);
		
	}
	
	override public function added():Void
	{
		set_graphic(bd);
	}
	
	override public function update():Void
	{
		//x = Global.combinedPlayerMove * scrollRate;
		if (Global.active)
		{
			x -= scrollRate * HXP.elapsed;
		}
		else
		{
			x -= scrollRate * HXP.elapsed * 0.3;
		}
	}
}