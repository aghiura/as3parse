package org.parse.events
{
	import flash.events.Event;

	public class ParseObjectEvent extends Event
	{
		public function ParseObjectEvent( type:String, bubbles:Boolean = false)
		{
			super( type, bubbles );
		}
		
		override public function clone():Event
		{
			return new ParseObjectEvent( type, bubbles );
		}
	}
}