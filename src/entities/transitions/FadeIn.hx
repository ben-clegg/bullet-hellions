package entities.transitions;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import global.Global;
/**
 * Screen fade-in from black.
 */
class FadeIn extends Entity
{
	private var fadeRate:Int = 3;
	private var rect:Image = Image.createRect(Global.NATIVE_WIDTH, Global.NATIVE_HEIGHT, 0x000000, 1);
	
	public function new(rate:Int = 3) 
	{
		super(0, 0, rect);
		layer = -1000;
		fadeRate = rate;
	}
	override public function update():Void
	{
		if (rect.alpha > 0)
		{
			rect.alpha -= HXP.elapsed * fadeRate;
		}
		else
		{
			HXP.scene.remove(this);
		}
	}
	
}