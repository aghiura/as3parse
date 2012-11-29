package org.parse
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
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
		
		/**
		 * Create an object.
		 * 
		 * @param className
		 * @param object
		 * @param options
		 * 
		 **/
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
		
		public function updateObject( className:String, object:Object, options:Object ):void
		{
			var request :URLRequest = null;
			
			request = new URLRequest( PARSE_API + className + "/" + object.objectId );
			request.method = URLRequestMethod.PUT;
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
					var result :Object =  JSON.parse( event.target.data );
					
					if( options && options.success )
						options.success.call( null, result );
					
				}
			);
			
			loader.load( request );
		}
		
		public function deleteObject( className:String, objectId:String, options:Object ):void
		{
			var request :URLRequest = null;
			
			request = new URLRequest( PARSE_API + className + "/" + objectId );
			request.method = URLRequestMethod.DELETE;
			request.requestHeaders.push( new URLRequestHeader("X-Parse-Application-Id", CONFIG.applicationId) );
			request.requestHeaders.push( new URLRequestHeader("X-Parse-REST-API-Key", CONFIG.apiKey) );
			
			if ( !loader )
				loader = new URLLoader();
			
			loader.addEventListener(
				Event.COMPLETE,
				function( event:Event ):void
				{
					var result :Object =  JSON.parse( event.target.data );
					
					if( options && options.success )
						options.success.call( null, result );
					
				}
			);
			
			loader.addEventListener(
				IOErrorEvent.IO_ERROR,
				function( event:Event ):void
				{
					if( options && options.error )
						options.error.call( null, IOErrorEvent( event ).text );	
				}
			);
			
			loader.load( request );
		}
		
		/**
		 * Read object information by id.
		 * 
		 * @param className
		 * @param objectId
		 * @param options
		 *
		 **/
		public function readObject( className:String, objectId:String, options:Object ):void
		{
			var request :URLRequest = null;
			
			request = new URLRequest( PARSE_API + className + "/" + objectId );
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
					var result :Object =  JSON.parse( event.target.data );
					
					if( options && options.success )
						options.success.call( null, result );
					
				}
			);
			
			loader.load( request );
		}
		
		/**
		 * Read all objects
		 * 
		 * @param className
		 * @param options
		 * 
		 **/
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