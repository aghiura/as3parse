[AS3Parse]
========

AS3 component for Parse.

Example:
---------

Custom model:

`public class GameScore extends ParseObject
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
}`

Create example:

`Parse.CONFIG.applicationId = ".......";
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
})`