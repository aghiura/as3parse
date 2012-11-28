package org.parse
{
	import flash.utils.getQualifiedClassName;

	public class ParseObject
	{		
		protected var className: String = "";
		protected var isNew :Boolean = true;
		
		private var _objectId: String = "";
		private var _createdAt: String = "";
		
		public function ParseObject( other:Object = null )
		{
			className = getQualifiedClassName( this ).split("::").pop();
			
			if( other )
				parse( other );
		}
		
		public function get objectId():String
		{
			return _objectId;
		}
		
		public function save( options:Object ):void
		{
			sync( "create", options );
		}
		
		protected function parse( json:Object ):void
		{
			this._objectId = json.objectId;
			this._createdAt = json.createdAt;
			
			if( this._objectId )
				this.isNew = false;
		}
		
		protected function sync( op:String, options:Object ):void
		{
			var parse :Parse = new Parse();
			var self :ParseObject = this;
			
			switch( op )
			{
				case "create":
				{
					parse.createObject( className, this.toObject(), {
						success: function( data:Object ):void {
							
							if( data )
							{
								self._objectId = data.objectId;
								self._createdAt = data.createdAt;
								self.isNew = false;
								
								if( options && options.success )
									options.success.call( self );
							}
						},
						
						error: function():void {
							
						}
					});
					break;
				}
					
				case "read":
				{
					parse.readObject( className, objectId, {
						success: function( data:Object ):void {
							
							if( data )
							{
								self.parse( data );
								
								if( options && options.success )
									options.success.call( self );
							}
						}
					});
					break;
				}
			}
		}
		
		public function toObject():Object
		{
			return JSON.parse( JSON.stringify( this ));
		}
	}
}