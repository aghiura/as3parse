package org.parse
{
	import flash.events.Event;

	public class ParseEvent extends Event
	{
		public static const OBJECT_CREATE :String = "objectCreate";
		public static const OBJECT_READ :String = "objectRead";
		
		public function ParseEvent( type:String, bubbles:Boolean = false)
		{
			super( type, bubbles );
		}
		
		override public function clone():Event
		{
			return new ParseEvent( type, bubbles );
		}
	}
}