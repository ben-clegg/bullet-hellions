package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import global.Global;

import src.entities.player.Player;
import entities.bullets.Bullet;

/**
 * Set each object as inactive / active to add hitstop.
 * Used when a player is hit by a bullet.
 */
class HitStop extends Entity
{
	public static inline var DELAY:Float = 0.5;

	private var timer:Float = 0;
	
	private var ents:List<Entity> = new List<Entity>();

	public function new()
	{
		super();
		Global.hitstopped = true;
		
		//Get every other entity.
		//Set all of them as inactive.
		
		var rBullets:List<Entity> = HXP.scene.entitiesForType("red_bullet");
		var bBullets:List<Entity> = HXP.scene.entitiesForType("blue_bullet");
		var rPlayers:List<Entity> = HXP.scene.entitiesForType("red");
		var bPlayers:List<Entity> = HXP.scene.entitiesForType("blue");
		
		if (! (rBullets == null)) 
		{
			for (e in rBullets) 
			{
				ents.add(e);
				e.active = false;
			}
		}
		if (! (bBullets == null)) 
		{
			for (e in bBullets) 
			{
				ents.add(e);
				e.active = false;
			}
		}
		if (! (rPlayers == null)) 
		{
			for (e in rPlayers) 
			{
				ents.add(e);
				e.active = false;
			}
		}
		if (! (bPlayers == null)) 
		{
			for (e in bPlayers) 
			{
				ents.add(e);
				e.active = false;
			}
		}
		
	}

	override public function update():Void
	{
		if(timer < DELAY)
		{
			timer += HXP.elapsed;
		}
		else
		{
			//Get all entities and set them as active.
			if (! (ents == null)) 
			{
				for (e in ents) 
				{
					e.active = true;
				}
			}
			Global.hitstopped = false;
			HXP.scene.remove(this);
		}
	}

}

