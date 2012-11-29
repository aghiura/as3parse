package org.parse.models
{
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import org.parse.Parse;

	public class ParseArrayCollection extends ArrayCollection
	{
		private var model :Class = null;
		private var className :String = "";
		
		public function ParseArrayCollection( model:Class )
		{
			super();
			
			this.model = model;
			this.className = getQualifiedClassName( new model() ).split("::").pop();
		}
		
		public function load( options:Object ):void
		{
			sync("read", options);
		}
		
		protected function parse( json:Object ):void
		{
			if( json && json.results )
			{
				for( var i:uint=0; i< json.results.length; i++ )
				{
					var item :Object = json.results[i];
					
					// Add new model
					addItem( new model( item ));
				}
			}
		}
		
		protected function sync( op:String, options:Object ):void
		{
			var parse :Parse = new Parse();
			var self :ParseArrayCollection = this;

			switch( op )
			{
				case "create":
				{
					break;
				}
					
				case "read":
				{
					parse.readObjects( className, {
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
	}
}