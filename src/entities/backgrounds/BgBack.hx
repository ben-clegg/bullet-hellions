package entities.backgrounds;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;

/**
 * Backmost background.
 */
class BgBack extends Background
{
	public function new() 
	{
		super(120);
		bd = new Backdrop("graphics/bg_back.png", true, false);
		scrollRate = 140;
		layer = 1100;
	}
	
}