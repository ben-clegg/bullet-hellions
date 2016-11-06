package entities.transitions;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import global.Global;
import scenes.TitleScene;
/**
 * Screen fade to black.
 */

enum Status
{
	WAITING;
	FADING;
	READY;
}
class FadeOut extends Entity
{
	private var fadeRate:Int = 3;
	private var fadeDelay:Float = 3;
	private var rect:Image = Image.createRect(Global.NATIVE_WIDTH, Global.NATIVE_HEIGHT, 0x000000, 0);
	
	private var next:Scene = new TitleScene();
	
	private var timer:Float = 0;
	private var current:Status = WAITING;
	
	public function new(nextScene:Scene, delay:Float = 0.1, rate:Int = 3) 
	{
		super(0, 0, rect);
		layer = -1000;
		fadeRate = rate;
		fadeDelay = delay;
		next = nextScene;
	}
	override public function update():Void
	{
		switch(current)
		{
			case WAITING:
				if (timer < fadeDelay)
				{
					timer += HXP.elapsed;
				}
				else
				{
					current = FADING;
					timer = 0;
				};
			case FADING:
				if (rect.alpha < 1)
				{
					rect.alpha += HXP.elapsed * fadeRate;
				}
				else
				{
					current = READY;
					HXP.scene = next;
				}
			default:
				//Do nothing.
		}
		
	}
	
}