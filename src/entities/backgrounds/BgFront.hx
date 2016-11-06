package entities.backgrounds;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;

/**
 * Frontmost background.
 */
class BgFront extends Background
{
	public function new() 
	{
		super(160);
		bd = new Backdrop("graphics/bg_front.png", true, false);
		scrollRate = 200;
		layer = 1000;
	}
	
}