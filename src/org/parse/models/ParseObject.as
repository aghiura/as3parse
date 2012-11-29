package org.parse.models
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import org.parse.Parse;

	public class ParseObject extends EventDispatcher
	{		
		// Vars
		protected var className: String = "";
		protected var isNew :Boolean = true;
		
		private var _objectId: String = "";
		private var _createdAt: String = "";
		private var _updatedAt: String = "";
		
		// Constructor
		public function ParseObject( other:Object = null )
		{
			className = getQualifiedClassName( this ).split("::").pop();
			
			if( other )
				parse( other );
		}
		
		// Public functions
		public function get objectId():String
		{
			return _objectId;
		}
		
		public function save( options:Object ):void
		{
			if( isNew && _objectId == "" )
				sync( "create", options );
			else
				sync( "update", options );
		}
		
		public function load( options:Object ):void
		{
			sync( "read", options );
		}
		
		public function remove( options:Object ):void
		{
			sync( "delete", options );
		}
		
		public function toObject():Object
		{
			return JSON.parse( JSON.stringify( this ));
		}
		
		// Protected functions
		protected function parse( json:Object ):void
		{
			this._objectId = json.objectId;
			this._createdAt = json.createdAt;
			this._updatedAt = json.updatedAt;
			
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
				
				case "update":
				{
					parse.updateObject( className, this.toObject(), {
						success: function( data:Object ):void
						{
							self._updatedAt = data.updatedAt;
							
							if( options && options.success )
								options.success.call( self );
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
					
				case "delete":
				{
					parse.deleteObject( className, objectId, {
						success: function( data:Object ):void {
							
							if( options && options.success )
								options.success.call( self );
						},
						
						error: function( msg:String ):void
						{
							if( options && options.error )
								options.error.call( self, msg );
						}
					});
					break;
				}
			}
		}
	}
}