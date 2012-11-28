package org.parse
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	
	import mx.utils.Base64Encoder;

	public class Parse extends EventDispatcher
	{
		public static const CONFIG :ParseConfig = new ParseConfig();
		public static const PARSE_API :String = "https://api.parse.com/1/classes/";
		public static const CONTENT_TYPE :String = "application/json";
		
		protected var loader :URLLoader = null;
		
		public function Parse()
		{
		}
		
		public function createObject( className:String, object:Object, options:Object ):void
		{
			var request :URLRequest = null;
			
			request = new URLRequest( PARSE_API + className );
			request.method = URLRequestMethod.POST;
			request.contentType = CONTENT_TYPE;
			request.data = JSON.stringify( object );
			request.requestHeaders.push( new URLRequestHeader("X-Parse-Application-Id", CONFIG.applicationId) );
			request.requestHeaders.push( new URLRequestHeader("X-Parse-REST-API-Key", CONFIG.apiKey) );
			
			if ( !loader )
				loader = new URLLoader();
			
			loader.addEventListener(
				Event.COMPLETE,
				function( event:Event ):void
				{
					var result:Object =  JSON.parse( event.target.data );
					
					if( options && options.success )
						options.success.call( null, result );
					
				}
			);
			
			loader.load( request );
		}
		
		public function readObject( className:String, objectId:String, options:Object ):void
		{
			
		}
		
		public function readObjects( className:String, options:Object ):void
		{
			var request :URLRequest = null;
			
			request = new URLRequest( PARSE_API + className );
			request.method = URLRequestMethod.GET;
			request.contentType = CONTENT_TYPE;
			request.requestHeaders.push( new URLRequestHeader("X-Parse-Application-Id", CONFIG.applicationId) );
			request.requestHeaders.push( new URLRequestHeader("X-Parse-REST-API-Key", CONFIG.apiKey) );
			
			if ( !loader )
				loader = new URLLoader();
			
			loader.addEventListener(
				Event.COMPLETE,
				function( event:Event ):void
				{
					var result:Object =  JSON.parse( event.target.data );
					
					if( options && options.success )
						options.success.call( null, result );
					
				}
			);
			
			loader.load( request );
		}
		
		
	}
}