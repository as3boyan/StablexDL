package ru.stablex.sxdl;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import haxe.xml.Fast;
import ru.stablex.sxdl.SxStage;

/**
 * ...
 * @author AS3Boyan
 */
class SparrowParser
{
	var stage:SxStage;
	var spritesheet_bitmap_data:BitmapData;
	var added_rects:Array<Rectangle>;

	public function new(_stage:SxStage, _xml_data:String, _bitmap_data:BitmapData) 
	{
		stage = _stage;
		
		var xml_data:Xml = Xml.parse(_xml_data);
		var fast:Fast = new Fast(xml_data.firstElement());
		added_rects = new Array();
		
		spritesheet_bitmap_data = _bitmap_data;
		
		for (subtexture in fast.nodes.SubTexture)
		{
			var size:Rectangle = null;
			
			if (subtexture.has.frameX)
			{
				size = new Rectangle(Std.parseInt(subtexture.att.frameX),Std.parseInt(subtexture.att.frameY), Std.parseInt(subtexture.att.frameWidth), Std.parseInt(subtexture.att.frameHeight));
			}
			
			addBitmapData(subtexture.att.name, Std.parseInt(subtexture.att.x), Std.parseInt(subtexture.att.y), Std.parseInt(subtexture.att.width), Std.parseInt(subtexture.att.height), size);
		}
	}
	
	function addBitmapData(_name:String, _x:Null<Int>, _y:Null<Int>, _width:Null<Int>, _height:Null<Int>, ?_size:Rectangle) 
	{
		var rect:Rectangle = new Rectangle(_x, _y, _width, _height);
		
		var already_exported = false;
		
		for (added_rect in added_rects)
		{
			if (rect.x == added_rect.x && rect.y == added_rect.y && rect.width == added_rect.width && rect.height == added_rect.height)
			{
				already_exported = true;
				break;
			}
		}
	  
		if (!already_exported)
		{
			var offset = new Point();
			
			if (_size != null)
			{
				_width = Std.int(_size.width);
				_height = Std.int(_size.height);
				
				offset.x = -_size.left;
				offset.y = -_size.top;
			}
			
			var bitmap_data:BitmapData = new BitmapData(_width, _height, true, 0x00000000);
			bitmap_data.copyPixels(spritesheet_bitmap_data, rect, offset, null, null, true);
			
			stage.addSprite(_name, bitmap_data);
			//added_rects.push(rect);
		}
	}
	
}