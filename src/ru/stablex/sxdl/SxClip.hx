package ru.stablex.sxdl;

import haxe.ds.StringMap.StringMap;
import haxe.ds.StringMap.StringMap;
import haxe.ds.StringMap.StringMap;
import haxe.ds.StringMap.StringMap;
import haxe.ds.StringMap.StringMap;
import ru.stablex.sxdl.SxObject;
import ru.stablex.sxdl.SxTile;

/**
 * ...
 * @author AS3Boyan
 */

class SxAnimation
{
	public var tiles:Array<SxTile>;
	public var fps:Float;
	
	public function new()
	{
		
	}
}
  
class SxClip extends SxObject
{
	var animations:StringMap<SxAnimation>;
	var current_animation:SxAnimation;
	
	var paused:Bool;
	
	var n:Int;
	var current_frame:Int;

	public function new() 
	{
		super();
		
		animations = new StringMap();
		
		n = 0;
	}
	
	override public function update(tileDataIdx:Int):Int 
	{		
		if (!paused && current_animation != null)
		{
			if (n >= 60 / current_animation.fps)
			{
				n = 0;
				
				if (current_frame >= current_animation.tiles.length) current_frame = 0;
				
				tile = current_animation.tiles[current_frame];
				current_frame++;
			}
			
			n++;
		}
		
		dirty = true;
		return super.update(tileDataIdx);
	}
	
	public function addAnimation(name:String, frames:Array<SxTile>, fps:Float):Void
	{
		var animation:SxAnimation = new SxAnimation();
		//animation.tiles = new Array();

		//for (frame in frames)
		//{
			//animation.tiles.push(frame);
		//}
		
		animation.tiles = frames;
		
		animation.fps = fps;
		animations.set(name, animation);
	}
	
	public function play(name:String):Void
	{
		current_animation = animations.get(name);
		paused = false;
		current_frame = 0;
		
		tile = current_animation.tiles[current_frame];
	}
	
	public function stop():Void
	{
		paused = true;
	}
	
}