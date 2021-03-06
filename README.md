[AS3Parse]
========

AS3 component for Parse.

Example:
---------

Custom model:

	public class GameScore extends ParseObject
	{
		public var score :Number = 0;
		public var playerName :String = "";
		
		public function GameScore( other:Object = null )
		{
			super( other );
		}
		
		override protected function parse(json:Object):void
		{
			this.score = json.score;
			this.playerName = json.playerName;
	
			super.parse( json );
		}
	}

**CREATE example**:

	Parse.CONFIG.applicationId = ".......";
	Parse.CONFIG.apiKey = "....";
	
	var gameScore :GameScore = new GameScore({
		playerName: "PlayerNameHere",
		score: 20
	});
	
	gameScore.save({
		success: function():void
		{
			console.log( gameScore.objectId() );
		}
	})

**UPDATE example**:

	var gameScore :GameScore = new GameScore({
		objectId: "Kdfffasdf"
	});
	
	gameScore.playerName = "NewName";
	gameScore.save(); // Because it has an objectId the save() function will make an update not create
	
	
**READ example**:

	var gameScore :GameScore = new GameScore({
		objectId: "Kdfffasdf"
	});
	
	gameScore.load({
		success: function() {
			// here we have gameScore loaded from Parse
		}
	});

**LOAD multiple objects example**:

	var gameScores :ParseArrayCollection = new ParseArrayCollection( GameScore ); 
	gameScores.load({
		success: function():void {
			// Here gameScores has a list of GameScores objects
		}
	});
	
**DELETE example**:
	
	var gameScore :GameScore = new GameScore({
		objectId: "7B5gsbk6pb"
	});
	
	gameScore.remove({ success: function():void { ...... }});
